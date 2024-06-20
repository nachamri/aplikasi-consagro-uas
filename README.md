Berikut adalah langkah-langkah untuk menginstal Node.js dan menghubungkannya dengan Flutter:

### 1. Instal Node.js
1. **Unduh Node.js**:
   - Kunjungi [situs resmi Node.js](https://nodejs.org/).
   - Pilih versi LTS (Long Term Support) untuk stabilitas yang lebih baik.
   - Unduh installer yang sesuai dengan sistem operasi Anda (Windows, macOS, atau Linux).

2. **Instal Node.js**:
   - Buka file installer yang telah diunduh.
   - Ikuti instruksi pemasangan. Pastikan untuk mencentang opsi untuk menambahkan Node.js ke PATH.

3. **Verifikasi Instalasi**:
   - Buka terminal atau command prompt.
   - Jalankan perintah berikut untuk memastikan Node.js dan npm telah terinstal dengan benar:
     ```sh
     node -v
     npm -v
     ```
   - Anda harus melihat versi Node.js dan npm yang terinstal.

### 2. Instal Flutter
1. **Unduh Flutter SDK**:
   - Kunjungi [situs resmi Flutter](https://flutter.dev/).
   - Unduh Flutter SDK yang sesuai dengan sistem operasi Anda.

2. **Ekstrak Flutter SDK**:
   - Ekstrak file zip ke lokasi yang diinginkan di sistem Anda.

3. **Tambahkan Flutter ke PATH**:
   - Tambahkan path ke `flutter/bin` ke variabel lingkungan PATH Anda.
   - Misalnya, di macOS dan Linux, tambahkan baris berikut ke file `.bashrc`, `.bash_profile`, atau `.zshrc` Anda:
     ```sh
     export PATH="$PATH:[path_to_flutter_directory]/flutter/bin"
     ```
   - Di Windows, tambahkan path ke `flutter/bin` melalui System Properties -> Advanced -> Environment Variables.

4. **Verifikasi Instalasi Flutter**:
   - Buka terminal atau command prompt.
   - Jalankan perintah berikut untuk memastikan Flutter telah terinstal dengan benar:
     ```sh
     flutter doctor
     ```
   - Ikuti instruksi untuk menyelesaikan pengaturan lingkungan pengembangan Anda.

### 3. Menghubungkan Node.js dengan Flutter
Node.js biasanya digunakan dalam proyek Flutter untuk beberapa tujuan seperti backend API, server development, atau alat pengembangan seperti linting dan building tools. Berikut adalah contoh mengintegrasikan backend Node.js dengan aplikasi Flutter.

1. **Buat Proyek Flutter**:
   - Jalankan perintah berikut di terminal:
     ```sh
     flutter create my_flutter_app
     ```
   - Masuk ke direktori proyek:
     ```sh
     cd my_flutter_app
     ```

2. **Buat Proyek Node.js**:
   - Buat direktori baru untuk proyek Node.js di luar proyek Flutter atau di dalam direktori `my_flutter_app`.
     ```sh
     mkdir backend
     cd backend
     ```
   - Inisialisasi proyek Node.js:
     ```sh
     npm init -y
     ```
   - Instal express (atau framework lain yang Anda inginkan):
     ```sh
     npm install express
     ```

3. **Buat Server Sederhana dengan Node.js**:
   - Buat file `server.js` di direktori `backend` dan tambahkan kode berikut:
     ```js
     const express = require('express');
     const app = express();
     const port = 3000;

     app.get('/', (req, res) => {
       res.send('Hello from Node.js server!');
     });

     app.listen(port, () => {
       console.log(`Server running at http://localhost:${port}/`);
     });
     ```
   - Jalankan server:
     ```sh
     node server.js
     ```
   - Anda harus melihat pesan di terminal bahwa server berjalan di port 3000. Buka browser dan akses `http://localhost:3000/` untuk memastikan server berjalan dengan benar.

4. **Hubungkan Flutter ke Server Node.js**:
   - Di dalam aplikasi Flutter, tambahkan dependency `http` di `pubspec.yaml`:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       http: ^0.14.0
     ```
   - Jalankan `flutter pub get` untuk menginstal dependency.

   - Di dalam Flutter, buat HTTP request ke server Node.js. Misalnya, di file `lib/main.dart`:
     ```dart
     import 'package:flutter/material.dart';
     import 'package:http/http.dart' as http;

     void main() {
       runApp(MyApp());
     }

     class MyApp extends StatelessWidget {
       @override
       Widget build(BuildContext context) {
         return MaterialApp(
           home: Scaffold(
             appBar: AppBar(
               title: Text('Flutter Node.js Example'),
             ),
             body: Center(
               child: FutureBuilder(
                 future: fetchMessage(),
                 builder: (context, snapshot) {
                   if (snapshot.connectionState == ConnectionState.waiting) {
                     return CircularProgressIndicator();
                   } else if (snapshot.hasError) {
                     return Text('Error: ${snapshot.error}');
                   } else {
                     return Text('Message from server: ${snapshot.data}');
                   }
                 },
               ),
             ),
           ),
         );
       }

       Future<String> fetchMessage() async {
         final response = await http.get(Uri.parse('http://localhost:3000/'));
         if (response.statusCode == 200) {
           return response.body;
         } else {
           throw Exception('Failed to load message');
         }
       }
     }
     ```

5. **Jalankan Aplikasi Flutter**:
   - Jalankan aplikasi Flutter dengan perintah:
     ```sh
     flutter run
     ```
   - Aplikasi akan menampilkan pesan dari server Node.js di layar utama.

Dengan langkah-langkah di atas, Anda telah berhasil menginstal Node.js, membuat proyek Flutter, dan menghubungkannya dengan server Node.js. Anda dapat memperluas fungsionalitas server dan aplikasi Flutter sesuai kebutuhan Anda
