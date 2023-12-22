import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_finder/customer/akun-page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker picker = ImagePicker();
  File? fotoPath;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  List<String> genderOptions = ['Laki-laki', 'Perempuan'];
  String selectedGender = 'Jenis Kelamin';
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  Future<File?> selectPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        fotoPath = File(pickedFile.path);
      });
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

        setState(() {
          nameController.text = userDoc['username'] ?? '';
          emailController.text = user.email ?? '';
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  void saveProfile() async {
    try {
      String? fotoUrl;

      // Cek jika foto telah dipilih
      if (fotoPath != fotoPath) {
        String filePath = 'userprofile/${DateTime.now()}.png';
        await FirebaseStorage.instance.ref(filePath).putFile(fotoPath!);
        fotoUrl = await FirebaseStorage.instance.ref(filePath).getDownloadURL();
      }

      final user = FirebaseAuth.instance.currentUser;
      final String uid = user?.uid ?? '';

      // Simpan data profil ke koleksi 'data customer' di Firestore
      await FirebaseFirestore.instance
          .collection('data_customer')
          .doc(uid)
          .set({
        'username': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'alamat': alamatController.text,
        'jenis kelamin': selectedGender,
        'foto': fotoUrl
        // tambahkan kolom lain sesuai kebutuhan
      });

      // Tambahan: Jika Anda juga ingin memperbarui data pengguna di koleksi 'users'
      // bisa menggunakan kode berikut:
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.email)
          .update({
        'username': nameController.text,
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
        MaterialPageRoute(builder: (context) => Akun()),
      );
    } catch (e) {
      print('Error saving profile: $e');
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
                builder: (context) => Akun(),
              ),
            );
          },
          icon: Icon(Icons.navigate_before),
        ),
        title: Text(
          'Edit Profile',
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
                            // child: CircleAvatar(
                            //   radius: 55,
                            //   backgroundColor: Colors.white,
                            //   backgroundImage: MemoryImage(fotoPath!),
                            // ),
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
                              backgroundImage: NetworkImage(
                                  'https://png.pngitem.com/pimgs/s/421-4212266_transparent-default-avatar.png'),
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
                      'Nama Lengkap: ',
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
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan teks di sini',
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
                    hintText: 'Masukkan teks di sini',
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
                      'Jenis Kelamin: ',
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
                child: DropdownButtonFormField<String>(
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                  items: genderOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    Text(
                      'Nomor Telepon: ',
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
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Tambahkan Nomor Telepon di sini',
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
