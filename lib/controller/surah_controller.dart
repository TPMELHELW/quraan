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
  Map normaliseData = {};
  ScrollController scroll = ScrollController();
  Arabic_Tools arabictool = Arabic_Tools();
  Services myServices = Get.find();
  late StatusRequest statusRequest;
  bool isScroll = false;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
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

  void normaliseFun() {
    for (var surah in quranData) {
      surah['array'].asMap().forEach((index, ayah) {
        String ayat = normalise(ayah['ar']);
        normaliseData.addAll({
          ayat: {
            'id': ayah['id'],
            'ar': ayah['ar'],
            'name': surah['name'],
            'mainId': surah['id']
          }
        });
      });
    }
  }

  //search========================================================
  void searchQuran(String query) {
    try {
      bool formData = formState.currentState!.validate();
      if (formData) {
        statusRequest = StatusRequest.loading;
        update();
        searchResult.clear();
        inf.clear();
        infArrayId.clear();
        infMainId.clear();
        searchTafsir.clear();
        String processedQuery = arabictool.RemoveTashkeel(query);
        //ayah Search
        for (var key in normaliseData.keys) {
          if (key.contains(processedQuery.toLowerCase())) {
            searchResult.add(normaliseData[key]['ar']);
            inf.add(normaliseData[key]['name']);
            infMainId.add(normaliseData[key]['mainId']);
            infArrayId.add(normaliseData[key]['id']);
          }
        }
        //Tafsir Search
        for (int i = 0; i < infMainId.length; i++) {
          List filteredMapList = tafsir
              .where((map) =>
                  map["chapter"] == infMainId[i] &&
                  map['verse'] == infArrayId[i])
              .toList();
          searchTafsir.addAll(filteredMapList);
        }
        print(searchTafsir);
        if (searchResult.isEmpty) {
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

    await Future.wait([decodeData()]).then((value) {
      Get.offAll(
        () => const StackScreen(),
      );

      normaliseFun();
    });
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
  }
}
