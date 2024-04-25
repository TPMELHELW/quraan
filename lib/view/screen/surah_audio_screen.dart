import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:Moshafi/controller/audio_controller.dart';
import 'package:Moshafi/core/constant/enum.dart';
import 'package:Moshafi/core/services/shared_preferences.dart';
import 'package:Moshafi/view/widget/audio_screen_widgets/audio_button_widget.dart';
import 'package:lottie/lottie.dart';

class SurahAudioScreen extends StatelessWidget {
  final AudioController controller;
  const SurahAudioScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    Services myServices = Get.find<Services>();
    return Scaffold(
      body: GetBuilder<AudioController>(
        builder: (context) => controller.statusRequest == StatusRequest.offline
            ? Center(
                child: Lottie.asset('assets/lottie/offline.json'),
              )
            : Center(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shrinkWrap: true,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        myServices.shared.getBool('dark') == true
                            ? 'assets/images/4.jpg'
                            : 'assets/images/2.jpg',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    controller.isPlay
                        ? Column(
                            children: [
                              Text(controller.selectedSheikhSuar[
                                  controller.currentPlay]['name_translation']),
                              const SizedBox(
                                height: 10,
                              ),
                              SliderTheme(
                                data: const SliderThemeData(trackHeight: 10),
                                child: Slider(
                                  activeColor: Colors.greenAccent,
                                  label:
                                      controller.sliderValue.round().toString(),
                                  divisions: 50,
                                  value: controller.sliderValue,
                                  min: 0,
                                  max: controller.player.duration?.inSeconds
                                          .toDouble() ??
                                      0,
                                  onChanged: (value) {
                                    controller.sliderValue = value;
                                    final position =
                                        Duration(seconds: value.toInt());
                                    controller.player.seek(position);
                                  },
                                ),
                              )
                            ],
                          )
                        : const Center(
                            child: Text(
                              'Please Choose Surah',
                            ),
                          ),
                    controller.isPlay
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AudioButtonWidget(
                                icon: const Icon(Icons.skip_previous),
                                size: 30,
                                onPress: () async {
                                  await controller.previousSurah();
                                },
                              ),
                              AudioButtonWidget(
                                icon: Icon(!controller.isPlaying
                                    ? Icons.play_arrow
                                    : Icons.pause),
                                size: 80,
                                onPress: () {
                                  controller.isPlaying
                                      ? controller.player.pause()
                                      : controller.player.play();
                                  controller.isPlaying = !controller.isPlaying;
                                },
                              ),
                              AudioButtonWidget(
                                icon: const Icon(Icons.skip_next),
                                size: 30,
                                onPress: () async {
                                  await controller.nextSurah();
                                },
                              ),
                            ],
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    AudioButtonWidget(
                      icon: Icon(controller.isLoop ? Icons.loop : Icons.replay),
                      size: 30,
                      onPress: () {
                        controller.player.setLoopMode(LoopMode.one);
                        controller.isLoop = true;
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
