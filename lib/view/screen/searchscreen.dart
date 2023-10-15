import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final List search, inf, tafsir;
  const SearchScreen(
      {super.key,
      required this.search,
      required this.inf,
      required this.tafsir});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: search.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                ListTile(
                  trailing: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text("${i + 1}")),
                  title: Text(
                    "${search[i]}",
                  ),
                  subtitle: Text(
                    "${inf[i]}",
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
                              fontWeight: FontWeight.bold, fontFamily: "cairo"),
                        ),
                        Text(
                          '${tafsir[i]['text']}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontFamily: 'cairo'),
                        )
                      ]),
                )
              ],
            );
          }),
    );
  }
}
