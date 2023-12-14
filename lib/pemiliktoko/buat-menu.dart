import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BuatMenuPage(),
    );
  }
}

class BuatMenuPage extends StatefulWidget {
  @override
  _BuatMenuPageState createState() => _BuatMenuPageState();
}

class _BuatMenuPageState extends State<BuatMenuPage> {
  String selectedCategory = 'Hot Coffee';
  final TextEditingController namaProdukController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  List<String> categories = [
    'Hot Coffee',
    'Ice Coffee',
  ];

  Iterable<ImageFile> images = [];
  final controller = MultiImagePickerController(
    maxImages: 1,
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

      String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
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

    CollectionReference menuCollection =
        FirebaseFirestore.instance.collection('menu');
    menuCollection.add({
      'nama_produk': namaProdukController.text,
      'harga': hargaController.text,
      'deskripsi': deskripsiController.text,
      'kategori': selectedCategory,
      'image_urls': imageUrls,
    });

    namaProdukController.clear();
    hargaController.clear();
    deskripsiController.clear();
  }

  @override
  void dispose() {
    namaProdukController.dispose();
    hargaController.dispose();
    deskripsiController.dispose();
    super.dispose();
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
        title: Text('Buat Menu'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 16.0),
            Text(
              'Informasi Produk',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.0),
            TextField(
              controller: namaProdukController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nama Produk',
                hintText: 'Masukkan Nama Menu',
              ),
            ),
            SizedBox(height: 25.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              value: selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() => selectedCategory = newValue);
                }
              },
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 25.0),
            TextField(
              controller: hargaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Harga',
                prefixText: 'Rp ',
                hintText: 'Harga Menu',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 25.0),
            TextField(
              controller: deskripsiController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
                labelText: 'Deskripsi Produk',
                hintText: 'Tambahkan deskripsi di sini...',
              ),
              maxLines: 5,
            ),
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
