import 'package:get/get.dart';
import 'package:quraan/controller/detailsurahcontroller.dart';
import 'package:quraan/core/class/crud.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(DetailSurahController());
  }

}