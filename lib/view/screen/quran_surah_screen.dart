import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/surah_controller.dart';
import 'package:quraan/core/constant/enum.dart';
import 'package:quraan/view/widget/search_widget.dart';
import 'package:quraan/view/widget/surah_selection_view.dart';

class QuranSurahScreen extends StatelessWidget {
  const QuranSurahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SurahController controller = Get.find<SurahController>();
    return Scaffold(
      body: GetBuilder<SurahController>(
        builder: (controller) =>
            controller.statusRequest == StatusRequest.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              SearchWidget(
                                controller: controller,
                              )
                            ],
                          ),
                        ),
                        SurahSelectionView(
                          controller: controller,
                        )
                      ],
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        child: const Icon(Icons.airline_stops_outlined),
        onPressed: () {
          controller.actionButtonOnPress();
        },
      ),
    );
  }
}
