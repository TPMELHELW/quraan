import 'package:flutter/material.dart';

class SizeSlider extends StatelessWidget {
  final String label;
  final double value;
  final void Function(double)? onChanged;
  const SizeSlider(
      {super.key, required this.label, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: const SliderThemeData(trackHeight: 10),
      child: Slider(
          activeColor: Colors.greenAccent,
          label: label,
          divisions: 50,
          value: value,
          min: 10,
          max: 50,
          onChanged: onChanged),
    );
  }
}
