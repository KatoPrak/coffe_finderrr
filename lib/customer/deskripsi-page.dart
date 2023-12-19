import 'package:flutter/material.dart';

void main() {
  runApp(DeskripsiMenu());
}

// ignore: must_be_immutable
class DeskripsiMenu extends StatelessWidget {
  DeskripsiMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Other widgets or components

            // Call the function to build the image with description
            buildImageWithDescription(context),

            // Call the function to build text outside the image
            buildTextOutsideImage(),
          ],
        ),
      ),
    );
  }

  double imageScreenWeight = 1.0;
  double descriptionScreenWeight = 0.7;

  Widget buildImageWithDescription(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/images/KeboonKopi/Cappuccino.jpg'),
          fit: BoxFit.cover,
        ),
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Color.fromARGB(20, 0, 0, 0),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "Kopi Cat Cafe By Groovy",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Mulish',
                ),
              ),
              SizedBox(
                width: 90,
              ),
              Text(
                'Rp20.000',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFCE1E00),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commo...',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextOutsideImage() {
    return Positioned(
      top: 20, // Sesuaikan posisi atas sesuai kebutuhan
      left: 20, // Sesuaikan posisi kiri sesuai kebutuhan
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional Text Outside Image",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Mulish',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Additional description or information goes here...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
