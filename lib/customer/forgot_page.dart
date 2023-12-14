import 'package:flutter/material.dart';
import 'package:coffe_finder/components/my_textfield.dart';
import 'package:coffe_finder/customer/login_page.dart';

class ForgotPass extends StatelessWidget {
  ForgotPass({Key? key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF6F0E9),
        appBar: AppBar(
          backgroundColor: Color(0xFF804A20),
          elevation: 0,
          toolbarHeight: 83,
          title: const Text(
            'Lupa Password',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView(
          // Use a ListView to make the content scrollable
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          children: <Widget>[
            const SizedBox(height: 100),

            const Center(
              child: Text(
                'Masukkan Email Address',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // username textfield
            MyTextField(
              controller: usernameController,
              hintText: 'example@gmail.com',
              obscureText: false,
            ),
            const SizedBox(height: 150),
            // not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Kembali Ke',
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
                        ), // Corrected the class name
                      ),
                    );
                  },
                  child: const Text(
                    'login',
                    style: TextStyle(
                      color: Color.fromARGB(255, 27, 29, 31),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            AnimatedButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(
                      showRegisterPage: () {},
                    ), // Corrected the class name
                  ),
                );
              },
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
  late double _opacity;

  @override
  void initState() {
    super.initState();
    _opacity = 1.0;
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
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _opacity,
            child: const Text(
              "Berikutnya",
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
    if (mounted) {
      setState(() {
        _opacity = 0.5;
      });

      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          setState(() {
            _opacity = 1.0;
          });
        }
      });
    }
  }
}
