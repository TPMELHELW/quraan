import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quraan/controller/surah_controller.dart';

class ScreenView extends StatelessWidget {
  final SurahController controller;
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
            onTap: () async {
              await controller.player.play(
                UrlSource(
                    '${controller.audioSelected['moshaf'][0]['server']}/${controller.selectedSheikhSuar[i]['array'][0]['filename']}'),
              );
              controller.isPlay = true;
              controller.isExist = true;
              controller.update();
            },
            leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: Text("${controller.selectedSheikhSuar[i]['id']}")),
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
                    onPressed: () async {
                      Permission.storage;
                      FileDownloader.downloadFile(
                        name:
                            "${controller.audioSelected['id']}${controller.selectedSheikhSuar[i]['id']}",
                        url:
                            "${controller.audioSelected['moshaf'][0]['server']}/${controller.selectedSheikhSuar[i]['array'][0]['filename']}",
                        downloadDestination: DownloadDestinations.appFiles,
                        onDownloadCompleted: (val) async {
                          Get.snackbar("Success", "Download Complete");
                          controller.update();
                        },
                      );
                    },
                    icon: const Icon(Icons.downloading_rounded))
                : IconButton(
                    onPressed: () async {
                      await controller.player.play(
                        UrlSource(
                          '/storage/emulated/0/Android/data/com.example.quraan/files/data/user/0/com.example.quraan/files/${controller.audioSelected['id']}${controller.selectedSheikhSuar[i]['id']}.mp3',
                        ),
                      );
                      controller.isPlay = true;
                      controller.isExist = true;
                    },
                    icon: const Icon(Icons.play_arrow),
                  ),
          );
        },
      ),
    );
  }
}
