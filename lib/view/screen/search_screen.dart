import 'package:Moshafi/controller/surah_controller.dart';
import 'package:Moshafi/core/constant/enum.dart';
import 'package:Moshafi/view/widget/tafsir_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Moshafi/view/widget/container_id_widget.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatelessWidget {
  final List search, inf, tafsir;
  const SearchScreen(
      {super.key,
      required this.search,
      required this.inf,
      required this.tafsir});

  @override
  Widget build(BuildContext context) {
    SurahController controller = Get.find();
    return Scaffold(
      body: controller.statusRequest == StatusRequest.noData
          ? Center(
              child: Lottie.asset(
                'assets/lottie/noData.json',
                width: 250,
              ),
            )
          : ListView.builder(
              itemCount: search.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    ListTile(
                      trailing: ContainerIdWidget(
                        child: Text("${i + 1}"),
                      ),
                      title: SelectableText(
                        "${search[i]}",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontSize: controller.myServices.shared
                                    .getDouble("fontsize")),
                      ),
                      subtitle: SelectableText(
                        "${inf[i]}",
                        style: const TextStyle(fontFamily: 'poppins'),
                      ),
                    ),
                    TafsirContainerWidget(
                        controller: controller, text: '${tafsir[i]['text']}')
                  ],
                );
              },
            ),
    );
  }
}
