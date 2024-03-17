import 'dart:convert';
import 'package:arabic_tools/arabic_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:Moshafi/core/constant/enum.dart';
import 'package:Moshafi/core/functions/normalise.dart';
import 'package:Moshafi/core/services/shared_preferences.dart';
import 'package:Moshafi/main.dart';
import 'package:Moshafi/view/screen/search_screen.dart';
import 'package:Moshafi/view/screen/surah_detail_screen.dart';

class SurahController extends GetxController {
  //variables ==========================
  List searchResult = [];
  List searchTafsir = [];
  List infArrayId = [];
  List infMainId = [];
  List quranData = [];
  List readers = [];
  List tafsir = [];
  List inf = [];
  ScrollController scroll = ScrollController();
  Arabic_Tools arabictool = Arabic_Tools();
  Services myServices = Get.find();
  late StatusRequest statusRequest;
  bool isScroll = false;

//functions=========================

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
      statusRequest = StatusRequest.failure;
      update();
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
      if (searchResult.isEmpty) {
        // print('nnnn');
        statusRequest = StatusRequest.noData;
        update();
        Get.to(
          () => SearchScreen(
            search: searchResult,
            inf: inf,
            tafsir: searchTafsir,
          ),
        );
      } else {
        statusRequest = StatusRequest.success;
        update();
        Get.to(
          () => SearchScreen(
            search: searchResult,
            inf: inf,
            tafsir: searchTafsir,
          ),
        );
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
    }
  }

//onSurahTap=======================
  void onSurahTap(int i) {
    List filteredMapList =
        tafsir.where((map) => map["chapter"] == quranData[i]['id']).toList();
    myServices.shared
        .setString('lastread', '${quranData[i]['name_translation']}');
    myServices.shared.setInt('numberlastread', i);
    Get.to(
      () => SurahDetailScreen(
        id: quranData[i]['array'],
        filteredMapList: filteredMapList,
      ),
    );
    update();
  }

  //last read function========================================
  void lastReadOnPress() {
    try {
      // List myMap = tafsir;
      List filteredMapList = tafsir
          .where((map) =>
              map["chapter"] ==
              quranData[myServices.shared.getInt('numberlastread')!]['id'])
          .toList();
      Get.to(
        () => SurahDetailScreen(
          id: quranData[myServices.shared.getInt('numberlastread')!]['array'],
          filteredMapList: filteredMapList,
        ),
      );
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
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

    await Future.wait([decodeData()]).then(
      (value) => Get.offAll(
        () => const StackScreen(),
      ),
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
  }
}
