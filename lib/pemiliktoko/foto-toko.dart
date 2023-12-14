import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_image_picker/multi_image_picker.dart'; // Import 'Asset' type

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FotoToko(),
    );
  }
}

class FotoToko extends StatefulWidget {
  @override
  _FotoTokoState createState() => _FotoTokoState();
}

class _FotoTokoState extends State<FotoToko> {
  Iterable<ImageFile> images = [];
  MultiImagePickerController controller = MultiImagePickerController(
    maxImages: 5,
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

      FirebaseFirestore.instance.collection('FotoToko').add({
        'image_urls': imageUrls,
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gambar berhasil diunggah!')));
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
        title: Text('Foto Toko'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Text('Tambahkan Foto Tokomu',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            SizedBox(height: 50.0),
            MultiImagePickerView(
              onChange: (_) {
                setState(() {
                  images = controller.images;
                });
              },
              controller: controller,
              padding: const EdgeInsets.all(10),
            ),
            SizedBox(height: 20),
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
