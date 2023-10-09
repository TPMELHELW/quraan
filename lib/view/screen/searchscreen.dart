import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final List search, inf;
  const SearchScreen({super.key, required this.search, required this.inf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: search.length,
          itemBuilder: (context, i) {
            return Center(
              child: Text(search[i]),
            );
          }),
    );
  }
}
