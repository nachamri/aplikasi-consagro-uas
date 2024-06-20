import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'formkonsul_page.dart';


// page pemanggilan untuk mengedit konsultasi yang sudah di tampilkan
class EditConsultationPage extends StatefulWidget {
  final dynamic consultation;

  EditConsultationPage({required this.consultation});

  @override
  _EditConsultationPageState createState() => _EditConsultationPageState();
}

class _EditConsultationPageState extends State<EditConsultationPage> {
  late TextEditingController _namaPetaniController;
  late TextEditingController _alamatPetaniController;
  late TextEditingController _jenisTanamanController;
  late TextEditingController _penyakitTanamanController;
  late TextEditingController _lokasiPertanianController;
  late TextEditingController _catatanTambahanController;

  @override
  void initState() {
    super.initState();
    _namaPetaniController = TextEditingController(text: widget.consultation['nama_petani']);
    _alamatPetaniController = TextEditingController(text: widget.consultation['alamat_petani']);
    _jenisTanamanController = TextEditingController(text: widget.consultation['jenis_tanaman']);
    _penyakitTanamanController = TextEditingController(text: widget.consultation['penyakit_tanaman']);
    _lokasiPertanianController = TextEditingController(text: widget.consultation['lokasi_pertanian']);
    _catatanTambahanController = TextEditingController(text: widget.consultation['catatan_tambahan']);
  }

  @override
  void dispose() {
    _namaPetaniController.dispose();
    _alamatPetaniController.dispose();
    _jenisTanamanController.dispose();
    _penyakitTanamanController.dispose();
    _lokasiPertanianController.dispose();
    _catatanTambahanController.dispose();
    super.dispose();
  }

//pemanggilan alamat api
  Future<void> _saveConsultation() async {
    final url = Uri.parse('http://192.168.223.241:3000/api/updateKonsultasi/${widget.consultation['id']}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nama_petani': _namaPetaniController.text,
        'alamat_petani': _alamatPetaniController.text,
        'jenis_tanaman': _jenisTanamanController.text,
        'penyakit_tanaman': _penyakitTanamanController.text,
        'lokasi_pertanian': _lokasiPertanianController.text,
        'catatan_tambahan': _catatanTambahanController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil diupdate')),
      );
      Navigator.pop(context, true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ConsultationListPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengupdate data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(
          'Edit Konsultasi',
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
          
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _namaPetaniController,
                decoration: InputDecoration(labelText: 'Nama Petani'),
              ),
              TextField(
                controller: _alamatPetaniController,
                decoration: InputDecoration(labelText: 'Alamat Petani'),
              ),
              TextField(
                controller: _jenisTanamanController,
                decoration: InputDecoration(labelText: 'Jenis Tanaman'),
              ),
              TextField(
                controller: _penyakitTanamanController,
                decoration: InputDecoration(labelText: 'Penyakit Tanaman'),
              ),
              TextField(
                controller: _lokasiPertanianController,
                decoration: InputDecoration(labelText: 'Lokasi Pertanian'),
              ),
              TextField(
                controller: _catatanTambahanController,
                decoration: InputDecoration(labelText: 'Catatan Tambahan'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveConsultation,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
