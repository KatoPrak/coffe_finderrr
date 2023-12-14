import 'package:flutter/material.dart';
import 'package:coffe_finder/model/model.dart'; // Pastikan path ini benar untuk model Toko Anda

class PromoPage extends StatelessWidget {
  final List<Toko> listToko = [
    // Tambahkan data Toko di sini atau dapatkan dari database/model Anda
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promo'),
      ),
      body: ListView.builder(
        itemCount: listToko.length,
        itemBuilder: (context, index) {
          Toko toko = listToko[index];
          return PromoCard(toko: toko);
        },
      ),
    );
  }
}

class PromoCard extends StatelessWidget {
  final Toko toko;

  const PromoCard({Key? key, required this.toko}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Aksi ketika card di-tap. Contoh: navigasi ke detail halaman.
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(toko: toko)),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          leading: Image.asset(toko.imageToko, width: 100, height: 100, fit: BoxFit.cover),
          title: Text(toko.nameToko),
          subtitle: Text(toko.descriptionMenu),
          trailing: Text('Rp${toko.price.toString()}'),
        ),
      ),
    );
  }
}

// Contoh halaman detail yang mungkin ingin Anda navigasi
class DetailPage extends StatelessWidget {
  final Toko toko;

  const DetailPage({Key? key, required this.toko}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(toko.nameToko),
      ),
      body: Center(
        child: Text('Detail dari ${toko.nameToko}'),
        // Anda bisa menambahkan lebih banyak informasi toko di sini
      ),
    );
  }
}
