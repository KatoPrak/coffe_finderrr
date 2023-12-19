import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BuatPromo(),
    );
  }
}

class BuatPromo extends StatefulWidget {
  @override
  _BuatPromoState createState() => _BuatPromoState();
}

class _BuatPromoState extends State<BuatPromo> {
  final TextEditingController promoDescriptionController =
      TextEditingController();
  // ... Ulangi untuk setiap hari hingga Minggu

  Iterable<ImageFile> images = [];
  MultiImagePickerController controller = MultiImagePickerController(
    maxImages: 1,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );
  bool isUploading = false;

  Future<void> _uploadImage() async {
    // ... (Implementasi seperti sebelumnya)
  }

  Widget _buildTimeField(String day, TextEditingController controller) {
    return Column(
      children: [
        SizedBox(height: 10.0),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Waktu Buka $day',
            suffixIcon: Icon(Icons.access_time),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xff804A20),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Buat Promo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50.0),
            TextField(
              controller: promoDescriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Isi Deskripsi',
                hintText: 'Tambahkan deskripsi promo di sini...',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              maxLines: 5,
            ),
            SizedBox(height: 50.0),
            Text('Gambar Produk',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            MultiImagePickerView(
              onChange: (_) {
                setState(() {
                  images = controller.images;
                });
              },
              controller: controller,
              padding: const EdgeInsets.all(10),
            ),
            if (isUploading) LinearProgressIndicator(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: ElevatedButton(
          onPressed: () {
            _uploadImage();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4E598C),
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
