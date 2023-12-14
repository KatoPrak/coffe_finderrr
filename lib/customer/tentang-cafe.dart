import 'package:coffe_finder/customer/tab1.dart';
import 'package:coffe_finder/customer/tab2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:ui';

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
                            style: GoogleFonts.mulish(
                              textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              height: 1.255,
                              letterSpacing: -0.14,
                              color: Color(0xb2333333),
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
                            style: GoogleFonts.mulish(
                              textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              height: 1.255,
                              letterSpacing: -0.14,
                              color: Color(0xb2333333),
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