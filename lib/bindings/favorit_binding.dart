import 'package:get/get.dart';
import '../controllers/favorit_controller.dart';

class FavoritBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoritController());
  }
}
