import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Moshafi/controller/settings_controller.dart';
import 'package:Moshafi/view/screen/about_app.dart';
import 'package:Moshafi/view/screen/change_size_screen.dart';
import 'package:Moshafi/view/widget/selection_container_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SettingsController>(
          init: SettingsController(),
          builder: (controller) {
            return ListView(
              children: [
                SelectionContainerWidget(
                  mainText: "Tap to change the Theme",
                  subText: controller.myservices.shared.getBool("dark") == true
                      ? "Light Mode"
                      : "Dark Mode",
                  onPressed: () {
                    controller.toggleTheme();
                    controller.update();
                  },
                ),
                SelectionContainerWidget(
                  mainText: "Change the size ",
                  subText: "Ayah,Tafsir",
                  onPressed: () {
                    Get.to(const ChangeSizeScreen());
                  },
                ),
                SelectionContainerWidget(
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
