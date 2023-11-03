import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/surahcontroller.dart';
import 'package:quraan/view/widget/audio_screen/drawer_widget.dart';
import 'package:quraan/view/widget/audio_screen/screen_view.dart';
import 'package:quraan/view/widget/audio_screen/slider_view.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SurahController>(
        init: SurahController(),
        builder: (controller) {
          return AdvancedDrawer(
            controller: controller.drawerController,
            backdropColor: Colors.grey,
            childDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            drawer: DrawerWidget(
              controller: controller,
            ),
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "Audio",
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: controller.isSelected == false
                  ? Center(
                      child: Text(
                        "Please swipe the Screen to Select the Sheikh",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ScreenView(
                          controller: controller,
                        ),
                        SliderView(
                          controller: controller,
                        )
                      ],
                    ),
            ),
          );
        });
  }
}
