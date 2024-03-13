import 'package:get/get.dart';
import 'package:quraan/controller/surah_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SurahController());
  }
}
