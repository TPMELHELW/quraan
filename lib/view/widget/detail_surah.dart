import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/surah_controller.dart';
import 'package:quraan/core/services/shared_preferences.dart';

class DetailSurah extends StatelessWidget {
  final List id;
  final List filteredMapList;
  const DetailSurah(
      {super.key, required this.id, required this.filteredMapList});

  @override
  Widget build(BuildContext context) {
    Services myservices = Get.find();
    Get.find<SurahController>();
    return Scaffold(
      body: GetBuilder<SurahController>(
        builder: (controller) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: id.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          ListTile(
                            trailing: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text("${id[i]['id']}"),
                            ),
                            title: SelectableText(
                              "${id[i]['ar']}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: myservices.shared
                                          .getDouble("fontsize")),
                            ),
                            subtitle: SelectableText(
                              "${id[i]['en']}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(18),
                            width: MediaQuery.of(context).size.width * 0.90,
                            decoration: BoxDecoration(
                                color: myservices.shared.getBool("dark") == true
                                    ? Colors.white
                                    : Colors.greenAccent,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('التفسير الميسر',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                                SelectableText(
                                  '${filteredMapList[i]['text']}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: myservices.shared
                                              .getDouble("fontsizetafsir")),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
