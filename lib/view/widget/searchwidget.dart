import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/searchcontroller.dart';
import 'package:quraan/controller/surahcontroller.dart';
import 'package:quraan/view/screen/searchscreen.dart';

class SearchWidget extends StatelessWidget {
  final SearchAyahController controller2;
  final SurahController controller;
  const SearchWidget({super.key, required this.controller2, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        child: TextFormField(
          onFieldSubmitted: (val) {
            controller2.searchQuran(val, controller.json);
            final myMap = controller.tafsir;

            for (int i = 0; i < controller2.infMainId.length; i++) {
              var filteredMapList = myMap
                  .where((map) =>
                      map["chapter"] == controller2.infMainId[i] &&
                      map['verse'] == controller2.infArrayId[i])
                  .toList();
              controller2.tafsir.addAll(filteredMapList);
            }
            Get.to(() => SearchScreen(
                  search: controller2.results,
                  inf: controller2.inf,
                  tafsir: controller2.tafsir,
                ));
            controller2.update();
          },
          decoration: const InputDecoration(
            labelText: 'Search For Ayah',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
