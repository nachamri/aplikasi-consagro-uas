import 'package:flutter/material.dart';

void main() {
  runApp(InformationPage2());
}

class InformationPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Pertanian',),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Informasi Pertanian Daerah Bojonegoro',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/tanijonegoro.jpeg'), // Ganti dengan path gambar Anda
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Informasi Terkini Tentang Pertanian Daerah Bojonegoro',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Hasil pertanian padi di Kabupaten Bojonegoro terus meningkat. Tahun 2021 lalu luas tanam mencapai 152.872 haktare, naik dibanding 2020 yang hanya mencapai 150.664 hektare. Tahun ini, Dinas Ketahanan Pangan dan Pertanian (DKPP) menargetkan luas tanam jauh lebih besar lagi.Kabid Tanaman Pangan Holtikultura, dan Perkebunan DKPP Bojonegoro, Imam Nurhamid Arifin mengatakan tahun ini luas tanam di Bojonegoro ditargetkan mencapai 153.250 hektare. Target tersebut optimistis tercapai karena lahan di Bojonegoro sangat mendukung dan sistem pengairan juga mendukung hasil panen yang melimpah.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}