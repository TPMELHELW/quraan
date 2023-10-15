import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:quraan/binding/binding.dart';
import 'package:quraan/controller/splashscreencontroller.dart';
import 'package:quraan/core/services/sharedpreferences.dart';
import 'package:quraan/view/screen/selectionscreen.dart';
import 'package:quraan/view/screen/welcomescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initia();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: MainBinding(), home: const SplashScreen());
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

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset("assets/images/1.png"),
          const SpinKitThreeBounce(
            color: Colors.white,
            size: 50,
          )
        ]));
  }
}
