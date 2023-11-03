import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/settings_controller.dart';
import 'package:quraan/view/screen/aboutapp.dart';
import 'package:quraan/view/screen/change_size_screen.dart';
import 'package:quraan/view/widget/containerview.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // SettingsController controller = Get.put(SettingsController());
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SettingsController>(
          init: SettingsController(),
          builder: (controller) {
            return ListView(
              children: [
                ContainerView(
                  mainText: "Tap to change the Theme",
                  subText: controller.myservices.shared.getBool("dark") == true
                      ? "Light Mode"
                      : "Dark Mode",
                  onPressed: () {
                    controller.onPress();
                    controller.update();
                  },
                ),
                ContainerView(
                  mainText: "Change the size ",
                  subText: "Ayah,Tafsir",
                  onPressed: () {
                    Get.to(const ChangeSizeScreen());
                  },
                ),
                ContainerView(
                  mainText: "About App",
                  subText: "About App",
                  onPressed: () {
                    Get.to(const AboutApp());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
