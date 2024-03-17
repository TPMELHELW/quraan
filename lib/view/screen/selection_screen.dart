import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Moshafi/controller/surah_controller.dart';
import 'package:Moshafi/view/screen/audio_screen.dart';
import 'package:Moshafi/view/screen/quran_surah_screen.dart';
import 'package:Moshafi/view/screen/settings_screen.dart';
import 'package:Moshafi/view/widget/selection_container_widget.dart';

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
              builder: (con) => SelectionContainerWidget(
                mainText: 'last Read',
                subText: controller.myServices.shared.getString('lastread') ??
                    'Empty',
                onPressed: () {
                  controller.lastReadOnPress();
                },
              ),
            ),
            SelectionContainerWidget(
              mainText: 'Quran',
              subText: 'Holy Quran',
              onPressed: () {
                Get.to(() => const QuranSurahScreen());
              },
            ),
            SelectionContainerWidget(
              mainText: 'Quran Audio',
              subText: 'Audio',
              onPressed: () {
                Get.to(() => const AudioScreen());
              },
            ),
            SelectionContainerWidget(
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
