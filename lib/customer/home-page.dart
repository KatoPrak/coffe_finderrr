import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_finder/customer/tentang-cafe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Toko {
  String nameToko;
  String alamat;
  double rating; // Tipe data rating diubah menjadi double
  String? imageToko;
  List<Produk> produkList;
  final String guestProfilePhoto;

  Toko({
    required this.nameToko,
    required this.alamat,
    required this.rating,
    required this.imageToko,
    required this.produkList,
    required this.guestProfilePhoto,
  });
}

class Produk {
  String nama;
  double harga;
  String imageToko;

  Produk({
    required this.nama,
    required this.harga,
    required this.imageToko,
  });
}

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<Dashboard> {
  String username = '';
  List<Toko> terdekat = [
    Toko(
      nameToko: 'Starbucks',
      alamat: 'Jl. Contoh No. 123',
      rating: 5.0, // Rating diubah menjadi double
      imageToko: null,
      guestProfilePhoto: 'lib/images/profile-guest.png',
      produkList: [],
    ),
    // Tambahkan data toko lainnya di sini
  ];

  List<Toko> filteredToko = [];
  TextEditingController searchController = TextEditingController();

  // Create a map to store ratings for each shop, initially all set to 0.
  Map<String, double> shopRatings = {
    'Starbucks': 0.0,
  };

  void searchShop(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredToko = terdekat;
      });
    } else {
      setState(() {
        filteredToko = terdekat.where((shop) {
          final searchLower = query.toLowerCase();
          final nameLower = shop.nameToko.toLowerCase();
          final addressLower = shop.alamat.toLowerCase();
          return nameLower.contains(searchLower) ||
              addressLower.contains(searchLower);
        }).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
    filteredToko = terdekat;
    searchController.addListener(() {
      searchShop(searchController.text);
    });
  }
  void loadUserData() async {
    try {
      // Gantilah 'userEmail' dengan email pengguna yang saat ini login
      final userEmail = FirebaseAuth.instance.currentUser?.email;

      if (userEmail != null) {
        final DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(userEmail).get();

        setState(() {
          username = userDoc['username'];
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Function to build star rating string
  Widget buildStarRating(double rating) {
    int starCount = rating.round(); // Round the rating to the nearest integer
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          index < starCount ? Icons.star : Icons.star_border,
          color: Colors.amber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF804A20),
        title: Text(
          'Coffee Finder',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Charm',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 32,
            onPressed: () {
              showSearch(
                context: context,
                delegate: CoffeeShopSearchDelegate(
                    allShops: terdekat,
                    shopRatings: shopRatings,
                    onRatingUpdate: updateRating),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0), // Increased padding for all sides
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang,',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              '$username',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(
                  16.0), // Sesuaikan dengan radius yang Anda inginkan
              child: Image.asset(
                'lib/images/welcome.jpg',
                fit: BoxFit.cover, // Sesuaikan dengan lebar yang Anda inginkan
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Tempat Rekomendasi',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredToko.length,
                itemBuilder: (context, index) {
                  var shop = filteredToko[index];
                  return Padding(
                    padding: const EdgeInsets.all(5.0), // Add padding here
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF000000)
                              .withOpacity(0.2), // Ubah warna border di sini
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFF2F2F2),
                      ),
                      child: ListTile(
                        title: Text(
                          shop.nameToko,
                          style: TextStyle(
                            fontSize: 18.0, // Atur ukuran teks sesuai kebutuhan
                            fontWeight: FontWeight
                                .bold, // Atur gaya teks sesuai kebutuhan
                          ),
                        ),
                        subtitle: Text(
                          shop.alamat,
                          style: TextStyle(
                            fontSize: 16.0, // Atur ukuran teks sesuai kebutuhan
                          ),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            shop.imageToko ?? 'lib/images/profile-guest.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize
                              .min, // To make sure the icons are centered
                          children: [
                            Icon(
                              Icons.star,
                              color: Color(0xFFE4A70A),
                            ),
                            Text(
                              shop.rating
                                  .toString(), // Assuming rating is a double or int
                              style: TextStyle(
                                fontSize:
                                    16.0, // Atur ukuran teks sesuai kebutuhan
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AboutCafe(),
                            ),
                          );
                        },
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

  // Function to update the rating in the shopRatings map.
  void updateRating(String nameToko, double rating) {
    setState(() {
      shopRatings[nameToko] = rating;
    });
  }
}

class CoffeeShopSearchDelegate extends SearchDelegate {
  final List<Toko> allShops;
  final Map<String, double> shopRatings;
  final Function(String, double) onRatingUpdate;

  CoffeeShopSearchDelegate({
    required this.allShops,
    required this.shopRatings,
    required this.onRatingUpdate,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  // Function to build star rating string
  Widget buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Toko> matchingShops = allShops.where((shop) {
      return shop.nameToko.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchingShops.length,
      itemBuilder: (context, index) {
        var shop = matchingShops[index];
        return Padding(
          padding: const EdgeInsets.all(5.0), // Add padding here
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFF000000)
                    .withOpacity(0.2), // Ubah warna border di sini
              ),
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFF2F2F2),
            ),
            child: ListTile(
              title: Text(
                shop.nameToko,
                style: TextStyle(
                  fontSize: 18.0, // Atur ukuran teks sesuai kebutuhan
                  fontWeight:
                      FontWeight.bold, // Atur gaya teks sesuai kebutuhan
                ),
              ),
              subtitle: Text(
                shop.alamat,
                style: TextStyle(
                  fontSize: 16.0, // Atur ukuran teks sesuai kebutuhan
                ),
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  shop.imageToko ?? 'lib/images/profile-guest.png',
                  fit: BoxFit.cover,
                ),
              ),
              trailing: Row(
                mainAxisSize:
                    MainAxisSize.min, // To make sure the icons are centered
                children: [
                  Icon(
                    Icons.star,
                    color: Color(0xFFE4A70A),
                  ),
                  Text(
                    shop.rating
                        .toString(), // Assuming rating is a double or int
                    style: TextStyle(
                      fontSize: 16.0, // Atur ukuran teks sesuai kebutuhan
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AboutCafe(),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
