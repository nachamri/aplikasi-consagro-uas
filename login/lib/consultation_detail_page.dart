import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'editconsultation_page.dart';
import 'formkonsul_page.dart';
import 'home_page.dart';

class ConsultationDetailPage extends StatelessWidget {
  final dynamic consultation;

  ConsultationDetailPage(this.consultation);

  Future<void> deleteConsultation(BuildContext context) async {
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.223.241:3000/api/deleteKonsultasi'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': consultation['id'],
        }),
      );

      if (response.statusCode == 200) {
        // Jika berhasil dihapus, tampilkan pesan dan arahkan ke halaman utama
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("Konsultasi Berhasil terhapus."),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConsultationListPage()),
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Jika gagal, tampilkan pesan kesalahan
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Failed to delete consultation"),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Tangani error ketika terjadi
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("An error occurred. Please try again later."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }


// Menampilkan detai untuk konsultasi yang di berikan
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Konsultasi Pertanian',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8), // SizedBox untuk jarak antara elemen
            Text('ID: ${consultation['id']}'),
            SizedBox(height: 8),
            Text('Nama Petani: ${consultation['nama_petani']}'),
            SizedBox(height: 8),
            Text('Alamat Petani: ${consultation['alamat_petani']}'),
            SizedBox(height: 8),
            Text('Jenis Tanaman: ${consultation['jenis_tanaman']}'),
            SizedBox(height: 8),
            Text('Penyakit Tanaman: ${consultation['penyakit_tanaman']}'),
            SizedBox(height: 8),
            Text('Lokasi Pertanian: ${consultation['lokasi_pertanian']}'),
            SizedBox(height: 8),
            Text('Catatan Tambahan: ${consultation['catatan_tambahan']}'),
            SizedBox(height: 20), // Adding space before buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditConsultationPage(
                          consultation: consultation, // Pass the consultation object
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit, color: Colors.white),
                  label: Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue, // Text color
                    side: BorderSide(color: Colors.white), // Border color
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    deleteConsultation(context); // Panggil fungsi untuk menghapus konsultasi
                  },
                  icon: Icon(Icons.delete, color: Colors.white),
                  label: Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red, // Text color
                    side: BorderSide(color: Colors.white), // Border color
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
