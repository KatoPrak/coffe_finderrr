import 'package:coffe_finder/pemiliktoko/data-toko.dart';
import 'package:coffe_finder/pemiliktoko/buat-menu.dart';
import 'package:coffe_finder/pemiliktoko/buat-promo.dart';
import 'package:coffe_finder/pemiliktoko/foto-toko.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KelolaToko(),
    );
  }
}

class KelolaToko extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xff804A20),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
          },
        ),
        title: Text('Kelola Toko'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BuatMenuPage()), // Navigate to TambahMenu
                );
                // Navigasi ke halaman Tambah Menu
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
                backgroundColor: Color(0xffD7B48F), // Warna latar belakang
                onPrimary: Colors.black, // Warna teks
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Tambahkan BorderRadius di sini
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Buat Menu',
                    style: TextStyle(
                      fontSize: 17.0, // Ukuran font
                      fontWeight: FontWeight.bold, // Kekuatan font
                      color: Colors.black, // Warna teks
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),

            SizedBox(height: 20), // Menambahkan spasi antar tombol
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BuatPromo()), // Navigate to TambahMenu
                );
                // Navigasi ke halaman Buat Promo
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
                backgroundColor: Color(0xffD7B48F), // Warna latar belakang
                onPrimary: Colors.black, // Warna teks
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Tambahkan BorderRadius di sini
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Buat Promo',
                    style: TextStyle(
                      fontSize: 17.0, // Ukuran font
                      fontWeight: FontWeight.bold, // Kekuatan font
                      color: Colors.black, // Warna teks
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FotoToko()), // Navigate to TambahMenu
                );
                // Navigasi ke halaman Tambahkan Foto Toko
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
                backgroundColor: Color(0xffD7B48F), // Warna latar belakang
                onPrimary: Colors.black, // Warna teks
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Tambahkan BorderRadius di sini
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Tambahkan Foto Toko',
                    style: TextStyle(
                      fontSize: 17.0, // Ukuran font
                      fontWeight: FontWeight.bold, // Kekuatan font
                      color: Colors.black, // Warna teks
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Fasilitas()), // Navigate to TambahMenu
                );
                // Navigasi ke halaman Tambahkan Fasilitas & Jam Operasional
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
                backgroundColor: Color(0xffD7B48F), // Warna latar belakang
                onPrimary: Colors.black, // Warna teks
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Tambahkan BorderRadius di sini
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Tambahkan fasilitas & Jam operasional',
                    style: TextStyle(
                      fontSize: 17.0, // Ukuran font
                      fontWeight: FontWeight.bold, // Kekuatan font
                      color: Colors.black, // Warna teks
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
