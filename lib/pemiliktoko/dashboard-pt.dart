import 'package:flutter/material.dart';
import 'package:coffe_finder/pemiliktoko/buat-promo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Pemilik Toko',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(),
    );
  }
}

Widget _buildStarIcons(int rating) {
  if (rating <= 0 || rating > 5) {
    return Text('Invalid rating');
  }

  List<Widget> starIcons = [];

  for (int i = 0; i < 5; i++) {
    starIcons.add(
      Icon(
        i < rating ? Icons.star : Icons.star_border,
        color: Color(0xFFE4A70A),
        size: 20.0,
      ),
    );
  }

  return Row(
    children: starIcons,
  );
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int rating = 3; // Ganti dengan nilai rating yang sesuai

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 30,
              ),
              Text(
                'Selamat Datang,',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              Text(
                'Starbucks',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Image.asset(
              'lib/images/welcome.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 165,
              left: 20,
              right: 20,
              child: Container(
                height: 105,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFB06B5F).withOpacity(0.8),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      ClipOval(
                        child: Image(
                          image: AssetImage('lib/images/starbucks.jpeg'),
                          height: 65,
                          width: 65,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20, // Ubah tinggi sesuai kebutuhan Anda
                          ),
                          Text(
                            'Starbucks',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              _buildStarIcons(rating),
                              SizedBox(width: 5),
                              Text(
                                '$rating',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
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
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 240, bottom: 25),
                    child: Center(
                      child: Image(
                        image: AssetImage('lib/images/promo.png'),
                        height: 190,
                        width: 190,
                      ),
                    ),
                  ),
                  Text(
                    'Berbagi Ke Pelanggan Terbaikmu',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Yuk, Berikan penawaran spesial ke pelanggan mu supaya makin sering yang datang!',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 50,
                    width: 400,
                    child: TextButton(
                      onPressed: () {
                        BuatPromo();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF4E598C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Buat Promo',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
