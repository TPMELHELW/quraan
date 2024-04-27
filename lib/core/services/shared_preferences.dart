import 'package:Moshafi/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services extends GetxService {
  late SharedPreferences shared;
  Future<Services> init() async {
    shared = await SharedPreferences.getInstance();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      provisional: false,
    );
    final token = await FirebaseMessaging.instance.getToken();
    print(token.toString());
    return this;
  }
}

initia() async {
  await Get.putAsync(() => Services().init());
}
