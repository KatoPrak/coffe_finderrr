import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: DataToko()));
}

class DataToko extends StatefulWidget {
  const DataToko({Key? key}) : super(key: key);

  @override
  _DataTokoState createState() => _DataTokoState();
}

class _DataTokoState extends State<DataToko> {
  final ImagePicker picker = ImagePicker();
  File? fotoPath;
  String? newPhotoUrl;
  String? currentPhotoUrl;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fasilitasController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController deskripsitokoController = TextEditingController();
  TextEditingController titikkoordinatController = TextEditingController();
  TextEditingController bukaTokoController = TextEditingController();
  TextEditingController tutupTokoController = TextEditingController();
  // Tambahk
  Iterable<ImageFile> images = [];

  MultiImagePickerController controller = MultiImagePickerController(
    maxImages: 5,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );

  bool isUploading = false;

  Future<File?> selectPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        fotoPath = File(pickedFile.path);
      });

      // Simpan URL gambar yang baru ditambahkan
      newPhotoUrl = pickedFile.path;

      return File(pickedFile.path);
    } else {
      // Handle jika pengguna tidak memilih foto
      return null;
    }
  }

  void loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Ambil data dari koleksi 'data_customer'
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .get();

        setState(() {
          usernameController.text = userDoc['username'] ?? '';
          emailController.text = user.email ?? '';
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<String> uploadImage(File newPhotoFile) async {
    try {
      String filePath = 'tokoprofile/${DateTime.now()}.png';
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(filePath);

      UploadTask uploadTask = ref.putFile(newPhotoFile);
      TaskSnapshot snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } else {
        // Jika terjadi kesalahan saat mengunggah gambar, kembalikan pesan kesalahan
        return 'Gagal mengunggah gambar';
      }
    } catch (e) {
      print('Error uploading image: $e');
      return 'Gagal mengunggah gambar: $e';
    }
  }

  Future<void> _uploadImage() async {
    // Validasi teksfield dan gambar yang telah dipilih
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        alamatController.text.isEmpty ||
        titikkoordinatController.text.isEmpty ||
        deskripsitokoController.text.isEmpty ||
        fasilitasController.text.isEmpty ||
        bukaTokoController.text.isEmpty ||
        tutupTokoController.text.isEmpty ||
        images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap isi semua kolom dan pilih gambar!')),
      );
      return;
    }

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

      String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
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

    final user =
        FirebaseAuth.instance.currentUser; // Get the current authenticated user
    if (user != null) {
      final CollectionReference datatokoCollection =
          FirebaseFirestore.instance.collection('datatoko');

      datatokoCollection.add({
        'username': usernameController.text,
        'email': emailController.text,
        'fasilitas': fasilitasController.text,
        'alamat': alamatController.text,
        'deskripsi': deskripsitokoController.text,
        'waktubuka': bukaTokoController.text,
        'waktututup': tutupTokoController.text,
        'titikkoordinat': titikkoordinatController.text,
        'fotoPaths': imageUrls,
        'profile': newPhotoUrl, // Simpan URL gambar di Firestore
      }).then((DocumentReference idDocument) {
        print('Document added with ID: ${idDocument.id}');
        usernameController.clear();
        emailController.clear();
        fasilitasController.clear();
        alamatController.clear();
        deskripsitokoController.clear();
        titikkoordinatController.clear();
        bukaTokoController.clear();
        tutupTokoController.clear();
        controller.clearImages();
        print('Foto Paths: $imageUrls');
      }).catchError((error) {
        print('Error: $error');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xff804A20),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Edit Data Toko', style: TextStyle(fontSize: 25)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: fotoPath != null
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.white,
                            backgroundImage: currentPhotoUrl != null
                                ? AssetImage(currentPhotoUrl!)
                                : AssetImage(
                                    'lib/images/profile.png'), // Ganti dengan path ke gambar default lokal Anda
                          ),
                        ),
                ),
                Positioned(
                  child: IconButton(
                    onPressed: selectPhoto,
                    icon: const Icon(Icons.add_a_photo),
                    color: Colors.blue,
                  ),
                  bottom: -5,
                  left: 230,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nama Lengkap Toko',
                hintText: 'Masukkan Nama Lengkap Toko',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Masukkan Alamat Email',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: alamatController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Alamat',
                hintText: 'Masukkan Alamat Toko',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: titikkoordinatController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Titik Koordinat',
                hintText: 'Masukkan Titik Koordinat',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: deskripsitokoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
                labelText: 'Deskripsi Produk',
                hintText: 'Tambahkan deskripsi di sini...',
              ),
              maxLines: 4,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: fasilitasController,
              decoration: InputDecoration(
                labelText: 'Fasilitas Tokomu',
                hintText: 'Tambahkan Fasilitas Tokomu...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: screenWidth * 0.04,
                  horizontal: screenWidth * 0.02,
                ),
              ),
              maxLines: 4,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: bukaTokoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Waktu Buka Toko',
                hintText: 'Pilih waktu buka toko',
              ),
              readOnly: true, // Set text field menjadi readonly
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedTime != null) {
                  setState(() {
                    bukaTokoController.text = selectedTime.format(context);
                  });
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: tutupTokoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Waktu Tutup Toko',
                hintText: 'Pilih waktu Tutup toko',
              ),
              readOnly: true, // Set text field menjadi readonly
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedTime != null) {
                  setState(() {
                    tutupTokoController.text = selectedTime.format(context);
                  });
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Foto Tokomu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
            MultiImagePickerView(
              onChange: (_) {
                setState(() {
                  images = controller.images.toList();
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
          onPressed: _uploadImage, // Panggil fungsi ini saat tombol ditekan
          style: ElevatedButton.styleFrom(primary: Color(0xFF4E598C)),
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

  @override
  void dispose() {
    // Dispose controllers
    usernameController.dispose();
    emailController.dispose();
    fasilitasController.dispose();
    alamatController.dispose();
    deskripsitokoController.dispose();
    titikkoordinatController.dispose();
    bukaTokoController.dispose();
    tutupTokoController.dispose();
    super.dispose();
  }
}
