import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(
      home: PromoPage1(),
    ));

class PromoPage1 extends StatefulWidget {
  const PromoPage1({Key? key}) : super(key: key);

  @override
  State<PromoPage1> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage1> {
  String? uid = '';
  String combinedData = ''; // Untuk menyimpan hasil penggabungan data

  Future<String> user() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.currentUser?.uid ?? '';
  }

  Future<void> joinCollections() async {
    try {
      // Ambil data dari koleksi 'promo' berdasarkan UID
      QuerySnapshot promoSnapshot = await FirebaseFirestore.instance
          .collection('promo')
          .where('uid', isEqualTo: uid)
          .get();

      // Ambil data dari koleksi 'users' berdasarkan UID
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      // Buat peta untuk menyimpan data pengguna
      Map<String, dynamic> usersData = {};

      // Proses data dari koleksi 'users'
      usersSnapshot.docs.forEach((usersDoc) {
        usersData = usersDoc.data() as Map<String, dynamic>;
      });

      // Gabungkan data dari kedua koleksi
      promoSnapshot.docs.forEach((promoDoc) {
        // Ambil atribut yang Anda butuhkan dari dokumen promo
        String imagePromo = promoDoc['gambar'] ??
            ''; // Menggunakan '' jika 'gambar' adalah null
        String judulPromo =
            promoDoc['judul'] ?? ''; // Menggunakan '' jika 'judul' adalah null

        // Gunakan data pengguna yang telah diambil sebelumnya
        String username = usersData['username'] ??
            ''; // Menggunakan '' jika 'username' adalah null

        // Tambahkan data yang telah digabungkan ke combinedData
        combinedData += 'Nama User: $username\n';
        combinedData += 'Judul Promo: $judulPromo\n';
        combinedData += 'Gambar Promo: $imagePromo\n';
        combinedData += '\n'; // Tambahkan pemisah antara data
      });

      // Setelah menggabungkan data, perbarui tampilan jika diperlukan
      setState(() {});
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    user().then((value) {
      setState(() {
        uid = value;
      });
      joinCollections(); // Panggil fungsi joinCollections setelah mendapatkan UID.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        automaticallyImplyLeading: false,
        title: Text(
          "Promo",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF804A20),
        elevation: 0,
      ),
      body: PromoList(combinedData: combinedData),
    );
  }
}

class PromoList extends StatelessWidget {
  final String
      combinedData; // Terima hasil penggabungan data dari _PromoPageState

  PromoList({required this.combinedData});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
              left: 10,
              right: 10,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 170, 170, 170),
                    width: 2.0,
                  ),
                ),
                child: Image.asset(
                  "lib/images/ilustrasii.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Daftar Promo seru ☕️",
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              // Split combinedData menjadi baris-baris
              for (var data in combinedData.split('\n'))
                if (data.isNotEmpty) // Memastikan tidak ada baris kosong
                  PromoCard(data: data),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class PromoCard extends StatelessWidget {
  final String data;

  PromoCard({required this.data});

  @override
  Widget build(BuildContext context) {
    // Pisahkan data menjadi atribut yang sesuai
    var parts = data.split('\n');
    var nameToko = parts[0].substring('Nama User: '.length);
    var namePromo = parts[1].substring('Judul Promo: '.length);
    var imagePromo = parts[2].substring('Gambar Promo: '.length);

    return InkWell(
      onTap: () {
        // Tambahkan tindakan yang ingin diambil ketika item promo diklik di sini
        // Contoh: Navigasi ke halaman detail promo
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        child: Column(
          children: [
            Image.network(
              imagePromo, // Menggunakan URL gambar dari Firebase Storage
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameToko,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      namePromo,
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
