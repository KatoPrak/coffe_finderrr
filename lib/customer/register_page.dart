import 'package:coffe_finder/customer/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffe_finder/components/my_textfield.dart';
import 'package:coffe_finder/components/my_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  // text controller
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (isFormValid()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Save user data to the database
        await saveUserData(
          _usernameController.text.trim(),
          _emailController.text.trim(),
          selectedRole,
        );

        // Navigate to the login page after successful registration
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(
              showRegisterPage: () {},
            ),
          ),
        );
      } catch (e) {
        // Display an error message for registration failure
        print("Error during registration: $e");
      }
    }
  }

  Future<void> saveUserData(String username, String email, String role) async {
    try {
      // Assuming you have a Firestore instance
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Save user data to the "users" collection
      await firestore.collection('users').doc(email).set({
        'username': username,
        'email': email,
        'role': role,
      });
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  bool isFormValid() {
    if (_usernameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _confirmpasswordController.text.trim().isEmpty) {
      // Tampilkan notifikasi jika ada form yang kosong
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Peringatan'),
            content: Text('Semua formulir harus diisi.'),
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
      return false;
    } else if (!passwordConfirmed()) {
      // Tampilkan notifikasi jika password tidak sesuai
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Peringatan'),
            content: Text('Password dan konfirmasi password harus sama.'),
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
            const SizedBox(height: 42),

            // confirm password textfield
            MyTextField(
              controller: _confirmpasswordController,
              hintText: 'Konfirmasi Password',
              obscureText: !_passwordVisible,
              suffixIcon: IconButton(
                color: Colors.blue,
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
                SizedBox(width: 4),
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

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _scale = 1.0;
      });
    });
  }
}
