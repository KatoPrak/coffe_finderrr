import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
      home: Fasilitas(),
    );
  }
}

class Fasilitas extends StatefulWidget {
  @override
  _FasilitasState createState() => _FasilitasState();
}

class _FasilitasState extends State<Fasilitas> {
  final TextEditingController fasilitasDescriptionController =
      TextEditingController();
  final TextEditingController jamOperasionalDescriptionController =
      TextEditingController();
  bool isSubmitting = false;

  List<String> days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];
  String selectedDay = 'Senin';

  Future<void> _submitData() async {
    if (fasilitasDescriptionController.text.isEmpty ||
        jamOperasionalDescriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Deskripsi fasilitas dan jam operasional tidak boleh kosong!')));
      return;
    }

    setState(() => isSubmitting = true);

    try {
      await FirebaseFirestore.instance
          .collection('fasilitas_jam_operasional')
          .add({
        'deskripsi_fasilitas': fasilitasDescriptionController.text,
        'deskripsi_jam_operasional': jamOperasionalDescriptionController.text,
        'hari': selectedDay,
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Data berhasil diunggah!')));
    } catch (e) {
      print('Error submitting data: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal mengunggah data!')));
    } finally {
      setState(() {
        isSubmitting = false;
      });
      fasilitasDescriptionController.clear();
      jamOperasionalDescriptionController.clear();
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
        title: Text('Fasilitas & Jam Operasional'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Fasilitas Tokomu',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: fasilitasDescriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: 'Tambahkan deskripsi fasilitas toko di sini...',
                contentPadding: EdgeInsets.all(10.0),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 30),
            Text(
              'Hari',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            DropdownButton<String>(
              value: selectedDay,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDay = newValue!;
                });
              },
              items: days.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Jam Operasional',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: jamOperasionalDescriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: 'Tambahkan deskripsi jam operasional di sini...',
                contentPadding: EdgeInsets.all(10.0),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 30.0),
            if (isSubmitting) CircularProgressIndicator(),
            SizedBox(height: 20.0),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: ElevatedButton(
          onPressed: () {
            _submitData();
          },
          style: ElevatedButton.styleFrom(primary: Color(0xFF4E598C)),
          child: Text(
            'Kirim',
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
