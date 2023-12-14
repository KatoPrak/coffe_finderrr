import 'package:coffe_finder/model/model.dart';
import 'package:flutter/material.dart';
import 'package:coffe_finder/customer/ulasan-page.dart';

class DetailCourse extends StatelessWidget {
  final Toko terdekat;

  const DetailCourse({Key? key, required this.terdekat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text('Courses'),
        centerTitle: true, // if you want the title to be centered
        backgroundColor: Colors.white, // Set the background color to white
        titleTextStyle: const TextStyle(
            color: Colors.black, // Set the text color to black
            fontSize: 20,
            fontWeight: FontWeight.bold // Set the font size
            ),
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the back button icon color to black
        ),
        elevation: 0, // Removes the shadow from the app bar.
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Ulasan(),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
