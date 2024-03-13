import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/surah_controller.dart';
import 'package:quraan/view/screen/audio_screen.dart';
import 'package:quraan/view/screen/quran_surah_screen.dart';
import 'package:quraan/view/screen/settings_screen.dart';
import 'package:quraan/view/widget/container_view.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SurahController controller = Get.find<SurahController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Quran',
          style: TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            GetBuilder<SurahController>(
              builder: (con) => ContainerView(
                mainText: 'last Read',
                subText: controller.myservices.shared.getString('lastread') ??
                    'Empty',
                onPressed: () {
                  controller.lastReadOnPress();
                },
              ),
            ),
            ContainerView(
              mainText: 'Quran',
              subText: 'Holy Quran',
              onPressed: () {
                Get.to(() => const QuranSurahScreen());
              },
            ),
            ContainerView(
              mainText: 'Quran Audio',
              subText: 'Audio',
              onPressed: () {
                Get.to(() => const AudioScreen());
              },
            ),
            ContainerView(
              mainText: 'Ideas',
              subText: 'Settings',
              onPressed: () {
                Get.to(() => const SettingsScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
