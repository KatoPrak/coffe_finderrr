import 'package:coffe_finder/components/navbar-pelanggan.dart';
import 'package:coffe_finder/components/navbar-toko.dart';
import 'package:coffe_finder/customer/home-page.dart';
import 'package:coffe_finder/customer/ulasan-page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';

final Uri _url = Uri.parse('https://flutter.dev');

class Tab1 extends StatelessWidget {
  const Tab1({Key? key}) : super(key: key);

  // Fungsi untuk meluncurkan URL.
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await canLaunchUrl(url)) {
      throw 'Could not launch $urlString';
    }
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    // URL untuk Google Maps.
    final String mapUrl =
        'https://maps.app.goo.gl/uBu1wkYd5mXAPSBv8'; // Ganti dengan URL tujuan yang spesifik

    return Scaffold(
      body: GestureDetector(
        onTap: () {
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
                      GestureDetector(
                        onTap: () => _launchUrl(mapUrl),
                        child: Container(
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
                              width: 355.0,
                              height: 180.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: List.generate(5, (index) => index + 1)
                              .map((index) {
                            return ReviewCard(
                              username: 'John Doe $index',
                              rating: 4,
                              comment:
                                  'Tempat yang bagus untuk nongkrong $index.',
                              imagePaths: [
                                'lib/images/plastik.jpeg',
                                'lib/images/plastik.jpeg',
                                'lib/images/plastik.jpeg',
                              ],
                              guestProfilePhoto: 'lib/images/profile-guest.png',
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
            height: 100,
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
    // Add more Ice Coffee products as needed
  ];
  List<Product> iceCoffeeProducts = [
    Product(
      name: 'Banana',
      description: 'Cold',
      price: 'Rp15.000',
      category: 'Ice Coffee',
      image: 'lib/images/LoonamiHouse/Bananauyu.jpg',
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
            // ...
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

class MenuItem {
  final String name;
  final double price;
  final String imagePath;

  MenuItem({
    required this.name,
    required this.price,
    required this.imagePath,
  });
}

class MenuContainer extends StatelessWidget {
  final String name;
  final double price;
  final String imagePath;

  const MenuContainer({
    Key? key,
    required this.name,
    required this.price,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }
}

class AboutCafe extends StatefulWidget {
  const AboutCafe({Key? key}) : super(key: key);

  @override
  State<AboutCafe> createState() => _AboutCafeState();
}

class _AboutCafeState extends State<AboutCafe>
    with SingleTickerProviderStateMixin {
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

  String selectedRamai = 'Ramai'; // Set defaul`t value if needed
  String selectedTutup = 'Tutup'; // Set default value if needed
// You can set a default value
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
                const SizedBox(height: 30),
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
                      const SizedBox(height: 10),
                      Text(
                        "Kopi Cat Cafe By Groovy",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Mulish',
                        ),
                      ),
                      const SizedBox(height: 20),
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
                              const SizedBox(width: 20),
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
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Dropdown for "Ramai"
                          DropdownButton<String>(
                            value: selectedRamai,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedRamai = newValue!;
                              });
                            },
                            items: ['Ramai', 'Sepi', 'Normal']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      getImageAssetPath(
                                          value), // Call a function to get the image path
                                      alignment: Alignment.center,
                                      width: 23.0,
                                      height: 23.0,
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
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(width: 30),
                          // Dropdown for "Tutup"
                          DropdownButton<String>(
                            value: selectedTutup,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedTutup = newValue!;
                              });
                            },
                            items: ['Tutup', 'Buka']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      getImageAssetPath(
                                          value), // Call a function to get the image path
                                      alignment: Alignment.center,
                                      width: 20.0,
                                      height: 20.0,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Sepi',
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
                              );
                            }).toList(),
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
                                      const SizedBox(height: 1),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BottomNavBarToko(), // Ganti HalamanTujuan dengan halaman yang ingin Anda tuju.
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

String getImageAssetPath(String value) {
  if (value == 'Ramai') {
    return 'lib/images/Ellipse.png';
  } else if (value == 'Sepi') {
    return 'lib/images/Ellipseyelow.png';
  } else if (value == 'Normal') {
    return 'lib/images/Ellipseblue.png';
  } else if (value == 'Buka' || value == 'Tutup') {
    return 'lib/images/time.png';
  } else {
    return 'lib/images/time.png'; // Change this to a default image path
  }
}

class TentangPt extends StatefulWidget {
  const TentangPt({Key? key}) : super(key: key);

  @override
  State<TentangPt> createState() => _TentangPtState();
}

class _TentangPtState extends State<TentangPt> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Banner',
      home: AboutCafe(),
      debugShowCheckedModeBanner: false,
    );
  }
}
