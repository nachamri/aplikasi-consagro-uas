import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'formkonsul_page.dart';
import 'home_page.dart'; // Ubah dengan nama file yang sesuai

class AgricultureConsultationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konsultasi Pertanian',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConsultationForm(),
    );
  }
}

class ConsultationForm extends StatefulWidget {
  @override
  _ConsultationFormState createState() => _ConsultationFormState();
}

class _ConsultationFormState extends State<ConsultationForm> {
  final _formKey = GlobalKey<FormState>();
  String id = '';
  String farmerName = '';
  String farmerAddress = '';
  String cropType = '';
  String cropDisease = '';
  String farmLocation = '';
  String additionalNotes = '';

  Future<void> submitConsultation() async {
    final url = Uri.parse('http://192.168.223.241:3000/api/konsultasi');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id,
        'nama_petani': farmerName,
        'alamat_petani': farmerAddress,
        'jenis_tanaman': cropType,
        'penyakit_tanaman': cropDisease,
        'lokasi_pertanian': farmLocation,
        'catatan_tambahan': additionalNotes,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Konsultasi telah berhasil dikirim!'),
        ),
      );

      _formKey.currentState!.reset();
      setState(() {
        id = '';
        farmerName = '';
        farmerAddress = '';
        cropType = '';
        cropDisease = '';
        farmLocation = '';
        additionalNotes = '';
      });

      // Navigasi ke halaman detail konsultasi
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConsultationListPage(
            // Kirim id konsultasi ke halaman detail
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Gagal mengirim konsultasi! Kode respons: ${response.statusCode}'),
        ),
      );
      print('Gagal mengirim konsultasi. Respons dari server: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Formulir Konsultasi Pertanian',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 249, 250, 251),
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Color.fromRGBO(36, 110, 38, 1),
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: IconButton(
              icon: Icon(Icons.home),
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Id'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan id';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    id = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Petani'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama petani';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    farmerName = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Alamat Petani'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan alamat petani';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    farmerAddress = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Jenis Tanaman'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan jenis tanaman';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    cropType = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Penyakit Tanaman'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan jenis Penyakit tanaman';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    cropDisease = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lokasi Pertanian'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan lokasi pertanian';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    farmLocation = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Catatan Tambahan'),
                onChanged: (value) {
                  setState(() {
                    additionalNotes = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    submitConsultation();
                  }
                },
                child: Text('Kirim Konsultasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

