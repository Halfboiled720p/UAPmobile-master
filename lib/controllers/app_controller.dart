import 'package:get/get.dart';

class AppController extends GetxController {
  var isAuthenticated = false.obs; // Menyimpan status login atau pendaftaran

  // Fungsi untuk toggle status login/daftar
  void toggleAuthentication() {
    isAuthenticated.value = !isAuthenticated.value;
  }
}
