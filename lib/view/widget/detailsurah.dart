import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:quraan/controller/tafsircontroller.dart';
import 'package:quraan/controller/detailsurahcontroller.dart';
import 'package:quraan/view/widget/SliderBall.dart';

class DetailSurah extends StatelessWidget {
  final List id;
  final List controller0;
  const DetailSurah({super.key, required this.id, required this.controller0});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailSurahController>(
        init: DetailSurahController(),
        builder: (controller) {
          return SafeArea(
            child: AnimatedContainer(
                // padding: EdgeInsets.symmetric(vertical: 10),
                transform:
                    Matrix4.translationValues(controller.x, controller.y, 0)
                      ..scale(controller.isDrawer ? 0.85 : 1.00)
                      ..rotateZ(controller.isDrawer ? -50 : 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(controller.isDrawer ? 30 : 0)),
                duration: const Duration(milliseconds: 300),
                child: Column(
                  // main
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    controller.isDrawer
                        ? IconButton(
                            onPressed: () {
                              print(controller0);
                              controller.x = 0;
                              controller.y = 0;
                              controller.isDrawer = false;
                              controller.update();
                            },
                            icon: const Icon(Icons.arrow_back))
                        : IconButton(
                            onPressed: () {
                              controller.x = 290;
                              controller.y = 80;
                              controller.isDrawer = true;
                              controller.update();
                            },
                            icon: const Icon(Icons.menu)),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: id.length,
                          itemBuilder: (context, i) {
                            return Column(
                              children: [
                                ListTile(
                                  trailing: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text("${id[i]['id']}")),
                                  title: Text(
                                    "${id[i]['ar']}",
                                    style:
                                        const TextStyle(fontFamily: 'poppins'),
                                  ),
                                  subtitle: Text(
                                    "${id[i]['en']}",
                                    style:
                                        const TextStyle(fontFamily: 'poppins'),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(18),
                                  width:
                                      MediaQuery.of(context).size.width * 0.90,
                                  decoration: const BoxDecoration(
                                      color: Colors.greenAccent,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30))),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'التفسير الميسر',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "cairo"),
                                        ),
                                        Text('${controller0[i]['text']}',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'cairo'),)
                                      ]),
                                )
                              ],
                            );
                          }),
                    ),
                    
                  ],
                )),
          );
        });
  }
}
