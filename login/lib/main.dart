import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'home_page.dart';
import 'informasi_page.dart';
import 'konsul_page.dart';
import 'layanan_page.dart';
import 'portofolio_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/informasi': (context) => InformationPage(),
        '/konsul': (context) => AgricultureConsultationApp(),
        '/layanan': (context) => FeedbackApp(),
        '/portofolio': (context) => ProfileApp(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3), // Waktu tunda splash screen
      () => Navigator.pushReplacementNamed(
          context, '/login'), // Arahkan ke halaman login
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // Warna latar belakang hijau
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(), // Tambahkan animasi loading
            SizedBox(height: 24),
            Text(
              'Consagro', // Nama aplikasi atau merek
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
