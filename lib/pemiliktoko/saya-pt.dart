import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_finder/pemiliktoko/kelola-toko.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PemilikTokoPage1 extends StatefulWidget {
  const PemilikTokoPage1({Key? key}) : super(key: key);

  @override
  State<PemilikTokoPage1> createState() => _PemilikTokoPage1State();
}

class _PemilikTokoPage1State extends State<PemilikTokoPage1> {
  String username = '';
  String userEmail = '';
  String userRole = '';
  String fotoUrl = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        // Menggunakan user.uid sebagai dokumen ID karena nampaknya data-toko disimpan berdasarkan UID pengguna
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .get();

        final DocumentSnapshot dataTokoDoc = await FirebaseFirestore.instance
            .collection('datatoko')
            .doc(user.uid)
            .get();

        setState(() {
          username = userDoc['username'];
          userEmail = user.email ?? '';
          userRole = userDoc['role'] ?? '';
          fotoUrl = dataTokoDoc['profile'] as String? ?? '';
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

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
                          backgroundImage: fotoUrl != null && fotoUrl.isNotEmpty
                              ? NetworkImage(fotoUrl)
                              : Image.asset('lib/images/profile-guest.png')
                                  .image,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '$username',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: 'Rubik',
                                    letterSpacing: 1.2,
                                    // gaya teks
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Row(
                              children: [
                                Text(
                                  '$userEmail',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: 'Rubik',
                                    letterSpacing: 1.2,
                                    // gaya teks
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Row(
                              children: [
                                Text(
                                  '$userRole',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: 'Rubik',
                                    letterSpacing: 1.2,
                                    // gaya teks
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
                SizedBox(height: 30),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                ),
                buildMenuItem(
                    Icons.settings, 'Pengaturan', PemilikTokoPage1(), context),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                ),
                buildMenuItem(Icons.store, 'Kelola Toko', KelolaToko(),
                    context), // Ubah ikon menjadi bisnis
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                ),
                buildMenuItem(
                    Icons.logout, 'Logout', PemilikTokoPage1(), context),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(
      IconData icon, String title, Widget route, BuildContext context) {
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
