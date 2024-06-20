import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'consultation_detail_page.dart';
import 'home_page.dart';
import 'konsul_page.dart';  // Import the form page

//formulir pengisinan konsultasi
class ConsultationListPage extends StatefulWidget {
  @override
  _ConsultationListPageState createState() => _ConsultationListPageState();
}

class _ConsultationListPageState extends State<ConsultationListPage> {
  List<dynamic> consultations = [];

  Future<void> fetchConsultations() async {
    final url = Uri.parse('http://192.168.223.241:3000/api/getKonsultasi');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        consultations = jsonDecode(response.body);
      });
    } else {
      print('Gagal mengambil data konsultasi. Respons dari server: ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchConsultations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Konsultasi Pertanian',
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
      body: consultations.isEmpty
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final consultation = consultations[index];
                      return ListTile(
                        title: Text('Id: ${consultation['id']}'),
                        subtitle: Text('Nama Petani: ${consultation['nama_petani']}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConsultationDetailPage(consultation),
                            ),
                          );
                        },
                      );
                    },
                    childCount: consultations.length,
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AgricultureConsultationApp()),  // Implement this page
          );
        },
        backgroundColor: Colors.green,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 246, 249, 249), width: 2),
            borderRadius: BorderRadius.circular(56.0 / 2),
          ),
          child: Icon(
            Icons.add,
            color: const Color.fromARGB(255, 248, 248, 249),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
