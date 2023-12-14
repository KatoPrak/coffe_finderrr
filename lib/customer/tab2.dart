import 'package:flutter/material.dart';

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
    // Add more Ice Coffee products as needed
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
      image: 'lib/images/LoonamiHouse/Blackcurrenttea.jpg',
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