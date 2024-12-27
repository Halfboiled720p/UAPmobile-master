import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Menambahkan ProfileController ke dalam GetX
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
