import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Moshafi/controller/audio_controller.dart';
import 'package:Moshafi/view/screen/surah_audio_screen.dart';
import 'package:Moshafi/view/widget/container_id_widget.dart';

class ScreenView extends StatelessWidget {
  final AudioController controller;
  const ScreenView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.selectedSheikhSuar.length,
        itemBuilder: (context, i) {
          bool exist = File(
                  '/storage/emulated/0/Android/data/com.example.quraan/files/data/user/0/com.example.quraan/files/${controller.audioSelected['id']}${controller.selectedSheikhSuar[i]['id']}.mp3')
              .existsSync();
          return ListTile(
            onTap: () {
              controller.playSurah(i);
              Get.to(
                () => SurahAudioScreen(
                  controller: controller,
                ),
              );
            },
            leading: ContainerIdWidget(
              child: Text("${controller.selectedSheikhSuar[i]['id']}"),
            ),
            title: Text(
              "${controller.selectedSheikhSuar[i]['name_translation']}",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            subtitle: Row(
              children: [
                Text(
                  "${controller.selectedSheikhSuar[i]['type']}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            trailing: exist != true
                ? IconButton(
                    onPressed: () async => await controller.downloadSurah(i),
                    icon: const Icon(Icons.downloading_rounded))
                : IconButton(
                    onPressed: () async => await controller.playSurahOffline(i),
                    icon: const Icon(Icons.play_arrow),
                  ),
          );
        },
      ),
    );
  }
}
