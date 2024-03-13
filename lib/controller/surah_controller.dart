import 'dart:convert';
import 'package:arabic_tools/arabic_tools.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:quraan/core/constant/enum.dart';
import 'package:quraan/core/functions/normalise.dart';
import 'package:quraan/core/services/shared_preferences.dart';
import 'package:quraan/main.dart';
import 'package:quraan/view/screen/search_screen.dart';
import 'package:quraan/view/widget/detail_surah.dart';

class SurahController extends GetxController {
  //variables ==========================
  List searchResult = [];
  List inf = [];
  List infMainId = [];
  List infArrayId = [];
  List searchTafsir = [];
  Arabic_Tools arabictool = Arabic_Tools();
  List quranData = [];
  List selectedSheikhSuar = [];
  List tafsir = [];
  List readers = [];
  bool isSelected = false;
  ScrollController scroll = ScrollController();
  bool isScroll = false;
  AudioPlayer player = AudioPlayer();
  AdvancedDrawerController drawerController = AdvancedDrawerController();
  bool isPlaying = false;
  bool isPlay = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  double value = 0;
  bool isExist = false;
  Map audioSelected = {};
  late StatusRequest statusRequest;
  Services myservices = Get.find();

//functions=========================

//audio Function===================
  onPress(int i) {
    try {
      audioSelected = readers[i];
      List m = readers[i]['moshaf'][0]["surah_list"]
          .split(",")
          .map(int.parse)
          .toList();
      selectedSheikhSuar.clear();
      for (int i = 0; i < m.length; i++) {
        List filtired =
            quranData.where((element) => m[i] == element['id']).toList();
        selectedSheikhSuar.addAll(filtired);
      }
      isSelected = true;
    } catch (e) {}
    update();
  }

  Future decodeData() async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      String quranFile = await rootBundle.loadString('assets/json/Quran.json');
      var quranResponce = await jsonDecode(quranFile);
      String tafsirFile =
          await rootBundle.loadString('assets/json/tafsir.json');
      var tafsirResponce = await jsonDecode(tafsirFile);
      String readersFile =
          await rootBundle.loadString('assets/json/readersspecial.json');
      var readersResponce = await jsonDecode(readersFile);
      if (quranResponce != null &&
          tafsirResponce != null &&
          readersResponce != null) {
        quranData.addAll(quranResponce);
        tafsir.addAll(tafsirResponce['quran']);
        readers.addAll(readersResponce);
        statusRequest = StatusRequest.success;
        update();
      }
      return 'success';
    } catch (e) {
      print(e);
    }
    update();
  }

  //search========================================================
  void searchQuran(String query) {
    try {
      statusRequest = StatusRequest.loading;
      update();
      searchResult.clear();
      inf.clear();
      infArrayId.clear();
      infMainId.clear();
      searchTafsir.clear();
      String processedQuery = arabictool.RemoveTashkeel(query);

      for (var surah in quranData) {
        surah['array'].asMap().forEach(
          (index, ayat) {
            var ayat0 = normalise(ayat['ar']);
            if (ayat0.contains(processedQuery.toLowerCase())) {
              searchResult.add(ayat['ar']);
              inf.add(surah['name']);
              infMainId.add(surah['id']);
              infArrayId.add(surah['array'][index]['id']);
            } else {
              print('NO Data');
            }
          },
        );
      }
      for (int i = 0; i < infMainId.length; i++) {
        List filteredMapList = tafsir
            .where((map) =>
                map["chapter"] == infMainId[i] && map['verse'] == infArrayId[i])
            .toList();
        searchTafsir.addAll(filteredMapList);
      }
      statusRequest = StatusRequest.success;
      update();
      Get.to(
        () => SearchScreen(
          search: searchResult,
          inf: inf,
          tafsir: searchTafsir,
        ),
      );
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
    }
  }

//onSurahTap=======================
  void onSurahTap(int i) {
    List filteredMapList =
        tafsir.where((map) => map["chapter"] == quranData[i]['id']).toList();
    myservices.shared
        .setString('lastread', '${quranData[i]['name_translation']}');
    myservices.shared.setInt('numberlastread', i);
    Get.to(
      () => DetailSurah(
        id: quranData[i]['array'],
        filteredMapList: filteredMapList,
      ),
    );
    update();
  }

  //last read function========================================
  void lastReadOnPress() {
    try {
      List myMap = tafsir;
      List filteredMapList = myMap
          .where((map) =>
              map["chapter"] ==
              quranData[myservices.shared.getInt('numberlastread')!]['id'])
          .toList();
      Get.to(
        () => DetailSurah(
          id: quranData[myservices.shared.getInt('numberlastread')!]['array'],
          filteredMapList: filteredMapList,
        ),
      );
    } catch (e) {
      print(e);
    }
    update();
  }

//floatingActionButton Function===========================
  void actionButtonOnPress() {
    if (isScroll == false) {
      scroll.animateTo(scroll.position.maxScrollExtent,
          duration: const Duration(seconds: 2), curve: Curves.bounceInOut);
      isScroll = !isScroll;
    } else {
      scroll.animateTo(scroll.position.minScrollExtent,
          duration: const Duration(seconds: 2), curve: Curves.bounceInOut);
      isScroll = !isScroll;
    }
    update();
  }

  //life cycle===========================================
  @override
  void onInit() async {
    statusRequest = StatusRequest.none;
    super.onInit();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await decodeData(Get.context!);
    // });
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    player.onPlayerStateChanged.listen((event) {
      isPlaying = event == PlayerState.playing;
      update();
    });
    await Future.wait([decodeData()]).then(
      (value) => Get.offAll(
        () => const StackScreen(),
      ),
    );
    player.onPositionChanged.listen((event) {
      position = event;
      update();
    });

    player.onDurationChanged.listen((event) {
      duration = event;
      update();
    });
  }

  @override
  void dispose() {
    drawerController.dispose();
    super.dispose();
  }
}
