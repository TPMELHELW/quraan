import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/surahcontroller.dart';
import 'package:quraan/view/screen/aboutapp.dart';
import 'package:quraan/view/screen/audioscreen.dart';
import 'package:quraan/view/screen/homescreen.dart';
import 'package:quraan/view/screen/quransurahscreen.dart';
import 'package:quraan/view/widget/containerview.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Quran',
          // textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(children: [
          GetBuilder<SurahController>(
            init: SurahController(),
            builder: (controller) => ContainerView(
              mainText: 'last Read',
              subText: '${controller.myservices.shared.getString('lastread')}',
              onPressed: () {
                final myMap = controller.tafsir;
                var filteredMapList = myMap
                    .where((map) =>
                        map["chapter"] ==
                        controller.json[controller.myservices.shared
                            .getInt('numberlastread')!]['id'])
                    .toList();
                Get.to(HomeScreen(
                    id: controller.json[controller.myservices.shared
                        .getInt('numberlastread')!]['array'],
                    controller: filteredMapList));
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
            subText: 'About App',
            onPressed: () {
              Get.to(() => const AboutApp());
            },
          ),
        ]),
      ),
    );
  }
}

  // 