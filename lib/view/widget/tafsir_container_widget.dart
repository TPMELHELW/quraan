import 'package:Moshafi/controller/surah_controller.dart';
import 'package:flutter/material.dart';

class TafsirContainerWidget extends StatelessWidget {
  final SurahController controller;
  final String text;
  const TafsirContainerWidget(
      {super.key, required this.controller, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: BoxDecoration(
        color: controller.myServices.shared.getBool("dark") == true
            ? Colors.white
            : Colors.greenAccent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('التفسير الميسر',
              style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(
            height: 6,
          ),
          SelectableText(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize:
                    controller.myServices.shared.getDouble("fontsizetafsir")),
          )
        ],
      ),
    );
  }
}
