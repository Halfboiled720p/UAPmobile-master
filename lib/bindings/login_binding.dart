import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Menghubungkan LoginController dengan View yang membutuhkan
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
