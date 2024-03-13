import 'package:flutter/material.dart';
import 'package:quraan/controller/surah_controller.dart';
// import 'package:quraan/controller/surahcontroller.dart';

class DrawerWidget extends StatelessWidget {
  final SurahController controller;
  const DrawerWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.readers.length,
      itemBuilder: (context, i) {
        return AnimatedContainer(
          decoration: BoxDecoration(
            color: controller.audioSelected['id'] == controller.readers[i]['id']
                ? Colors.greenAccent
                : Colors.transparent,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          duration: const Duration(milliseconds: 600),
          child: ListTile(
            // selected:
            // controller.audioSelected['id'] == controller.readers[i]['id'],
            // selectedColor: Colors,
            // selectedTileColor: Colors.greenAccent,
            title: Text(
              "${controller.readers[i]['name']}",
              style: const TextStyle(fontFamily: "cairo"),
            ),
            onTap: () {
              controller.onPress(i);
              // controller.drawerController
              controller.drawerController.hideDrawer();
              controller.update();
            },
          ),
        );
      },
    );
  }
}
