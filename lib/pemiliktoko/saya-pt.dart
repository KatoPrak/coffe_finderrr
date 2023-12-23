import 'package:coffe_finder/pemiliktoko/data-toko.dart';
import 'package:coffe_finder/pemiliktoko/kelola-toko.dart';
import 'package:flutter/material.dart';

class PemilikTokoPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F0E9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 114,
              decoration: BoxDecoration(
                color: Color.fromARGB(220, 137, 25, 5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 25, 20, 0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('lib/images/starbucks.jpeg'),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Starbucks',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Starbucks@gmail.com',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Pemilik Toko',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Divider(
              thickness: 1,
              color: Colors.grey,
              indent: 20,
              endIndent: 20,
            ),
            buildMenuItem(Icons.settings, 'Pengaturan',PemilikTokoPage1(),context),
            Divider(
              thickness: 1,
              color: Colors.grey,
              indent: 20,
              endIndent: 20,
            ),
            buildMenuItem(
                Icons.store, 'Kelola Toko',KelolaToko(),context), // Ubah ikon menjadi bisnis
            Divider(
              thickness: 1,
              color: Colors.grey,
              indent: 20,
              endIndent: 20,
            ),
            buildMenuItem(Icons.logout, 'Logout',PemilikTokoPage1(),context),
            Divider(
              thickness: 1,
              color: Colors.grey,
              indent: 20,
              endIndent: 20,
            ),
            // Tambahkan konten lain sesuai kebutuhan Anda
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String title, Widget route,BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigasi ke halaman lain saat item menu ditekan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => route,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: PemilikTokoPage1(),
    );
  }
}
