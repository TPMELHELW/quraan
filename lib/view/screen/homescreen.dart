import 'package:flutter/material.dart';
import 'package:quraan/view/widget/detailsurah.dart';

class HomeScreen extends StatelessWidget {
  final List id;
  final List controller;
  const HomeScreen({
    super.key,
    required this.id,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          DetailSurah(
            id: id,
            controller0: controller,
          ),
        ],
      ),
    );
  }
}
