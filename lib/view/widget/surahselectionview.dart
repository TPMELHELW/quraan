import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/surahcontroller.dart';
import 'package:quraan/view/screen/homescreen.dart';

class SurahSelectionView extends StatelessWidget {
  final ScrollController scroll;
  final SurahController controller;
  const SurahSelectionView(
      {super.key, required this.scroll, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          controller: scroll,
          shrinkWrap: true,
          itemCount: controller.json.length,
          itemBuilder: (context, i) {
            return ListTile(
              onTap: () {
                final myMap = controller.tafsir;
                var filteredMapList = myMap
                    .where((map) => map["chapter"] == controller.json[i]['id'])
                    .toList();
                // print(filteredMapList);
                controller.myservices.shared.setString(
                    'lastread', '${controller.json[i]['name_translation']}');
                controller.myservices.shared.setInt('numberlastread', i);
                Get.to(() => HomeScreen(
                      id: controller.json[i]['array'],
                      controller: filteredMapList,
                    ));
                controller.update();
              },
              leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("${controller.json[i]['id']}")),
              title: Text(
                "${controller.json[i]['name_translation']}",
                style: const TextStyle(fontFamily: 'poppins'),
              ),
              subtitle: Row(
                children: [
                  Text(
                    "${controller.json[i]['type']}",
                    style: const TextStyle(fontFamily: 'poppins'),
                  ),
                ],
              ),
              trailing: Text(
                '${controller.json[i]['name']}',
                style: const TextStyle(fontFamily: 'poppins'),
              ),
            );
          }),
    );
  }
}
