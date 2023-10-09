import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quraan/core/constant/enum.dart';
import 'package:quraan/core/services/sharedpreferences.dart';

class SurahController extends GetxController {
  List json = [];
  List tafsir = [];
  late StatusRequest statusRequest;
  Services myservices = Get.find();
  decodeData(BuildContext context) async {
    statusRequest = StatusRequest.loading;
    var responce = await DefaultAssetBundle.of(context)
        .loadString('assets/json/Quran.json');
    var responcebody = await jsonDecode(responce);
    var responce1 = await rootBundle.loadString('assets/json/tafsir.json');
    var responcebody1 = await jsonDecode(responce1);
    if (responcebody != null && responcebody1 != null) {
      print(responcebody1);
      json.addAll(responcebody);
      tafsir.addAll(responcebody1['quran']);
      print(tafsir);
      statusRequest = StatusRequest.success;
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // statusBarBrightness: Brightness.light
        statusBarIconBrightness: Brightness.dark));
  }
}
