import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/surahcontroller.dart';
import 'package:quraan/core/services/sharedpreferences.dart';
import 'package:quraan/view/screen/audioscreen.dart';
import 'package:quraan/view/screen/homescreen.dart';
import 'package:quraan/view/screen/quransurahscreen.dart';
import 'package:quraan/view/widget/containerview.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Services myservices = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(slivers: [
          const SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Quran',
              textAlign: TextAlign.center,
              style: TextStyle(
                // fontSize: 40,
                fontFamily: 'poppins',
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            floating: true,
            snap: true,
            stretch: true,
          ),
          GetBuilder<SurahController>(
            init: SurahController(),
            builder: (controller) => SliverToBoxAdapter(
              child: ContainerView(
                mainText: 'last Read',
                subText:
                    '${controller.myservices.shared.getString('lastread')}',
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
                  // controller.update();
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: ContainerView(
            mainText: 'Quran',
            subText: 'Holy Quran',
            onPressed: () {
              Get.to(() => const QuranSurahScreen());
            },
          )),
          SliverToBoxAdapter(
              child: ContainerView(
            mainText: 'Quran Audio',
            subText: 'Audio',
            onPressed: () {
              Get.to(() => const AudioScreen());
            },
          )),
        ]),
      ),
    );
  }
}

  // 