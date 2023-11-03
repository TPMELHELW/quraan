import 'package:get/get.dart';
import 'package:quraan/main.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Get.offAll(() => const StackScreen());
    });
    super.onInit();
  }
}
