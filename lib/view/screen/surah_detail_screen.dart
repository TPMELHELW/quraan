import 'package:Moshafi/view/widget/tafsir_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Moshafi/controller/surah_controller.dart';
import 'package:Moshafi/view/widget/container_id_widget.dart';

class SurahDetailScreen extends StatelessWidget {
  final List id;
  final List filteredMapList;
  const SurahDetailScreen({
    super.key,
    required this.id,
    required this.filteredMapList,
  });

  @override
  Widget build(BuildContext context) {
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
                            trailing: ContainerIdWidget(
                              child: Text("${id[i]['id']}"),
                            ),
                            title: SelectableText(
                              "${id[i]['ar']}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: controller.myServices.shared
                                          .getDouble("fontsize")),
                            ),
                            subtitle: SelectableText(
                              "${id[i]['en']}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          TafsirContainerWidget(
                            controller: controller,
                            text: '${filteredMapList[i]['text']}',
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
