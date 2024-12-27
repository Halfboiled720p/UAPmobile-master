import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  // Menyembunyikan / menampilkan password
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Menyembunyikan / menampilkan confirm password
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  // Fungsi untuk register
  void register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Validasi password dan konfirmasi password
    if (password != confirmPassword) {
      Get.snackbar('Error', 'Password dan konfirmasi password tidak sama.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Validasi format email
    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Error', 'Format email tidak valid.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      // Proses pendaftaran menggunakan Firebase Authentication
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Jika pendaftaran berhasil
      Get.snackbar('Success', 'Pendaftaran berhasil!',
          snackPosition: SnackPosition.BOTTOM);

      // Setelah berhasil, arahkan pengguna ke halaman login atau dashboard
      // Misalnya:
      // Get.offAllNamed('/login');
      // atau
      // Get.offAllNamed('/dashboard_view');
    } on FirebaseAuthException catch (e) {
      // Menangani error jika terjadi masalah saat pendaftaran
      String errorMessage = '';
      if (e.code == 'weak-password') {
        errorMessage = 'Password terlalu lemah.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Email sudah digunakan.';
      } else {
        errorMessage = 'Pendaftaran gagal. Coba lagi.';
      }

      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      // Menangani error umum lainnya
      Get.snackbar('Error', 'Terjadi kesalahan. Coba lagi.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
