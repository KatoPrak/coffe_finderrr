import 'package:coffe_finder/customer/tentang-cafe.dart';
import 'package:flutter/material.dart';

class Toko {
  String nameToko;
  String alamat;
  double rating; // Tipe data rating diubah menjadi double
  String imageToko;
  List<Produk> produkList;

  Toko({
    required this.nameToko,
    required this.alamat,
    required this.rating,
    required this.imageToko,
    required this.produkList,
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
  List<Toko> terdekat = [
    Toko(
      nameToko: 'Starbucks',
      alamat: 'Jl. Contoh No. 123',
      rating: 5.0, // Rating diubah menjadi double
      imageToko: 'lib/images/starbucks.jpeg',
      produkList: [
        Produk(
          nama: 'Kopi Espresso',
          harga: 25.0,
          imageToko: 'lib/images/RimbunKopi/Karolina.jpg',
        ),
        Produk(
          nama: 'Cappuccino',
          harga: 30.0,
          imageToko: 'lib/images/LoonamiHouse/Bananauyu.jpg',
        ),
        Produk(
          nama: 'Latte',
          harga: 28.0,
          imageToko: 'lib/images/RimbunKopi/Caffelatte.jpg',
        ),
      ],
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
    filteredToko = terdekat;
    searchController.addListener(() {
      searchShop(searchController.text);
    });
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
        toolbarHeight: 60,
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
            icon: const Icon(Icons.search),
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
              'Irvan Ronaldi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Image.asset(
              'lib/images/welcome.jpg', // Adjust the image width as needed
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
                    child: ListTile(
                      title: Text(shop.nameToko),
                      subtitle: Text(shop.alamat),
                      leading: Container(
                        height: 80,
                        width: 80,
                        child: Image.asset(
                          shop.imageToko,
                          fit: BoxFit.cover,
                        ),
                      ),
                      trailing: buildStarRating(shop.rating),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AboutCafe(),
                          ),
                        );
                      },
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
          padding: const EdgeInsets.all(8.0), // Add padding here
          child: ListTile(
            title: Text(shop.nameToko),
            subtitle: Text(shop.alamat),
            leading: Container(
              height: 80,
              width: 80,
              child: Image.asset(
                shop.imageToko,
                fit: BoxFit.cover,
              ),
            ),
            trailing: buildStarRating(shop.rating),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailScreen(
                  toko: shop,
                ),
              ));
            },
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

class DetailScreen extends StatelessWidget {
  final Toko toko;

  const DetailScreen({Key? key, required this.toko}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(toko.nameToko),
      ),
      body: Column(
        children: [
          Image.asset(
            toko.imageToko,
            fit: BoxFit.cover,
            height: 200,
          ),
          Text(toko.alamat),
          Text(
              'Rating: ${toko.rating.toStringAsFixed(1)}'), // Format rating dengan 1 desimal
          SizedBox(height: 10),
          Text('Nama Toko: ${toko.nameToko}'),
          SizedBox(height: 20),
          Text('Produk di ${toko.nameToko}'),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: toko.produkList.length,
              itemBuilder: (BuildContext context, int index) {
                final produk = toko.produkList[index];
                return Card(
                  child: Column(
                    children: [
                      Image.asset(
                        produk.imageToko,
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                      Text(produk.nama),
                      Text("${produk.harga}"),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Dashboard(),
  ));
}
