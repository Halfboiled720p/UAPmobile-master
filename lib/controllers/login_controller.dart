import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core

class LoginController extends GetxController {
  // Controller untuk email dan password
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Observable untuk mengatur visibilitas password
  var isPasswordHidden = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  // Fungsi untuk toggle visibilitas password
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Fungsi login
  Future<void> login() async {
    String email = emailController.text;
    String password = passwordController.text;

    // Validasi sederhana
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan password wajib diisi!",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      try {
        // Coba login menggunakan Firebase Authentication
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Jika login berhasil, navigasi ke halaman dashboard
        Get.toNamed('/dashboard');
        Get.snackbar("Success", "Login berhasil!", snackPosition: SnackPosition.BOTTOM);
      } on FirebaseAuthException catch (e) {
        // Menangani error jika login gagal
        String errorMessage = '';
        if (e.code == 'user-not-found') {
          errorMessage = 'Pengguna tidak ditemukan.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Password salah.';
        } else {
          errorMessage = 'Login gagal. Coba lagi.';
        }

        Get.snackbar("Error", errorMessage, snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  // Fungsi login menggunakan Google
  void loginWithGoogle() {
    // Implementasi login Google
    Get.snackbar("Google Login", "Login dengan Google berhasil!",
        snackPosition: SnackPosition.BOTTOM);
  }

  // Fungsi login menggunakan Facebook
  void loginWithFacebook() {
    // Implementasi login Facebook
    Get.snackbar("Facebook Login", "Login dengan Facebook berhasil!",
        snackPosition: SnackPosition.BOTTOM);
  }

  // Navigasi ke halaman daftar
  void goToRegister() {
    Get.toNamed('/register'); // Pastikan Anda sudah mendaftarkan rute ini
  }
}
