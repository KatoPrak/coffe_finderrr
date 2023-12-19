import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: DataToko(),
  ));
}

class DataToko extends StatefulWidget {
  @override
  _DataTokoState createState() => _DataTokoState();
}

class _DataTokoState extends State<DataToko> {
  String fasilitasDescription = "";
  String alamat = "";
  String jamOperasional = "";
  String fasilitas = "";

  List<Asset> images = [];

  MultiImagePickerController controller = MultiImagePickerController(
    maxImages: 5,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );
  bool isUploading = false;

  TextEditingController fasilitasController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController jamOperasionalController = TextEditingController();

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
        ByteData byteData = await image.getByteData();
        Uint8List imageData = byteData.buffer.asUint8List();

        String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
        Reference ref = FirebaseStorage.instance.ref().child(fileName);
        await ref.putData(imageData);
        String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }).toList();

      await Future.wait(uploadTasks);

      FirebaseController.sendDataToFirestore(
        fasilitasDescription: fasilitasDescription,
        alamat: alamat,
        jamOperasional: jamOperasional,
        imageUrls: imageUrls,
        fasilitas: fasilitas,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gambar berhasil diunggah!')));
    } catch (e) {
      print('Error uploading images: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal mengunggah gambar!')));
    } finally {
      setState(() {
        isUploading = false;
        images = [];
        controller = MultiImagePickerController(
          maxImages: 5,
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
        title: Text('Data Toko', style: TextStyle(fontSize: 25)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Text('Deskripsi Toko',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: fasilitasController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tambahkan deskripsi Toko di sini...',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              maxLines: 4,
              onChanged: (value) {
                setState(() {
                  fasilitasDescription = value;
                });
              },
            ),
            SizedBox(height: 30),
            Text('Alamat Toko',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: alamatController,
              decoration: InputDecoration(
                labelText: 'Alamat',
                hintText: 'Tambahkan alamat toko di sini...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
              onChanged: (value) {
                setState(() {
                  alamat = value;
                });
              },
            ),
            SizedBox(height: 30),
            Text('Jam Operasional',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: jamOperasionalController,
              decoration: InputDecoration(
                labelText: 'Jam Operasional',
                hintText: 'Tambahkan jam operasional di sini...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
              onChanged: (value) {
                setState(() {
                  jamOperasional = value;
                });
              },
            ),
            SizedBox(height: 30),
            Text('Fasilitas',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: fasilitasController,
              decoration: InputDecoration(
                labelText: 'Tambahkan Fasilitas tokomu',
                hintText: '-Wifi -Toilet dll',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
              onChanged: (value) {
                setState(() {
                  fasilitas = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Foto Tokomu',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
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

class FirebaseController {
  static Future<void> sendDataToFirestore({
    String fasilitasDescription,
    String alamat,
    String jamOperasional,
    List<String> imageUrls,
    String fasilitas,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;

      await firestore.collection('FotoToko').add({
        'deskripsi_fasilitas': fasilitasDescription,
        'alamat': alamat,
        'jam_operasional': jamOperasional,
        'image_urls': imageUrls,
        'fasilitas': fasilitas,
      });

      print('Data berhasil dikirim ke Firestore');
    } catch (e) {
      print('Error mengirim data ke Firestore: $e');
    }
  }
}
