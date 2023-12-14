import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_offer),
          label: 'Promo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Saya',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.black,
      onTap: onItemTapped,
    );
  }
}
