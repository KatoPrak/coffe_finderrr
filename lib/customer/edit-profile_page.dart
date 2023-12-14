import 'dart:typed_data';

import 'package:coffe_finder/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Uint8List? _image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  void selectImage() async {
    final Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = img;
      });
    }
  }

  void saveProfile() async {
    String name = nameController.text;
    String bio = bioController.text;

    // Assuming you have a function to save the data and image
    // StoreData().saveData(name: name, bio: bio, file: _image!);
    // Replace the above line with your actual logic.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff804A20),
        leading: IconButton(
          color: Colors.white,
          onPressed: () {},
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
                    child: _image != null
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
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.white,
                              backgroundImage: MemoryImage(_image!),
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
                              backgroundImage: NetworkImage(
                                  'https://png.pngitem.com/pimgs/s/421-4212266_transparent-default-avatar-png-default-avatar-images-png.png'),
                            ),
                          ),
                  ),
                  Positioned(
                    child: IconButton(
                      onPressed: selectImage,
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
                        color: Color(0xff757575),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
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
                      'Nomor Telepon: ',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff757575)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
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
                      'Jenis Kelamin: ',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff757575)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
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
                      'Alamat: ',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff757575)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan teks di sini',
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
