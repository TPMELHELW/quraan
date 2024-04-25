import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Moshafi/core/services/shared_preferences.dart';

class SettingsController extends GetxController {
  double valueSliderAyah = 10;
  double valueSliderTafsir = 10;
  Services myservices = Get.find();

  late ThemeMode themeMode;

  void toggleTheme() {
    if (themeMode == ThemeMode.dark) {
      myservices.shared.setBool("dark", false);

      themeMode = ThemeMode.light;
      update();
    } else {
      myservices.shared.setBool("dark", true);

      themeMode = ThemeMode.dark;
    }
    update();
  }

  ThemeData customDarkTheme = ThemeData.dark().copyWith(
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        fontSize: 20,
        fontFamily: 'poppins',
      ),
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 35,
        fontFamily: "poppins",
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontFamily: "cairo",
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontFamily: "poppins",
      ),
      displaySmall: TextStyle(
        fontSize: 15,
        color: Color.fromARGB(255, 155, 15, 5),
        fontFamily: "cairo",
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontFamily: "cairo",
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  ThemeData customLightTheme = ThemeData.light().copyWith(
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: 'poppins',
      ),
      displayLarge: TextStyle(
        color: Colors.black,
        fontSize: 35,
        fontFamily: "poppins",
      ),
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontFamily: "cairo",
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontFamily: "poppins",
      ),
      displaySmall: TextStyle(
        fontSize: 15,
        color: Color.fromARGB(255, 155, 15, 5),
        fontFamily: "cairo",
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontFamily: "cairo",
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  @override
  void onInit() {
    if (myservices.shared.getBool('dark') == true || Get.isPlatformDarkMode) {
      themeMode = ThemeMode.dark;
      myservices.shared.setBool('dark', true);
    } else {
      themeMode = ThemeMode.light;
      myservices.shared.setBool('dark', false);
    }

    valueSliderAyah = myservices.shared.getDouble("fontsize") ?? 20;
    valueSliderTafsir = myservices.shared.getDouble("fontsizetafsir") ?? 20;
    super.onInit();
  }
}
