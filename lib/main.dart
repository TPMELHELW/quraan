import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:quraan/binding/binding.dart';
import 'package:quraan/core/services/sharedpreferences.dart';
import 'package:quraan/view/screen/selectionscreen.dart';
import 'package:quraan/view/screen/welcomescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initia();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MainBinding(),
      home: Stack(
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
      ),
    );
  }
}
