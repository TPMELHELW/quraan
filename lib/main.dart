import 'package:Moshafi/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:Moshafi/core/binding/binding.dart';
import 'package:Moshafi/controller/settings_controller.dart';
import 'package:Moshafi/controller/surah_controller.dart';
import 'package:Moshafi/core/services/shared_preferences.dart';
import 'package:Moshafi/view/screen/selection_screen.dart';
import 'package:Moshafi/view/screen/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initia();
  await JustAudioBackground.init(
    androidNotificationIcon: 'mipmap/launcher_icon',
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
    androidNotificationChannelDescription: 'M.E',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SurahController());
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (controller) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: MainBinding(),
          home: Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/1.png"),
                const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 50,
                )
              ],
            ),
          ),
          themeMode: controller.themeMode,
          theme: controller.customLightTheme,
          darkTheme: controller.customDarkTheme,
        );
      },
    );
  }
}

class StackScreen extends StatelessWidget {
  const StackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LiquidSwipe(
          enableLoop: false,
          disableUserGesture: false,
          enableSideReveal: false,
          preferDragFromRevealedArea: true,
          pages: const [
            WelcomeScreen(),
            SelectionScreen(),
          ],
        )
      ],
    );
  }
}
