import 'package:coffe_finder/customer/promo-page.dart';
import 'package:coffe_finder/pemiliktoko/dashboard-pt.dart';
import 'package:coffe_finder/pemiliktoko/saya-pt.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavBarToko(),
    );
  }
}

class BottomNavBarToko extends StatefulWidget {
  @override
  _BottomNavBarTokoState createState() => _BottomNavBarTokoState();
}

class _BottomNavBarTokoState extends State<BottomNavBarToko> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    BerandaPage(),
    PromoPage(),
    PemilikTokoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor:
            Colors.brown, // Ubah warna ikon saat terpilih menjadi coklat
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.discount),
            label: 'Promo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Saya',
          ),
        ],
      ),
    );
  }
}

class BerandaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DashboardScreen(),
    );
  }
}

class PromoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PromoPage1(),
    );
  }
}

class PemilikTokoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PemilikTokoPage1(),
    );
  }
}
