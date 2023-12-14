import 'package:coffe_finder/customer/home-page.dart';
import 'package:coffe_finder/customer/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffe_finder/customer/forgot_page.dart';
import 'package:coffe_finder/components/my_textfield.dart';

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
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Jika login berhasil, navigasikan ke halaman home_page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseScreen(),
          ),
        );
      } catch (e) {
        // Handle kesalahan login di sini, misalnya menampilkan pesan kesalahan
        print("Error during login: $e");
        // Tambahkan logika atau notifikasi tambahan jika diperlukan
      }
    } else {
      // Jika formulir tidak lengkap, tampilkan notifikasi
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Peringatan'),
            content: Text('Email dan password harus diisi.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup notifikasi
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
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
                SizedBox(width: 4),
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

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _scale = 1.0;
      });
    });
  }
}
