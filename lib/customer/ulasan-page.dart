import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:coffe_finder/customer/tentang-cafe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class Ulasan extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Ulasan> {
  int _rating = 0;
  TextEditingController _reviewController = TextEditingController();
  TextEditingController _usernameController = TextEditingController(); // Controller untuk username
  Iterable<ImageFile> images = [];
  final controller = MultiImagePickerController(
    maxImages: 3,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );
  Future<void> _uploadImage() async {
    List<String> imageUrls = [];

    for (final image in images) {
      Uint8List imageData;

      if (image.hasPath) {
        File file = File(image.path!);
        imageData = await file.readAsBytes();
      } else if (image.bytes != null) {
        imageData = image.bytes!;
      } else {
        continue;
      }

      String fileName = 'image_/${DateTime.now().millisecondsSinceEpoch}.jpg';
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(fileName);

      UploadTask uploadTask = ref.putData(imageData);
      await uploadTask.whenComplete(() async {
        String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }).catchError((onError) {
        print('Error uploading image: $onError');
      });
    }

    final CollectionReference ulasanCollection =
        FirebaseFirestore.instance.collection('ulasan');

    String username = _usernameController.text.trim(); // Mendapatkan username dari controller
    ulasanCollection.add({
      'rating': _rating,
      'review': _reviewController.text.trim(),
      'fotoPaths': imageUrls,
      'username': username, // Simpan username ke database
    }).then((DocumentReference idDocument) {
      print('Document added with ID: ${idDocument.id}');
      print('Foto Paths: $imageUrls');
    }).catchError((error) {
      print('Error: $error');
    });
  }

  Stream<QuerySnapshot> readData() {
    final ulasanStream =
        FirebaseFirestore.instance.collection('ulasan').snapshots();

    return ulasanStream;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 77,
        title: Text(
          'Beri Penilaian Untuk Coffee Shop',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF804A20),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutCafe()),
            );
          },
        ),
      ),
      backgroundColor: Color(0xFFF6F0E9),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Container(
                alignment: Alignment.center,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.01,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _rating = index + 1;
                          });
                        },
                        child: Stack(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: Icon(
                                index < _rating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: screenWidth * 0.15,
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.1),
              Container(
                alignment: Alignment.center,
                height: 200,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenWidth * 0.05),
                    Container(
                      width: screenWidth * 0.9,
                      child: TextFormField(
                        controller: _reviewController,
                        decoration: InputDecoration(
                          labelText: 'Bagikan ulasanmu di sini...',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: screenWidth * 0.09,
                            horizontal: screenWidth * 0.02,
                          ),
                        ),
                        maxLines: 4,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.05), // Spasi tambahan
                    Container(
                      width: screenWidth * 0.9,
                      child: TextFormField(
                        controller: _usernameController, // Input untuk username
                        decoration: InputDecoration(
                          labelText: 'Masukkan Username', // Label untuk username
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: screenWidth * 0.09,
                            horizontal: screenWidth * 0.02,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenWidth * 0.1),
              MultiImagePickerView(
                onChange: (_) {
                  setState(() {
                    images = controller.images;
                  });
                },
                controller: controller,
                padding: const EdgeInsets.all(10),
              ),
              const SizedBox(height: 32),
              SizedBox(height: screenWidth * 0.04),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: ElevatedButton(
          onPressed: () {
            _uploadImage();
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF4E598C),
          ),
          child: Text(
            'Kirim',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
