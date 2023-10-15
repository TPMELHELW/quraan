import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/searchcontroller.dart';
import 'package:quraan/controller/surahcontroller.dart';
import 'package:quraan/core/constant/enum.dart';
import 'package:quraan/view/widget/searchwidget.dart';
import 'package:quraan/view/widget/surahselectionview.dart';

class QuranSurahScreen extends StatelessWidget {
  const QuranSurahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SearchAyahController controller2 = Get.put(SearchAyahController());
    final scroll = ScrollController();
    bool isScroll = false;
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SurahController>(
            init: SurahController(),
            builder: (controller) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        SearchWidget(
                          controller2: controller2,
                          controller: controller,
                        )
                      ],
                    ),
                  ),
                  controller.statusRequest == StatusRequest.success
                      ? SurahSelectionView(
                          scroll: scroll,
                          controller: controller,
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightGreen,
          child: const Icon(Icons.airline_stops_outlined),
          onPressed: () {
            if (isScroll == true) {
              scroll.animateTo(scroll.position.maxScrollExtent,
                  duration: const Duration(seconds: 2),
                  curve: Curves.bounceInOut);
              isScroll = !isScroll;
            } else {
              scroll.animateTo(scroll.position.minScrollExtent,
                  duration: const Duration(seconds: 2),
                  curve: Curves.bounceInOut);
              isScroll = !isScroll;
            }
          }),
    );
  }
}
