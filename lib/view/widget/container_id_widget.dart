import 'package:flutter/material.dart';

class ContainerIdWidget extends StatelessWidget {
  final Widget child;
  const ContainerIdWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}
