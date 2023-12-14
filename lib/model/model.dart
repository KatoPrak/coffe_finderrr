import 'package:flutter/material.dart';

class Toko {
  String idToko;
  String idMenu;
  String idVoucher;
  String idUlasan;
  String category;
  String alamat;
  String imageMenu;
  String imageToko;
  String descriptionMenu;
  String nameMenu;
  String nameToko;
  String namePelanggan;
  String titikKoordinat;
  String email;
  IconData icon;
  String rating;
  double price;
  double nomorTelepon;

  // Make idToko required in the constructor
  Toko({
    required this.idToko,
    required this.idMenu,
    required this.idVoucher,
    required this.idUlasan,
    required this.category,
    required this.alamat,
    required this.imageToko,
    required this.imageMenu,
    required this.nameToko,
    required this.nameMenu,
    required this.descriptionMenu,
    required this.namePelanggan,
    required this.titikKoordinat,
    required this.email,
    required this.icon,
    required this.rating,
    required this.price,
    required this.nomorTelepon,
  });
}

List<Toko> terdekat = [
  Toko(
    idToko: '1',
    nameToko: 'Starbucks',
    alamat: 'Rp15.000',
    rating: '5',
    imageToko: 'lib/images/RimbunKopi/Caffelatte.jpg',
    idMenu: '1',
    idVoucher: '1',
    idUlasan: '1',
    category: 'Kopi Panas',
    imageMenu: 'lib/images/RimbunKopi/steak.jpg',
    nameMenu: 'steak',
    descriptionMenu: 'enak sekali',
    namePelanggan: 'irvan',
    titikKoordinat: '3142352',
    email: 'irvan@gmail.com',
    icon: Icons.abc,
    price: 1500,
    nomorTelepon: 82352,
  ),
  Toko(
    idToko: '2',
    nameToko: 'Hokben',
    alamat: 'Rp15.000',
    rating: '5',
    imageToko: 'lib/images/RimbunKopi/MikanAme.jpg',
    idMenu: '2',
    idVoucher: '2',
    idUlasan: '2',
    category: 'Kopi Dingin',
    imageMenu: 'lib/images/RimbunKopi/Karolina.jpg',
    nameMenu: 'Susu Coklat',
    descriptionMenu: 'kiko enak tau',
    namePelanggan: 'Yanto',
    titikKoordinat: '2354632',
    email: 'bandar@gmai.com',
    icon: Icons.abc_outlined,
    price: 15800,
    nomorTelepon: 828352,
  ),
  // Add more Ice Coffee products as needed
];
