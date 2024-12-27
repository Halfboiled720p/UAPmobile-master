import 'package:get/get.dart';
import '../controllers/write_resep_controller.dart';

class WriteResepBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WriteResepController());
  }
}
