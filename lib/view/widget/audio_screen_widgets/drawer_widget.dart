import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:Moshafi/controller/audio_controller.dart';

class DrawerWidget extends StatelessWidget {
  final AudioController controller;
  final AdvancedDrawerController drawerController;
  const DrawerWidget({
    super.key,
    required this.controller,
    required this.drawerController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.controller.readers.length,
      itemBuilder: (context, i) {
        return AnimatedContainer(
          decoration: BoxDecoration(
            color: controller.audioSelected['id'] ==
                    controller.controller.readers[i]['id']
                ? Colors.greenAccent
                : Colors.transparent,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          duration: const Duration(milliseconds: 500),
          child: ListTile(
            title: Text(
              "${controller.controller.readers[i]['name']}",
              style: const TextStyle(fontFamily: "cairo"),
            ),
            onTap: () {
              controller.onPress(i);
              drawerController.hideDrawer();
              // controller.update();
            },
          ),
        );
      },
    );
  }
}
