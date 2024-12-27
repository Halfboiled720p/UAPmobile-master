import 'package:get/get.dart';
import '../controllers/inspiration_controller.dart';

class InspirationBinding extends Bindings {
  @override
  void dependencies() {
    // Register the InspirationController when the page is accessed
    Get.put(InspirationController());
  }
}
