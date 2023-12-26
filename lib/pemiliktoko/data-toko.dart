import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_finder/pemiliktoko/kelola-toko.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class ProfileToko extends StatefulWidget {
  const ProfileToko({Key? key}) : super(key: key);

  @override
  _ProfileTokoState createState() => _ProfileTokoState();
}

class _ProfileTokoState extends State<ProfileToko> {
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
  Iterable<ImageFile> images = [];
  List<String> imageUrls = [];

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
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .get();

        // Ambil data dari koleksi 'data_customer'
        final DocumentSnapshot dataTokoDoc = await FirebaseFirestore.instance
            .collection('datatoko')
            .doc(user.uid)
            .get();

        setState(() {
          usernameController.text = userDoc['username'] ?? '';
          emailController.text = user.email ?? '';
          alamatController.text = dataTokoDoc['alamat'] ?? '';
          titikkoordinatController.text = dataTokoDoc['titikkoordinat'] ?? '';
          deskripsitokoController.text = dataTokoDoc['deskripsi'] ?? '';
          fasilitasController.text = dataTokoDoc['fasilitas'] ?? '';
          bukaTokoController.text = dataTokoDoc['waktubuka'] ?? '';
          tutupTokoController.text = dataTokoDoc['waktututup'] ?? '';
          currentPhotoUrl = dataTokoDoc['profile'] ?? '';
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<String> uploadImage(File imageFile) async {
    String filePath = 'tokoprofile/${DateTime.now()}.png';
    TaskSnapshot snapshot =
        await FirebaseStorage.instance.ref(filePath).putFile(imageFile);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void saveProfile() async {
    try {
      String? fotoUrl;

      // Cek jika foto telah dipilih
      if (fotoPath != null) {
        String filePath = 'tokoprofile/${DateTime.now()}.png';
        await FirebaseStorage.instance.ref(filePath).putFile(fotoPath!);
        fotoUrl = newPhotoUrl ?? await uploadImage(fotoPath!);
        fotoUrl = await FirebaseStorage.instance.ref(filePath).getDownloadURL();
      }

      final user = FirebaseAuth.instance.currentUser;
      final String uid = user?.uid ?? '';

      // Simpan data profil ke koleksi 'data toko' di Firestore
      await FirebaseFirestore.instance.collection('datatoko').doc(uid).set({
        'username': usernameController.text,
        'email': emailController.text,
        'fasilitas': fasilitasController.text,
        'alamat': alamatController.text,
        'deskripsi': deskripsitokoController.text,
        'waktubuka': bukaTokoController.text,
        'waktututup': tutupTokoController.text,
        'titikkoordinat': titikkoordinatController.text,
        'fotoPaths': imageUrls,
        'profile': fotoUrl,
        // tambahkan kolom lain sesuai kebutuhan
      });

      // Tambahan: Jika Anda juga ingin memperbarui data pengguna di koleksi 'users'
      // bisa menggunakan kode berikut:
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.email)
          .update({
        'username': usernameController.text,
        'email': emailController.text,
      });

      // Jangan lupa menampilkan pesan sukses atau navigasi ke halaman lain jika diperlukan.
      print('Profile berhasil disimpan!');

      Fluttertoast.showToast(
        msg: 'Data berhasil diubah!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      // Navigasi ke halaman akun setelah berhasil menyimpan
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => KelolaToko()),
      );
    } catch (e) {
      print('Error saving profile: $e');
    }
  }

  Future<void> _uploadImage() async {
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

        newPhotoUrl = imageUrl;
        // Perbarui currentPhotoUrl
        setState(() {
          currentPhotoUrl = newPhotoUrl;
        });
      }).catchError((onError) {
        print('Error uploading image: $onError');
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff804A20),
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KelolaToko(),
              ),
            );
          },
          icon: Icon(Icons.navigate_before),
        ),
        title: Text(
          'Edit Data Toko',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffF6F0E9),
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: fotoPath != null
                          ? Container(
                              width: 110.0,
                              height: 110.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              child: Image.file(
                                fotoPath!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: 110.0,
                              height: 110.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              child: currentPhotoUrl != null
                                  ? Image.network(
                                      currentPhotoUrl!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      'https://png.pngitem.com/pimgs/s/421-4212266_transparent-default-avatar-png-default-avatar-images-png.png',
                                      fit: BoxFit.cover,
                                    ),
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
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Text(
                      'Nama Toko: ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff757575),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nama Lengkap Toko',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Text(
                      'Email: ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 117, 117, 117),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
                  controller: emailController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Email di sini',
                    hintStyle:
                        TextStyle(color: Colors.black), // Warna teks label
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Text(
                      'Alamat: ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff757575),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
                  controller: alamatController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Alamat di sini',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Text(
                      'Titik Koordinat: ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff757575),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
                  controller: titikkoordinatController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Titik Koordinat',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Text(
                      'Deskripsi: ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff757575),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
                  controller: deskripsitokoController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Deskripsi Toko',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              //   child: Row(
              //     children: [
              //       Text(
              //         'Fasilitas: ',
              //         style: TextStyle(
              //           fontSize: 14,
              //           fontWeight: FontWeight.bold,
              //           color: Color(0xff757575),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              //   child: TextField(
              //     controller: fasilitasController,
              //     decoration: InputDecoration(
              //       hintText: 'Masukkan Fasilitas Toko',
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              //   child: Row(
              //     children: [
              //       Text(
              //         'Waktu Buka: ',
              //         style: TextStyle(
              //           fontSize: 14,
              //           fontWeight: FontWeight.bold,
              //           color: Color(0xff757575),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              //   child: TextField(
              //     controller: bukaTokoController,
              //     decoration: InputDecoration(
              //       hintText: 'Tambahkan Waktu Buka Toko',
              //       border: OutlineInputBorder(),
              //     ),
              //     onTap: () async {
              //       TimeOfDay? selectedTime = await showTimePicker(
              //         context: context,
              //         initialTime: TimeOfDay.now(),
              //       );
              //       if (selectedTime != null) {
              //         setState(() {
              //           bukaTokoController.text = selectedTime.format(context);
              //         });
              //       }
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              //   child: Row(
              //     children: [
              //       Text(
              //         'Waktu Tutup: ',
              //         style: TextStyle(
              //           fontSize: 14,
              //           fontWeight: FontWeight.bold,
              //           color: Color(0xff757575),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              //   child: TextField(
              //     controller: tutupTokoController,
              //     decoration: InputDecoration(
              //       hintText: 'Tambahkan Waktu Tutup Toko',
              //       border: OutlineInputBorder(),
              //     ),
              //     onTap: () async {
              //       TimeOfDay? selectedTime = await showTimePicker(
              //         context: context,
              //         initialTime: TimeOfDay.now(),
              //       );
              //       if (selectedTime != null) {
              //         setState(() {
              //           tutupTokoController.text = selectedTime.format(context);
              //         });
              //       }
              //     },
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   'Foto Tokomu',
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     height: 1,
              //   ),
              // ),
              // MultiImagePickerView(
              //   onChange: (_) {
              //     setState(() {
              //       images = controller.images.toList();
              //     });
              //   },
              //   controller: controller,
              //   padding: const EdgeInsets.all(10),
              // ),
              // SizedBox(height: 20),
              // if (isUploading) LinearProgressIndicator(),
              // SizedBox(
              //   height: 20,
              // ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      saveProfile();
                    },
                    child: Container(
                      color: Color(0xff4E598C),
                      width: double.infinity,
                      height: 60,
                      child: Center(
                        child: Text(
                          'Simpan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}