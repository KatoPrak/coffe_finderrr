import 'package:coffe_finder/customer/ulasan-page.dart';
import 'package:flutter/material.dart';

class Tab1 extends StatelessWidget {
  const Tab1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Handle the tap on the main body
          print('Widget diketuk!');
        },
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xFFF6F0E9),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                SizedBox(height: 20),
                Text(
                  'Deskripsi',
                  style: TextStyle(
                    fontSize: 20.0, // Increase font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat...',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16.0, // Increase font size
                    color: Color(0xFF1B1D1F),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Color.fromARGB(20, 0, 0, 0),
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jam Operasional',
                        style: TextStyle(
                          fontSize: 18.0, // Increase font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Senin - Jumat: 09.00 - 18.00'),
                      Text('Sabtu: 10.00 - 15.00'),
                    ],
                  ),
                ),
                SizedBox(height: 10.0), // Adjusted height
                Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Color.fromARGB(20, 0, 0, 0),
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fasilitas',
                        style: TextStyle(
                          fontSize: 18.0, // Increase font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Wifi'),
                      Text('Parkir'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Color.fromARGB(20, 0, 0, 0),
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kopi Cat Cafe By Groovy',
                        style: TextStyle(
                          fontSize: 18.0, // Increase font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                          'Jl. Kyai Maja No.29 RT.10/RW.7, Kramat Pela, KEC.Kby.Baru.Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta'),
                      SizedBox(height: 20.0),
                      Text(
                        'Petunjuk Jalan',
                        style: TextStyle(
                          fontSize: 18.0, // Increase font size
                          color: Color(0xFF971E09),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'lib/images/maps.webp',
                            alignment: Alignment.center,
                            width: 400.0, // Increase width
                            height: 200.0, // Increase height
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children:
                        List.generate(5, (index) => index + 1).map((index) {
                      return Ulasan();
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Container(
          height: 60,
          width: MediaQuery.of(context)
              .size
              .width, // Set the width to the full screen width
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ulasan()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4E598C),
            ),
            child: Text(
              'Tulis Ulasan & Rating',
              style: TextStyle(
                fontSize: 18.0, // Increase font size
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String username;
  final int rating;
  final String comment;
  final List<String> imagePaths;
  final String guestProfilePhoto;

  const ReviewCard({
    Key? key,
    required this.username,
    required this.rating,
    required this.comment,
    required this.imagePaths,
    required this.guestProfilePhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Color(0xFFF2F2F2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5, // Set the elevation for the drop shadow
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage(guestProfilePhoto),
                ),
                SizedBox(width: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$username',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Row(
                      children: [
                        _buildStarIcons(rating),
                        SizedBox(width: 4.0),
                        Text(
                          '$rating',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            comment,
            style: TextStyle(fontSize: 14.0),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 100, // Set a fixed height for the container
            color: Color(0xFFF2F2F2),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.asset(
                      imagePaths[index],
                      width: 118,
                      height: 86,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarIcons(int rating) {
    if (rating <= 0) {
      return Text('No rating');
    }

    List<Widget> stars = [];
    final int maxStars = 5;

    for (int i = 0; i < maxStars; i++) {
      if (i < rating) {
        stars.add(
          Row(
            children: [
              Icon(
                Icons.star,
                color: Color(0xFFE4A70A),
                size: 20.0,
              ),
              if (i == rating - 1 &&
                  rating != 4) // Show the number "4" when rating is not 4
                Text(
                  '$rating',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        );
      } else {
        stars.add(
          Icon(
            Icons.star_border,
            color: Color(0xFFE4A70A),
            size: 20.0,
          ),
        );
      }
    }
    return Row(children: stars);
  }
}
