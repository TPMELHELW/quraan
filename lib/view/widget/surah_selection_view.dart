import 'package:flutter/material.dart';
import 'package:quraan/controller/surah_controller.dart';

class SurahSelectionView extends StatelessWidget {
  final SurahController controller;
  const SurahSelectionView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
            leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
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
