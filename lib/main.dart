import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:quraan/binding/binding.dart';
import 'package:quraan/controller/settings_controller.dart';
import 'package:quraan/controller/surah_controller.dart';
import 'package:quraan/core/services/shared_preferences.dart';
import 'package:quraan/view/screen/selection_screen.dart';
import 'package:quraan/view/screen/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initia();
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

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(SplashScreenController());
//     return
//   }
// }
