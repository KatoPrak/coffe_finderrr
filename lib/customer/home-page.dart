import 'package:flutter/material.dart';
import 'package:coffe_finder/model/model.dart';
import 'package:coffe_finder/widget/toko-card.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  List<Toko> filteredToko = terdekat;
  TextEditingController searchController = TextEditingController();

  void searchCourse(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredToko = terdekat;
      });
    } else {
      setState(() {
        filteredToko = terdekat.where((course) {
          final searchLower = query.toLowerCase();
          final titleLower = course.nameToko.toLowerCase();
          final instructorLower = course.alamat.toLowerCase();
          return titleLower.contains(searchLower) ||
              instructorLower.contains(searchLower);
        }).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      searchCourse(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), // Sesuaikan ketinggian AppBar
        child: AppBar(
          backgroundColor: Color(0xFF804A20),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Container(
                  width: 407,
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      searchCourse(value);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF613412),
                      hintText: 'Cari CoffeShop....',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.search, color: Color(0xFFE4A70A)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 13),
                    ),
                  ),
                ),
              ),
            ),
          ],
          title: Column(
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
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Image.asset(
            'lib/images/welcome.jpg',
          ),
          SizedBox(
            height: 20,
            width: 20,
          ),
          Text(
            'Tempat Rekomendasi',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredToko.length,
              itemBuilder: (BuildContext context, int index) {
                final terdekat = filteredToko[index];
                return TokoCard(
                  toko: terdekat,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
