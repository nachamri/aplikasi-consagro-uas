const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
const port = 3000;
const host = "192.168.223.241";

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Konfigurasi koneksi database
const db = mysql.createConnection({
  host: '192.168.223.241',
  user: 'root',
  password: '',
  database: 'consagro'
});

// Connect ke database
db.connect(err => {
  if (err) {
    console.error('Error connecting to MySQL:', err);
    return;
  }
  console.log('MySQL Connected...');
});

// Register User
app.post('/api/register', (req, res) => {
  const { name, username, password } = req.body;
  const sql = 'INSERT INTO register (name, username, password) VALUES (?, ?, ?)';
  db.query(sql, [name, username, password], (err, result) => {
    if (err) {
      return res.status(500).json({
        status: false,
        message: 'Error adding user',
        error: err.message
      });
    }
    res.status(200).json({
      status: true,
      name,
      username,
      password,
    });
  });
});

// Login User
app.post('/api/login', (req, res) => {
  const { username, password } = req.body;
  const sql = 'SELECT * FROM register WHERE username = ? AND password = ?';
  db.query(sql, [username, password], (err, result) => {
    if (err) {
      return res.status(500).json({
        status: false,
        message: 'Error during login',
        error: err.message
      });
    }
    if (result.length > 0) {
      res.status(200).json({
        status: true,
        message: 'Login successful',
        user: result[0]
      });
    } else {
      res.status(401).json({
        status: false,
        message: 'Invalid username or password'
      });
    }
  });
});

//user medaftar konsultasi
app.post('/api/konsultasi', (req, res) => {
    const { id, nama_petani, alamat_petani, jenis_tanaman, penyakit_tanaman, lokasi_pertanian, catatan_tambahan } = req.body;
    const sql = 'INSERT INTO konsultasi ( id, nama_petani, alamat_petani, jenis_tanaman, penyakit_tanaman, lokasi_pertanian, catatan_tambahan) VALUES (?, ?, ?, ?, ?, ?, ?)';
    db.query(sql, [id, nama_petani, alamat_petani, jenis_tanaman, penyakit_tanaman, lokasi_pertanian, catatan_tambahan], (err, result) => {
      if (err) {
        return res.status(500).json({
          status: false,
          message: 'Error adding konsultasi',
          error: err.message
        });
      }
      res.status(200).json({
        status: true,
        id,
        nama_petani, 
        alamat_petani, 
        jenis_tanaman, 
        penyakit_tanaman, 
        lokasi_pertanian, 
        catatan_tambahan
      });
    });
  });
  
// Get Konsultasi
app.get('/api/getKonsultasi', (req, res) => {
    const sql = 'SELECT * FROM konsultasi';
    db.query(sql, (err, result) => {
      if (err) {
        return res.status(500).json({
          status: false,
          message: 'Error retrieving konsultasi',
          error: err.message
        });
      }
      res.status(200).json(result);
    });
  });

  //page layanan kritik dan saran
  app.post('/api/layanan', (req, res) => {
    const { saran } = req.body;
    const sql = 'INSERT INTO layanan (saran) VALUES (?)';
    db.query(sql, [saran], (err, result) => {
      if (err) {
        return res.status(500).json({
          status: false,
          message: 'Error adding user',
          error: err.message
        });
      }
      res.status(200).json({
        status: true,
        saran
       ,
      });
    });
  });

  //route menampilkan data konsultasi
  app.get('/api/getKonsultasi', (req, res) => {
    db.query('SELECT * FROM konsultasi', (err, results) => {
      if (err) throw err;
      res.json(results);
    });
  });
  
  //Route untuk Update Konsultasi
  app.put('/api/updateKonsultasi/:id', (req, res) => {
    const id = req.params.id;
    const { nama_petani, alamat_petani, jenis_tanaman, penyakit_tanaman, lokasi_pertanian, catatan_tambahan } = req.body;
    db.query(
      'UPDATE konsultasi SET nama_petani = ?, alamat_petani = ?, jenis_tanaman = ?, penyakit_tanaman = ?, lokasi_pertanian = ?, catatan_tambahan = ? WHERE id = ?',
      [nama_petani, alamat_petani, jenis_tanaman, penyakit_tanaman, lokasi_pertanian, catatan_tambahan, id],
      (err, result) => {
        if (err) {
          return res.status(500).json({
            status: false,
            message: 'Error updating konsultasi',
            error: err.message
          });
        }
        res.status(200).json({
          status: true,
          message: 'Konsultasi updated successfully',
          data: {
            nama_petani, 
            alamat_petani, 
            jenis_tanaman, 
            penyakit_tanaman, 
            lokasi_pertanian, 
            catatan_tambahan
          }
        });
      }
    );
  });
  

  // Route untuk menghapus data konsutasi
  app.delete('/api/deleteKonsultasi', (req, res) => {
    const { id } = req.body;
    db.query('DELETE FROM konsultasi WHERE id = ?',
      [id],
      (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).json({ error: 'Internal server error' });
          return;
        }
        res.sendStatus(200); // Berhasil menghapus
      }
    );
  });
  
 
// Start server
app.listen(port, host, () => {
  console.log(`Server started on http://${host}:${port}`);
});
