import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PromoPage1(),
    );
  }
}

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
      body: PromoList(),
    );
  }
}

class PromoList extends StatelessWidget {
  const PromoList({
    Key? key,
  }) : super(key: key);

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
        SliverFillRemaining(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('promo').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return Promo(
                    gambar: data['gambar'], // URL or path to the image
                    namePromo: data['judul'], // Title of the promo
                    username: data['username'], // Username from Firestore
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Promo extends StatelessWidget {
  final String gambar;
  final String namePromo;
  final String username;

  const Promo({
    Key? key,
    required this.gambar,
    required this.namePromo,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Implement action when promo is tapped
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
              gambar,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                // Use Row instead of Column
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: GoogleFonts.rubik(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '|',
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                      width: 5), // Add some space between the two Text widgets
                  Text(
                    namePromo,
                    style: GoogleFonts.rubik(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
