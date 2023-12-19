import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class PromoPage1 extends StatefulWidget {
  const PromoPage1({Key? key}) : super(key: key);

  @override
  State<PromoPage1> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage1> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: Text(
          "Promo",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Set the text color to white
          ),
        ),
        backgroundColor: Color(0xFF804A20), // Set the app bar color
        elevation: 0,
      ),
      body: PromoList(),
    );
  }
}

// Halaman Promo (Dibuat sebagai widget terpisah untuk memudahkan)
class PromoList extends StatelessWidget {
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
            ), // Tambahkan jarak atas dan bawah
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(25), // Border radius kanan bawah
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(
                        255, 170, 170, 170), // Warna garis pinggir
                    width: 2.0, // Lebar garis pinggir
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
            padding:
                const EdgeInsets.all(10), // Tambahkan jarak 10 pada semua sisi
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
              Promo(
                imagePromo: "lib/images/ilustrasi.jpg",
                nameToko: "Kopi Kenangan",
                namePromo: "Beli 2 Gratis 1",
                idPromo: "1",
              ),
              Promo(
                imagePromo: "lib/images/promo1.jpeg",
                nameToko: "Toko Kenanganku",
                namePromo: "Promo spesial Weekend",
                idPromo: "2",
              ),
              Promo(
                imagePromo: "lib/images/promo2.webp",
                nameToko: "Starbucks",
                namePromo: "Beli 1 Gratis 1",
                idPromo: "3",
              ),
              SizedBox(height: 20), // Tambahkan jarak vertikal sebesar 20
            ],
          ),
        ),
      ],
    );
  }
}

class Promo extends StatelessWidget {
  final String imagePromo;
  final String nameToko;
  final String namePromo;
  final String idPromo;

  const Promo({
    Key? key,
    required this.imagePromo,
    required this.nameToko,
    required this.namePromo,
    required this.idPromo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Image.asset(
              imagePromo,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment:
                    Alignment.centerLeft, // Posisikan teks ke kiri (start)
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
