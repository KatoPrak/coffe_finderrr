import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon; // Tambahkan properti suffixIcon

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.suffixIcon, // Inisialisasi properti suffixIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 99, 18, 4)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 99, 18, 4)),
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: const Color.fromRGBO(241, 241, 241, 1),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(102, 102, 102, 102)),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          suffixIcon: suffixIcon, // Gunakan properti suffixIcon
        ),
      ),
    );
  }
}
