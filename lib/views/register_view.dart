import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      backgroundColor: Color(0xFFF5E1A4), // Warna krem untuk latar belakang
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 80), // Jarak dari atas
              // Gambar lingkaran di atas
              ClipOval(
                child: Container(
                  color: Colors.white,
                  width: 180,
                  height: 180,
                  child: Image.asset(
                    'assets/register_image.png', // Ganti dengan gambar sesuai
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Input Email
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 15),
              // Input Password
              Obx(() {
                return TextField(
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordHidden.value,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(controller.isPasswordHidden.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                );
              }),
              SizedBox(height: 15),
              // Input Confirm Password
              Obx(() {
                return TextField(
                  controller: controller.confirmPasswordController,
                  obscureText: controller.isConfirmPasswordHidden.value,
                  decoration: InputDecoration(
                    hintText: "Konfirmasi Password",
                    suffixIcon: IconButton(
                      icon: Icon(controller.isConfirmPasswordHidden.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: controller.toggleConfirmPasswordVisibility,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                );
              }),
              SizedBox(height: 20),
              // Tombol Daftar
              ElevatedButton(
                onPressed: controller.register,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.orange,
                ),
                child: Text(
                  'Daftar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              // Link Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sudah punya akun? ", style: TextStyle(color: Colors.black)),
                  GestureDetector(
                    onTap: () {
                      Get.back(); // Navigasi kembali ke halaman login
                    },
                    child: Text(
                      "Masuk sekarang!",
                      style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
