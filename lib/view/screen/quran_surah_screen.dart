import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Moshafi/controller/surah_controller.dart';
import 'package:Moshafi/core/constant/enum.dart';
import 'package:Moshafi/view/widget/search_widget.dart';
import 'package:Moshafi/view/widget/surah_selection_view_widget.dart';

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
                        SearchWidget(
                          controller: controller,
                        ),
                        SurahSelectionViewWidget(
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
