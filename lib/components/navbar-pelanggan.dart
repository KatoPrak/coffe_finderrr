import 'package:coffe_finder/customer/akun-page.dart';
import 'package:coffe_finder/customer/home-page.dart';
import 'package:coffe_finder/customer/promo-page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavBarDemo(),
    );
  }
}

class BottomNavBarDemo extends StatefulWidget {
  @override
  _BottomNavBarDemoState createState() => _BottomNavBarDemoState();
}

class _BottomNavBarDemoState extends State<BottomNavBarDemo> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    BerandaPage(),
    PromoPage(),
    Akun(),
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
      child: Dashboard(),
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

class Akun1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Akun(),
    );
  }
}
