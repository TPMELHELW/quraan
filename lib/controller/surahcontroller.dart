import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:quraan/core/constant/enum.dart';
import 'package:quraan/core/services/sharedpreferences.dart';

class SurahController extends GetxController {
  List json = [];
  List selectedSheikhSuar = [];
  List tafsir = [];
  List readers = [];
  bool isSelected = false;
  final player = AudioPlayer();
  final drawerController = AdvancedDrawerController();

  bool isPlaying = false;
  bool isPlay = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  double value = 0;
  bool isExist = false;
  Map audioSelected = {};
  onPress(Map server, suar) {
    try {
      audioSelected = server;
      List m = suar.split(",").map(int.parse).toList();
      selectedSheikhSuar.clear();
      for (int i = 0; i < m.length; i++) {
        List filtired = json.where((element) => m[i] == element['id']).toList();
        selectedSheikhSuar.addAll(filtired);
      }
      isSelected = true;
    } catch (e) {}
    update();
  }

  late StatusRequest statusRequest;
  Services myservices = Get.find();

  decodeData(BuildContext context) async {
    statusRequest = StatusRequest.loading;
    var responce = await DefaultAssetBundle.of(context)
        .loadString('assets/json/Quran.json');
    var responcebody = await jsonDecode(responce);
    var responce1 = await rootBundle.loadString('assets/json/tafsir.json');
    var responcebody1 = await jsonDecode(responce1);
    var responce2 =
        await rootBundle.loadString('assets/json/readersspecial.json');
    var responcebody2 = await jsonDecode(responce2);
    if (responcebody != null &&
        responcebody1 != null &&
        responcebody2 != null) {
      json.addAll(responcebody);
      selectedSheikhSuar.addAll(responcebody);
      tafsir.addAll(responcebody1['quran']);
      readers.addAll(responcebody2);
      statusRequest = StatusRequest.success;
      update();
    }

    update();
  }

  @override
  void onInit() async {
    statusRequest = StatusRequest.none;
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await decodeData(Get.context!);
    });
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    player.onPlayerStateChanged.listen((event) {
      isPlaying = event == PlayerState.playing;
      update();
    });

    player.onPositionChanged.listen((event) {
      position = event;
      update();
    });

    player.onDurationChanged.listen((event) {
      duration = event;
      update();
    });
    // drawerController.
  }

  @override
  void dispose() {
    drawerController.dispose();
    super.dispose();
  }
}
