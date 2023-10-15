import 'package:get/get.dart';
import 'package:quraan/controller/detailsurahcontroller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailSurahController());
  }
}
