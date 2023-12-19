import 'package:coffe_finder/customer/home-page.dart';
import 'package:coffe_finder/pemiliktoko/dashboard-pt.dart';
import 'package:flutter/material.dart';
import 'package:coffe_finder/components/bottom_navigation_bar.dart'; // Import the new file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Akun(), // Ganti halaman utama dengan Akun()
    );
  }
}

class Akun extends StatefulWidget {
  const Akun({Key? key}) : super(key: key);

  @override
  State<Akun> createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    BerandaPage(),
    PromoList(),
    SayaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F0E9),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

// Halaman Beranda
class BerandaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dashboard(),
    );
  }
}

class PromoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PromoPage(),
    );
  }
}

// Halaman Saya
class SayaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F0E9),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                          backgroundImage:
                              AssetImage('lib/images/profile-guest.png'),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Irvan Ronaldi',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'irvan@gmail.com',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Customer',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 29, 25, 0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
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
                buildMenuItem(Icons.settings, 'Pengaturan'),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                ),
                buildMenuItem(Icons.logout, 'Logout'),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                ),
                // Add other content as needed
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String title) {
    return InkWell(
      onTap: () {
        // Logic when menu item is pressed
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
