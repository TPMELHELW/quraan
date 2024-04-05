import 'package:flutter/material.dart';
import 'package:Moshafi/controller/surah_controller.dart';

class SearchWidget extends StatelessWidget {
  final SurahController controller;
  const SearchWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: controller.formState,
        child: TextFormField(
          validator: (val) {
            if (val!.isEmpty) {
              return 'Not Valid value';
            }
            return null;
          },
          onFieldSubmitted: (val) => controller.searchQuran(val),
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.grey,
            hintText: 'Search For Ayah',
            hintStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
