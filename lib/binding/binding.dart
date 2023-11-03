import 'package:get/get.dart';
import 'package:quraan/controller/surahcontroller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SurahController());
  }
}
