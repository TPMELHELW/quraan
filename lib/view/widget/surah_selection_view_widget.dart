import 'package:flutter/material.dart';
import 'package:Moshafi/controller/surah_controller.dart';
import 'package:Moshafi/view/widget/container_id_widget.dart';

class SurahSelectionViewWidget extends StatelessWidget {
  final SurahController controller;
  const SurahSelectionViewWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        controller: controller.scroll,
        shrinkWrap: true,
        itemCount: controller.quranData.length,
        itemBuilder: (context, i) {
          return ListTile(
            onTap: () {
              controller.onSurahTap(i);
              controller.update();
            },
            leading: ContainerIdWidget(
                child: Text("${controller.quranData[i]['id']}")),
            title: Text(
              "${controller.quranData[i]['name_translation']}",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            subtitle: Row(
              children: [
                Text(
                  "${controller.quranData[i]['type']}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            trailing: Text(
              '${controller.quranData[i]['name']}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          );
        },
      ),
    );
  }
}
