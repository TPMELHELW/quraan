import 'package:flutter/material.dart';
import 'package:quraan/controller/surah_controller.dart';

class SearchWidget extends StatelessWidget {
  final SurahController controller;
  const SearchWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        child: TextFormField(
          onFieldSubmitted: (val) => controller.searchQuran(val),
          decoration: const InputDecoration(
            labelText: 'Search For Ayah',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
