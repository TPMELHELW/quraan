import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/detailsurahcontroller.dart';
import 'package:quraan/controller/surahcontroller.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    SurahController controller0 = Get.find();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Audio",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GetBuilder<DetailSurahController>(
          init: DetailSurahController(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller0.json.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          onTap: () async {
                            await controller.player.play(
                              UrlSource(
                                  'https://server16.mp3quran.net/h_dukhain/Rewayat-Hafs-A-n-Assem/${controller0.json[i]['array'][0]['filename']}'),
                            );
                            controller.isPlay = true;
                            controller.isExist = true;
                            controller.update();
                            // controller.isPlay = !controller.isPlay;
                          },
                          leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text("${controller0.json[i]['id']}")),
                          title: Text(
                            "${controller0.json[i]['name_translation']}",
                            style: const TextStyle(fontFamily: 'poppins'),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                "${controller0.json[i]['type']}",
                                style: const TextStyle(fontFamily: 'poppins'),
                              ),
                            ],
                          ),
                          trailing: Text(
                            '${controller0.json[i]['name']}',
                            style: const TextStyle(fontFamily: 'poppins'),
                          ),
                        );
                      }),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(children: [
                    CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      radius: 25,
                      child: IconButton(
                        color: const Color(0xFFfaf3e3),
                        iconSize: 30,
                        onPressed: () async {
                          controller.isPlay == false
                              ? controller.player.resume()
                              : controller.player.pause();
                          controller.isExist = true;
                          controller.isPlay = !controller.isPlay;
                          controller.update();
                        },
                        icon: Icon(controller.isPlay == false
                            ? Icons.play_arrow
                            : Icons.pause),
                      ),
                    ),
                    controller.isExist == false
                        ? const Text(
                            'Please press the play button',
                            style: TextStyle(
                                fontFamily: 'poppins', color: Colors.white),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: SliderTheme(
                              data: const SliderThemeData(
                                trackHeight: 10
                              ),
                              child: Slider(
                                activeColor: Colors.greenAccent,
                                label:controller.value.round().toString() ,
                                divisions: 50,
                                  value: controller.position.inSeconds.toDouble(),
                                  min: 0,
                                  max: controller.duration.inSeconds.toDouble(),
                                  onChanged: (value) {
                                    controller.value = value;
                                    final position =
                                        Duration(seconds: value.toInt());
                                    controller.isPlay = true;
                                    controller.player.seek(position);
                                    controller.player.resume();
                                  }),
                            )
                      
                            ),
                  ]),
                )
              ],
            );
          }),
    );
  }
}
