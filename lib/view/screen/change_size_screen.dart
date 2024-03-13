import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/settings_controller.dart';
import 'package:quraan/view/widget/settings_widgets/size_slider.dart';

class ChangeSizeScreen extends StatelessWidget {
  const ChangeSizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GetBuilder<SettingsController>(
                      init: SettingsController(),
                      builder: (controller) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                              ),
                              child: const Text(
                                "Ayah Size",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text("بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontSize: controller.myservices.shared
                                          .getDouble("fontsize"),
                                    )),
                            SizeSlider(
                              label:
                                  controller.valueSliderAyah.toInt().toString(),
                              value: controller.valueSliderAyah,
                              onChanged: (value) {
                                controller.valueSliderAyah = value;
                                controller.myservices.shared.setDouble(
                                    "fontsize", controller.valueSliderAyah);
                                print(controller.myservices.shared
                                    .getDouble("fontsize"));
                                controller.update();
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                              ),
                              child: const Text(
                                "Tasfir Size",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              "(الرَّحْمَنِ) الذي وسعت رحمته جميع الخلق، (الرَّحِيمِ)، بالمؤمنين، وهما اسمان من أسماء الله تعالى",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: controller.myservices.shared
                                        .getDouble("fontsizetafsir"),
                                  ),
                            ),
                            SizeSlider(
                              label: controller.valueSliderTafsir
                                  .toInt()
                                  .toString(),
                              value: controller.valueSliderTafsir,
                              onChanged: (val) {
                                controller.valueSliderTafsir = val;
                                controller.myservices.shared.setDouble(
                                    "fontsizetafsir",
                                    controller.valueSliderTafsir);

                                controller.update();
                              },
                            )
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
