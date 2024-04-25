import 'package:Moshafi/core/constant/selection_container_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Moshafi/controller/surah_controller.dart';
import 'package:Moshafi/view/widget/selection_container_widget.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SurahController controller = Get.find<SurahController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Quran',
          style: TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            GetBuilder<SurahController>(
              builder: (con) => SelectionContainerWidget(
                mainText: 'last Read',
                subText: controller.myServices.shared.getString('lastread') ??
                    'Empty',
                onPressed: () {
                  controller.lastReadOnPress();
                },
              ),
            ),
            ...List.generate(
              selectionContainerData.length,
              (index) => SelectionContainerWidget(
                mainText: selectionContainerData[index].mainText,
                subText: selectionContainerData[index].subText,
                onPressed: selectionContainerData[index].onPress,
              ),
            )
          ],
        ),
      ),
    );
  }
}
