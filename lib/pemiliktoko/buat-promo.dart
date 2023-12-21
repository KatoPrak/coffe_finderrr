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
  final TextEditingController judulPromoController = TextEditingController();

  Iterable<ImageFile> images = [];
  MultiImagePickerController controller = MultiImagePickerController(
    maxImages: 1,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );
  bool isUploading = false;

  Future<void> _uploadImage() async {
    // Validate input fields
    if (judulPromoController.text.isEmpty || images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap isi judul promo dan pilih gambar produk!')),
      );
      return;
    }

    // Upload the image
    if (images.isNotEmpty) {
      final ImageFile image = images.first;
      Uint8List imageData;

      if (image.hasPath) {
        File file = File(image.path!);
        imageData = await file.readAsBytes();
      } else if (image.bytes != null) {
        imageData = image.bytes!;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengunggah gambar!')),
        );
        return;
      }

      try {
        String fileName = 'image_/${DateTime.now().millisecondsSinceEpoch}.jpg';
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child(fileName);

        UploadTask uploadTask = ref.putData(imageData);
        await uploadTask.whenComplete(() async {
          String imageUrl = await ref.getDownloadURL();

          // Save promo data to Firestore
          final CollectionReference promoCollection =
              FirebaseFirestore.instance.collection('promo');

          await promoCollection.add({
            'judul': judulPromoController.text,
            'gambar': imageUrl,
            // Add more fields as needed
          });

          // Clear input fields
          judulPromoController.clear();
          controller.clearImages();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Promo berhasil diunggah!')),
          );
        }).catchError((onError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error uploading image: $onError')),
          );
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
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
              controller: judulPromoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Judul Promo',
                hintText: 'Masukkan Judul Promo',
              ),
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
