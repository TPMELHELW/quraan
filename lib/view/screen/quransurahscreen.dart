import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/searchcontroller.dart';
import 'package:quraan/controller/surahcontroller.dart';
import 'package:quraan/core/constant/enum.dart';
// import 'package:quraan/core/services/sharedpreferences.dart';
import 'package:quraan/view/screen/homescreen.dart';
import 'package:quraan/view/screen/searchscreen.dart';

class QuranSurahScreen extends StatelessWidget {
  const QuranSurahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SurahController controller0 = Get.put(SurahController());
    SearchAyahController controller2 = Get.put(SearchAyahController());
    final scroll = ScrollController();
    bool isScroll = false;
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                        onSaved: (val) {},
                        onFieldSubmitted: (val) {
                          // controller2.searchQuran(val, controller0.json);
                          var responce =
                              controller2.searchQuran(val, controller0.json);
                          // print(responce);

                          Get.to(SearchScreen(
                              search: controller2.results,
                              inf: controller2.inf));
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
                  ),
                ],
              ),
            ),
            GetBuilder<SurahController>(
              init: SurahController(),
              builder: (controller) => controller.statusRequest ==
                      StatusRequest.success
                  ? Expanded(
                      child: ListView.builder(
                          controller: scroll,
                          shrinkWrap: true,
                          itemCount: controller.json.length,
                          itemBuilder: (context, i) {
                            //  bool isScroll = scroll.position.maxScrollExtent == 0 ? false:true;
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
                                print(controller.myservices.shared
                                    .getInt('numberlastread'));
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
                                    style:
                                        const TextStyle(fontFamily: 'poppins'),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                '${controller.json[i]['name']}',
                                style: const TextStyle(fontFamily: 'poppins'),
                              ),
                            );
                          }),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
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
