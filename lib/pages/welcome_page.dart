import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app_controller.dart'; // Import controller

class WelcomePage extends StatelessWidget {
  final AppController controller = Get.put(AppController()); // Menginisialisasi controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Menggunakan gambar dari assets sebagai latar belakang utama
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'), // Ganti dengan gambar latar belakang Anda
            fit: BoxFit.cover, // Gambar akan menyesuaikan dengan ukuran layar
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circle untuk gambar foto dengan background putih
              ClipOval(
                child: Container(
                  color: Colors.white, // Mengubah background lingkaran menjadi putih
                  width: 180,  // Ukuran lingkaran foto
                  height: 180, // Ukuran lingkaran foto
                  child: ClipOval(
                    child: Image.asset(
                      'assets/chef_image.png', // Ganti dengan gambar yang sesuai
                      fit: BoxFit.cover,  // Memastikan gambar ter-crop dengan tepat
                      alignment: Alignment.topCenter, // Posisi gambar agar bagian atas lebih terlihat
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30), // Menambahkan jarak lebih besar antara foto dan teks
              Text(
                "Mulai hidup sehatmu hari ini!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Temukan resep makanan sehat kesukaanmu\nuntuk memasak setiap hari",
                style: TextStyle(fontSize: 18, color: Colors.white), // Memperbesar sedikit font
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50), // Menambah jarak lebih besar di bawah teks
              Obx(() {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Arahkan ke halaman login ketika tombol Masuk diklik
                        Get.toNamed('/login');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 50), // Tombol persegi panjang
                        padding: EdgeInsets.symmetric(vertical: 15), // Padding tinggi
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        controller.isAuthenticated.value ? 'Masuk' : 'Masuk',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Arahkan ke halaman register ketika tombol Daftar diklik
                        Get.toNamed('/register');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 50),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Daftar',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
