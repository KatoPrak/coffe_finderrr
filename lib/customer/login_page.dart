import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_finder/components/bottom_navigation_bar.dart';
import 'package:coffe_finder/components/navbar-toko.dart';
import 'package:coffe_finder/customer/register_page.dart';
import 'package:coffe_finder/customer/tentang-cafe.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffe_finder/customer/forgot_page.dart';
import 'package:coffe_finder/components/my_textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  Future signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        User user = userCredential.user!;
        String userEmail = user.email!;
        String userRole = await getUserRole(userEmail);

        if (userRole == 'Pelanggan') {
          print(user);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavBarDemo(),
            ),
          );
          print('Login berhasil!');
          Fluttertoast.showToast(
            msg: "Login berhasil!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (userRole == 'Pemilik Toko') {
          print(user);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavBarToko(),
            ),
          );
          Fluttertoast.showToast(
            msg: "Login berhasil!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } catch (e) {
        // Menampilkan notifikasi login gagal
        print("Error during login: $e");
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
                  Text('Login Gagal'),
                ],
              ),
              content: const Text('Email dan Password Salah!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup notifikasi
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Menampilkan notifikasi form tidak boleh kosong
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
            content: const Text('Email dan Password Tidak Boleh Kosong!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup notifikasi
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<String> getUserRole(String email) async {
    try {
      // Lakukan query ke Firestore atau sumber data lainnya untuk mendapatkan data pengguna
      // Misalnya, kita memiliki koleksi 'users' dengan dokumen berisi informasi peran ('role') pengguna
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (usersSnapshot.docs.isNotEmpty) {
        // Ambil nilai peran dari dokumen pertama (sebagai contoh, Anda bisa menambahkan logika lebih lanjut sesuai kebutuhan)
        String userRole = usersSnapshot.docs.first.get('role');
        return userRole;
      } else {
        // Handle jika dokumen tidak ditemukan
        return 'unknown'; // atau berikan nilai default yang sesuai
      }
    } catch (e) {
      // Handle error jika terjadi kesalahan saat mengambil data dari Firestore
      print("Error fetching user role: $e");
      return 'unknown'; // atau berikan nilai default yang sesuai
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          children: <Widget>[
            const SizedBox(height: 50),
            Image.asset(
              'lib/images/logo.png',
              alignment: Alignment.center,
              width: 200.0,
              height: 200.0,
            ),
            const SizedBox(height: 50),

            // email controller
            MyTextField(
              controller: _emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(height: 50),

            // password textfield
            MyTextField(
              controller: _passwordController,
              hintText: 'Password',
              obscureText: !_passwordVisible,
              suffixIcon: IconButton(
                color: Colors.brown,
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 4),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPass(),
                      ),
                    );
                  },
                  child: const Text(
                    'Lupa Password?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 27, 29, 31),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),

            AnimatedButton(onTap: signIn),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Belum Punya Akun?',
                  style: TextStyle(color: Color.fromARGB(255, 97, 97, 97)),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(
                          title: 'Registration',
                          showLoginPage: () {},
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Daftar Sekarang',
                    style: TextStyle(
                      color: Color.fromARGB(255, 27, 29, 31),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  final VoidCallback onTap;

  const AnimatedButton({Key? key, required this.onTap}) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  late double _scale;

  @override
  void initState() {
    super.initState();
    _scale = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _animateButton();
        widget.onTap();
      },
      splashFactory: InkRipple.splashFactory,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.identity()..scale(_scale),
            child: const Text(
              "Masuk",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _animateButton() {
    setState(() {
      _scale = 0.95;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _scale = 1.0;
      });
    });
  }
}
