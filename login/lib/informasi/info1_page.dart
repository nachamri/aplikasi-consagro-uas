import 'package:flutter/material.dart';

void main() {
  runApp(InformationPage1());
}

class InformationPage1 extends StatelessWidget {
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
              'Informasi Pertanian Indonesia',
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
                  image: AssetImage('assets/images/pertaindo.jpeg'), // Ganti dengan path gambar Anda
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
              'Informasi Terkini Tentang Pertanian Indonesia',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Menteri Pertanian Amran Sulaiman mengatakan selama 3 bulan kondisi produksi pangan strategis Indonesia, macam beras dan jagung bakal masuk dalam kondisi kritis. Hal ini terjadi karena musim kemarau akan tiba.Amran menjelaskan sejauh ini iklim cuaca kering El Nino sebetulnya belum selesai, diperkirakan siklus El Nino baru selesai pada bulan Juli hingga Agustus. Masalahnya, mulai Agustus ini Indonesia memasuki musim kemarau.Kemarau sendiri akan terjadi Agustus, September, hingga Oktober. Tiga bulan ini lah yang disebut Amran  sebagai masa kritis produksi pangan  .Baca artikel detikfinance,Produksi Pangan RI Disebut Sedang Kritis, Ada Apa?dari Download Apps Detikcom Sekarang https://apps.detik.com/detik/',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}