import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services extends GetxService {
  late SharedPreferences shared;
  Future<Services> pref() async {
    shared = await SharedPreferences.getInstance();
    return this;
  }
}

initia() async {
  await Get.putAsync(() => Services().pref());
}
