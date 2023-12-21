import 'package:coffe_finder/auth/auth_page.dart';
import 'package:coffe_finder/customer/edit-profile_page.dart';
import 'package:coffe_finder/customer/forgot_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Akun extends StatefulWidget {
  const Akun({Key? key}) : super(key: key);

  @override
  State<Akun> createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  String username = '';
  String userEmail = '';
  String userRole = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .get();

        setState(() {
          username = userDoc['username'] ?? '';
          userEmail = user.email ?? '';
          userRole = userDoc['role'] ?? '';
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
                          backgroundImage:
                              AssetImage('lib/images/profile-guest.png'),
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
                buildMenuItem(Icons.edit, 'Edit Profile', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  );
                }),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                ),
                buildMenuItem(Icons.lock, 'Ubah Password', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPass(),
                    ),
                  );
                }),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                ),
                buildMenuItem(Icons.info, 'Tentang', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  );
                }),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                ),
                buildMenuItem(Icons.logout, 'Logout', () {
                  _showLogoutConfirmationDialog(context);
                }),
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

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.red,
              ),
              SizedBox(width: 5),
              Text('Peringatan'),
            ],
          ),
          content: Text('Apakah Anda yakin ingin logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                await _signOut(context);
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Widget buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
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

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    print('Logout berhasil!');
    Fluttertoast.showToast(
      msg: 'Logout berhasil!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthPage(),
      ),
    );
  }
}
