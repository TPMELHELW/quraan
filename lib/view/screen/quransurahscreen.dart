import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/searchcontroller.dart';
import 'package:quraan/controller/surahcontroller.dart';
import 'package:quraan/core/constant/enum.dart';
import 'package:quraan/view/screen/homescreen.dart';
import 'package:quraan/view/screen/searchscreen.dart';

class QuranSurahScreen extends StatelessWidget {
  const QuranSurahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SearchAyahController controller2 = Get.put(SearchAyahController());
    final scroll = ScrollController();
    bool isScroll = false;
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SurahController>(
            init: SurahController(),
            builder: (controller) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Form(
                            child: TextFormField(
                              onFieldSubmitted: (val) {
                                controller2.searchQuran(val, controller.json);
                                final myMap = controller.tafsir;

                                for (int i = 0;
                                    i < controller2.infMainId.length;
                                    i++) {
                                  var filteredMapList = myMap
                                      .where((map) =>
                                          map["chapter"] ==
                                              controller2.infMainId[i] &&
                                          map['verse'] ==
                                              controller2.infArrayId[i])
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
                              decoration: InputDecoration(
                                suffix: Text('${controller2.results.length}'),
                                labelText: 'Search For Ayah',
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  controller.statusRequest == StatusRequest.success
                      ? Expanded(
                          child: ListView.builder(
                              controller: scroll,
                              shrinkWrap: true,
                              itemCount: controller.json.length,
                              itemBuilder: (context, i) {
                                return ListTile(
                                  onTap: () {
                                    final myMap = controller.tafsir;
                                    var filteredMapList = myMap
                                        .where((map) =>
                                            map["chapter"] ==
                                            controller.json[i]['id'])
                                        .toList();
                                    // print(filteredMapList);
                                    controller.myservices.shared.setString(
                                        'lastread',
                                        '${controller.json[i]['name_translation']}');
                                    controller.myservices.shared
                                        .setInt('numberlastread', i);
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child:
                                          Text("${controller.json[i]['id']}")),
                                  title: Text(
                                    "${controller.json[i]['name_translation']}",
                                    style:
                                        const TextStyle(fontFamily: 'poppins'),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        "${controller.json[i]['type']}",
                                        style: const TextStyle(
                                            fontFamily: 'poppins'),
                                      ),
                                    ],
                                  ),
                                  trailing: Text(
                                    '${controller.json[i]['name']}',
                                    style:
                                        const TextStyle(fontFamily: 'poppins'),
                                  ),
                                );
                              }),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightGreen,
          child: const Icon(Icons.airline_stops_outlined),
          onPressed: () {
            if (isScroll == true) {
              scroll.animateTo(scroll.position.maxScrollExtent,
                  duration: const Duration(seconds: 2),
                  curve: Curves.bounceInOut);
              isScroll = !isScroll;
            } else {
              scroll.animateTo(scroll.position.minScrollExtent,
                  duration: const Duration(seconds: 2),
                  curve: Curves.bounceInOut);
              isScroll = !isScroll;
            }
          }),
    );
  }
}
