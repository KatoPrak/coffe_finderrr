import 'dart:async';
import 'package:coffe_finder/customer/akun-page.dart';
import 'package:coffe_finder/customer/home-page.dart';
import 'package:flutter/material.dart'; // Import your main home page or any other page you want to navigate to after the splash screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 2 seconds and then navigate to the home page
    Timer(
      Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Akun()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your logo or any splash screen content goes here
            Image.asset(
              'lib/images/logo2.png',
              width: 250, // Set the width to 150
              height: 250, // Set the height to 150
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
