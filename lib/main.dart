import 'package:coffe_finder/auth/auth_page.dart';
import 'package:coffe_finder/customer/home-page.dart';
import 'package:coffe_finder/customer/promo-page.dart';
import 'package:coffe_finder/pemiliktoko/buat-promo.dart';
import 'package:coffe_finder/pemiliktoko/data-toko.dart';
import 'package:coffe_finder/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
