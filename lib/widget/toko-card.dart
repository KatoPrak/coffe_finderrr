import 'package:coffe_finder/customer/tentang-cafe.dart';
import 'package:flutter/material.dart';
import 'package:coffe_finder/model/model.dart';
import 'package:image_card/image_card.dart'; // Pastikan mengganti impor ini sesuai dengan struktur proyek Anda

class TokoCard extends StatelessWidget {
  final Toko toko;

  const TokoCard({Key? key, required this.toko}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman AboutCafe saat card ditekan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AboutCafe(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Gambar disini
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                toko.imageToko,
                fit: BoxFit.cover,
                height: 80,
                width: 80,
              ),
            ),
            SizedBox(width: 15.0),
            // Teks disini
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    toko.nameToko,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    toko.alamat,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Text(
                        toko.rating,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
