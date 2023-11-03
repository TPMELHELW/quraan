import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/settings_controller.dart';
import 'package:quraan/core/services/sharedpreferences.dart';

class ContainerView extends StatelessWidget {
  final String mainText, subText;
  final void Function()? onPressed;
  const ContainerView(
      {super.key,
      required this.mainText,
      required this.subText,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    Services myservices = Get.find();
    return GestureDetector(
      onTap: onPressed,
      child: GetBuilder<SettingsController>(
          init: SettingsController(),
          builder: (controller) {
            return AnimatedContainer(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        offset: Offset(0, 2),
                        blurRadius: 1,
                        spreadRadius: -1),
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.14),
                        offset: Offset(0, 1),
                        blurRadius: 1,
                        spreadRadius: 1),
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.12),
                        offset: Offset(0, 1),
                        blurRadius: 3,
                        spreadRadius: 1)
                  ],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  image: DecorationImage(
                      image: myservices.shared.getBool("dark") == true
                          ? const AssetImage('assets/images/4.jpg')
                          : const AssetImage('assets/images/2.jpg'),
                      fit: BoxFit.fill),
                  color: Colors.blue),
              duration: const Duration(milliseconds: 600),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mainText,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontFamily: "poppins"),
                    ),
                    Text(subText,
                        style: Theme.of(context).textTheme.displayLarge),
                  ]),
            );
          }),
    );
  }
}
