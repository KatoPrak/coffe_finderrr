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
  final TextEditingController deskripsiController = TextEditingController();
  Iterable<ImageFile> images = [];
  MultiImagePickerController controller = MultiImagePickerController(
    maxImages: 1,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );
  bool isUploading = false;

  Future<void> _uploadImage() async {
    if (images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tidak ada gambar yang dipilih!')));
      return;
    }

    setState(() => isUploading = true);

    List<String> imageUrls = [];
    try {
      List<Future> uploadTasks = images.map((image) async {
        Uint8List imageData;
        if (image.hasPath) {
          imageData = await File(image.path!).readAsBytes();
        } else {
          imageData = image.bytes!;
        }

        String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
        Reference ref = FirebaseStorage.instance.ref().child(fileName);
        await ref.putData(imageData);
        String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }).toList();

      await Future.wait(uploadTasks);

      FirebaseFirestore.instance.collection('promo').add({
        'deskripsi_promo': promoDescriptionController.text,
        'image_urls': imageUrls,
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Promo berhasil diunggah!')));
    } catch (e) {
      print('Error uploading images: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal mengunggah gambar!')));
    } finally {
      setState(() {
        isUploading = false;
        images = []; // Mengatur ulang images
        controller = MultiImagePickerController(
          maxImages: 1,
          withReadStream: true,
          allowedImageTypes: ['png', 'jpg', 'jpeg'],
        );
      });
      promoDescriptionController.clear();
      deskripsiController.clear();
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
            SizedBox(height: 30.0),
            Text('Tentang Promo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            TextField(
              controller: promoDescriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Isi Deskripsi',
                hintText: 'Tambahkan deskripsi promo di sini...',
                floatingLabelBehavior: FloatingLabelBehavior
                    .always, // Label tetap di atas sebelum dan setelah diklik
              ),
              maxLines: 5,
            ),
            SizedBox(height: 50.0),
            Text('Gambar Produk',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
