import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:Moshafi/controller/audio_controller.dart';
import 'package:Moshafi/view/screen/surah_audio_screen.dart';
import 'package:Moshafi/view/widget/audio_screen_widgets/drawer_widget.dart';
import 'package:Moshafi/view/widget/audio_screen_widgets/screen_view.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AdvancedDrawerController drawerController = AdvancedDrawerController();
    Get.put(AudioController(), permanent: true);
    return GetBuilder<AudioController>(
      builder: (controller) {
        return AdvancedDrawer(
          controller: drawerController,
          backdropColor: Colors.grey,
          childDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          drawer: DrawerWidget(
            controller: controller,
            drawerController: drawerController,
          ),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Audio",
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            Get.to(
                              () => SurahAudioScreen(
                                controller: controller,
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.music_note,
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }
}
