import 'dart:convert';
import 'package:coffe_finder/customer/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffe_finder/components/my_textfield.dart';
import 'package:coffe_finder/components/my_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crypto/crypto.dart';

String selectedRole = 'Pilih Role';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage(
      {Key? key, required this.showLoginPage, required String title})
      : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    final localContext = context; // Store the context in a local variable

    if (isFormValid()) {
      // Memeriksa apakah alamat email sudah terdaftar
      try {
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Jika berhasil mendaftar, userCredential akan berisi informasi pengguna yang baru dibuat
        if (userCredential.user != null) {
          // Simpan data pengguna
          await saveUserData(
            _usernameController.text.trim(),
            _emailController.text.trim(),
            _passwordController.text.trim(),
            selectedRole,
          );

          Fluttertoast.showToast(
            msg: "Registrasi berhasil!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          Navigator.push(
            localContext,
            MaterialPageRoute(
              builder: (context) => LoginPage(
                showRegisterPage: () {},
              ),
            ),
          );
        } else {
          // Jika userCredential.user == null, ini berarti ada masalah saat mendaftar
          Fluttertoast.showToast(
            msg: "Gagal melakukan registrasi. Silakan coba lagi.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } catch (e) {
        // Tangani kesalahan saat mendaftar
        if (e is FirebaseAuthException) {
          if (e.code == 'email-already-in-use') {
            Fluttertoast.showToast(
              msg: "Alamat email sudah terdaftar. Gunakan alamat email lain.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else {
            Fluttertoast.showToast(
              msg: "Gagal melakukan registrasi. Silakan coba lagi.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } else {
          print("Error during registration: $e");
          Fluttertoast.showToast(
            msg: "Gagal melakukan registrasi. Silakan coba lagi.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    }
  }

  Future<void> saveUserData(
      String username, String email, String password, String role) async {
    try {
      const String salt = "generate_random_salt_here";
      final String hashedPassword =
          sha256.convert(utf8.encode("$password$salt")).toString();

      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(email).set({
        'username': username,
        'email': email,
        'password': hashedPassword,
        'role': role,
      });
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  bool isPasswordStrong(String password) {
    bool hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    bool hasMinLength = password.length >= 8;
    return hasUpperCase && hasMinLength;
  }

  bool isFormValid() {
    if (_usernameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _confirmpasswordController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(width: 5),
                Text('Peringatan'),
              ],
            ),
            content: const Text('Semua Formulir Harus diisi!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    } else if (!passwordConfirmed()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(width: 5),
                Text('Peringatan'),
              ],
            ),
            content: const Text('Password dan Konfirmasi Password Harus Sama!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    } else if (!isPasswordStrong(_passwordController.text.trim())) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(width: 5),
                Text('Peringatan'),
              ],
            ),
            content: const Text(
                'Password harus minimal 8 karakter dan mengandung huruf kapital.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    } else {
      return true;
    }
  }

  bool passwordConfirmed() {
    return _passwordController.text.trim() ==
        _confirmpasswordController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          children: <Widget>[
            const SizedBox(height: 60),
            Image.asset(
              'lib/images/logo.png',
              alignment: Alignment.center,
              width: 200.0,
              height: 200.0,
            ),
            const SizedBox(height: 42),

            // username textfield
            MyTextField(
              controller: _usernameController,
              hintText: 'Nama Lengkap',
              obscureText: false,
            ),
            const SizedBox(height: 42),

            // email textfield
            MyTextField(
              controller: _emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(height: 42),

            // password textfield
            MyTextField(
              controller: _passwordController,
              hintText: 'Password',
              obscureText:
                  !_passwordVisible, // Menggunakan nilai _passwordVisible untuk menentukan apakah password terlihat atau tidak
              suffixIcon: IconButton(
                color: Colors.brown,
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible =
                        !_passwordVisible; // Mengubah nilai _passwordVisible saat tombol mata disentuh
                  });
                },
              ),
            ),
            const SizedBox(height: 42),

            // confirm password textfield
            MyTextField(
              controller: _confirmpasswordController,
              hintText: 'Konfirmasi Password',
              obscureText:
                  !_confirmPasswordVisible, // Menggunakan nilai _confirmPasswordVisible untuk menentukan apakah konfirmasi password terlihat atau tidak
              suffixIcon: IconButton(
                color: Colors.brown,
                icon: Icon(
                  _confirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _confirmPasswordVisible =
                        !_confirmPasswordVisible; // Mengubah nilai _confirmPasswordVisible saat tombol mata disentuh
                  });
                },
              ),
            ),
            const SizedBox(height: 42),

            RoleDropdown(
              selectedRole: selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  selectedRole = newValue!;
                });
              },
            ),
            const SizedBox(height: 42),

            AnimatedButton(
              onTap: signUp,
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sudah Punya Akun?',
                  style: TextStyle(color: Color.fromARGB(255, 97, 97, 97)),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(
                          showRegisterPage: () {},
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Masuk',
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
              "Daftar",
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
