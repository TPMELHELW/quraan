import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text(
          "About App",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Version 1.0.0",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'cairo', fontWeight: FontWeight.bold),
                ),
                const Text(
                  "تم انشاء هذا التطبيق خصيصا للاخ والصاحب وتحت اشراف",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "الشيخ: أسامة السندي",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
               const Text(
                    "M.E",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
