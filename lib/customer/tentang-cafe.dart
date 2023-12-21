import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:coffe_finder/customer/ulasan-page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:ui';

class Tab1 extends StatelessWidget {
  const Tab1({Key? key}) : super(key: key);

  Stream<QuerySnapshot> readData() {
    final ulasan = FirebaseFirestore.instance.collection('ulasan').snapshots();

    return ulasan;
  }

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
              width: double.infinity,
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
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat...',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF1B1D1F),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    width: double.infinity,
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
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Senin - Jumat: 09.00 - 18.00'),
                        Text('Sabtu: 10.00 - 15.00'),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    width: double.infinity,
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
                            fontSize: 17.0,
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
                    width: double.infinity,
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
                            fontSize: 17.0,
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
                            fontSize: 17.0,
                            color: Color(0xFF971E09),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                            width: double.maxFinite,
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
                            child: GestureDetector(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: readData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return SingleChildScrollView(
                          child: Column(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;

                              // Periksa apakah 'fotoPaths' ada dalam data
                              List<String> imagePaths =
                                  data['fotoPaths'] != null
                                      ? List.from(data['fotoPaths'])
                                      : [];

                              return ReviewCard(
                                username: data['username'],
                                rating: data[
                                    'rating'], // Menggunakan rating dari data Firestore
                                comment: data[
                                    'review'], // Menggunakan review dari data Firestore
                                imagePaths:
                                    imagePaths, // Menggunakan imagePaths dari data Firestore
                                guestProfilePhoto:
                                    'lib/images/profile-guest.png',
                              );
                            }).toList(),
                          ),
                        );
                      })
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
                primary: Color(0xFF4E598C),
              ),
              child: Text(
                'Tulis Ulasan & Rating',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]);
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Tab1(),
    ),
  );
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
      // Increased margin
      color: Color(0xFFF2F2F2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Slightly larger radius
      ),
      elevation: 6, // Slightly higher elevation
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Increased padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0, // Larger avatar radius
                  backgroundImage: AssetImage(guestProfilePhoto),
                ),
                SizedBox(width: 20.0), // Increased spacing
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$username',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0, // Larger font size
                        ),
                      ),
                      Row(
                        children: [
                          _buildStarIcons(rating),
                          SizedBox(width: 8.0), // Increased spacing
                          Text(
                            '$rating',
                            style: TextStyle(
                              fontSize: 18.0, // Larger font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0), // Increased spacing
            Text(
              comment,
              style: TextStyle(fontSize: 16.0), // Larger font size for comment
            ),
            SizedBox(height: 12.0), // Increased spacing
            Container(
              height: 120, // Increased container height for images
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        imagePaths[index],
                        width: 120, // Larger image width
                        height: 120, // Larger image height
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
          Icon(
            Icons.star,
            color: Color(0xFFE4A70A),
            size: 20.0,
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

class Tab2 extends StatelessWidget {
  const Tab2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ProductListPage(),
          ],
        ),
      ),
    );
  }
}

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<String> categories = [
    'Ice Coffee',
    'Hot Coffee',
  ];

  String selectedCategory = '';
  List<Product> hotCoffeeProducts = [
    Product(
      name: 'Cappuccino',
      description: 'Cold and refreshing',
      price: 'Rp15.000',
      category: 'Hot Coffee',
      image: 'lib/images/KeboonKopi/Cappuccino.jpg',
    ),
    Product(
      name: 'Caffe Latte',
      description: 'Chilled coffee goodness',
      price: 'Rp18.000',
      category: 'Hot Coffee',
      image: 'lib/images/RimbunKopi/Caffelatte.jpg',
    ),
    // Add more Hot Coffee products as needed
  ];
  List<Product> iceCoffeeProducts = [
    Product(
      name: 'Expresso',
      description: 'Cold and refreshing',
      price: 'Rp15.000',
      category: 'Ice Coffee',
      image: 'lib/images/LoonamiHouse/Bananauyu.jpg',
    ),
    Product(
      name: 'Americano',
      description: 'Chilled coffee goodness',
      price: 'Rp18.000',
      category: 'Ice Coffee',
      image: 'lib/images/KeboonKopi/Cappuccino.jpg',
    ),
    // Add more Ice Coffee products as needed
  ];

  @override
  Widget build(BuildContext context) {
    List<Product> displayedProducts = [];

    if (selectedCategory.isNotEmpty) {
      if (selectedCategory == 'Ice Coffee') {
        displayedProducts = iceCoffeeProducts;
      } else if (selectedCategory == 'Hot Coffee') {
        displayedProducts = hotCoffeeProducts;
      }
    } else {
      // Show all products if no category is selected
      displayedProducts = [...iceCoffeeProducts, ...hotCoffeeProducts];
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          margin: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: categories
                .map(
                  (category) => Row(
                    children: [
                      FilterChip(
                        label: Text(category),
                        backgroundColor: selectedCategory == category
                            ? Color(0xFFA84F2F) // Warna saat dipilih
                            : Color(0xFFF6F0E9),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedCategory = category;
                            } else {
                              selectedCategory = '';
                            }
                          });
                        },
                        selected: selectedCategory == category,
                        labelStyle: TextStyle(
                          color: selectedCategory == category
                              ? Colors.black // Warna teks saat dipilih
                              : Colors.black, // Warna teks saat tidak dipilih
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: selectedCategory == category
                                ? Colors.transparent // Warna garis saat dipilih
                                : const Color.fromARGB(57, 158, 158,
                                    158), // Warna garis saat tidak dipilih
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      SizedBox(width: 8.0), // Jarak antar kategori
                    ],
                  ),
                )
                .toList(),
          ),
        ),

        // Display the filtered products
        Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: List.generate(displayedProducts.length, (index) {
              Product product = displayedProducts[index];
              return Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Row(
                  children: [
                    // Gambar disini
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          25.0), // Atur borderRadius di sini
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                        height: 120,
                        width: 120,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                      height: 30,
                    ),
                    // Teks disini
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            product.category,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF1B1D1F),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Text(
                            product.price,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF631204),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}

class Product {
  final String name;
  final String description;
  final String price;
  final String category;
  final String image;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
  });
}

class AboutCafe extends StatefulWidget {
  const AboutCafe({Key? key}) : super(key: key);

  @override
  State<AboutCafe> createState() => _AboutCafeState();
}

class _AboutCafeState extends State<AboutCafe>
    with SingleTickerProviderStateMixin {
  Stream<QuerySnapshot> readData() {
    final ulasanStream =
        FirebaseFirestore.instance.collection('datatoko').snapshots();

    return ulasanStream;
  }

  final myitems = [
    'lib/images/kopicatcafebyGroovy/dekorasi/1.jpg',
    'lib/images/kopicatcafebyGroovy/dekorasi/2.jpg',
    'lib/images/kopicatcafebyGroovy/dekorasi/3.jpg',
    'lib/images/kopicatcafebyGroovy/dekorasi/4.jpg',
    'lib/images/kopicatcafebyGroovy/dekorasi/5.jpg',
  ];

  int myCurrentIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFB99976),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 70),
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    height: 200,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayInterval: const Duration(seconds: 2),
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        myCurrentIndex = index;
                      });
                    },
                  ),
                  items: myitems.map((item) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          item,
                          width: media.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 15),
                Container(
                  child: AnimatedSmoothIndicator(
                    activeIndex: myCurrentIndex,
                    count: myitems.length,
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      dotColor: Color.fromARGB(255, 219, 217, 217),
                      activeDotColor: Colors.brown,
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F0E9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kopi Cat Cafe By Groovy",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Mulish',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IgnorePointer(
                                ignoring: true,
                                child: RatingBar.builder(
                                  initialRating: 4,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 25,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Color(0xFFE4A70A),
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "4.0",
                                style: TextStyle(
                                  color: Color.fromRGBO(51, 51, 51, 0.700),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'lib/images/Ellipse.png',
                            alignment: Alignment.center,
                            width: 20.0,
                            height: 20.0,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Ramai',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              height: 1.255,
                              letterSpacing: -0.14,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(width: 85),
                          Image.asset(
                            'lib/images/time.png',
                            alignment: Alignment.center,
                            width: 20.0,
                            height: 20.0,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Open',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              height: 1.255,
                              letterSpacing: -0.14,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.02),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: [
                                SizedBox(height: 5),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F6F7),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.1),
                                              width: 1,
                                            ),
                                          ),
                                          child: TabBar(
                                            unselectedLabelColor:
                                                Color(0xFF666666),
                                            labelColor: Color(0xFFFFFFFF),
                                            indicatorColor: Color(0xFFFFFFFF),
                                            indicatorWeight: 4,
                                            labelStyle: TextStyle(
                                              fontSize:
                                                  17, // Change the font size
                                              fontWeight: FontWeight
                                                  .bold, // Change the font weight
                                              // Add more styling properties as needed
                                            ),
                                            unselectedLabelStyle: TextStyle(
                                              fontSize:
                                                  17, // Change the font size
                                              fontWeight: FontWeight
                                                  .normal, // Change the font weight
                                              // Add more styling properties as needed
                                            ),
                                            indicator: BoxDecoration(
                                              color: Color(0xFFA84F2F),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            controller: tabController,
                                            tabs: const [
                                              Tab(
                                                text: 'Tentang Cafe',
                                              ),
                                              Tab(
                                                text: 'Menu',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    controller: tabController,
                                    children: [
                                      Tab1(),
                                      Tab2(), // Tambahkan widget Tab2 di sini
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            Positioned(
              top: 80,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(190, 217, 217, 217),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
