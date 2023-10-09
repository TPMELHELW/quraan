import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset('assets/images/1.png'),
          const Text(
            'Hafiz',
            style: TextStyle(
                fontSize: 50,
                fontFamily: 'poppins',
                color: Color(0xFF87d1a4),
                fontWeight: FontWeight.bold),
          ),
          const Text(
            'Learn Quran and \nRecite everyday',
            style: TextStyle(fontSize: 20, fontFamily: 'poppins'),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
              ),
            ),
            child: const Text(
              'Please Swipe the Screen \nto go to Home Screen',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontFamily: 'poppins'),
            ),
          )
        ],
      ),
    );
  }
}
