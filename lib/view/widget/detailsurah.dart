import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quraan/controller/detailsurahcontroller.dart';

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text("${id[i]['id']}")),
                              title: Text(
                                "${id[i]['ar']}",
                                style: const TextStyle(fontFamily: 'poppins'),
                              ),
                              subtitle: Text(
                                "${id[i]['en']}",
                                style: const TextStyle(fontFamily: 'poppins'),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(18),
                              width: MediaQuery.of(context).size.width * 0.90,
                              decoration: const BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30))),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'التفسير الميسر',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "cairo"),
                                    ),
                                    Text(
                                      '${controller0[i]['text']}',
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(fontFamily: 'cairo'),
                                    )
                                  ]),
                            )
                          ],
                        );
                      }),
                ),
              ],
            ),
          );
        });
  }
}
