import 'package:flutter/material.dart';

class AudioButtonWidget extends StatelessWidget {
  final Widget icon;
  final void Function()? onPress;
  final double size;
  const AudioButtonWidget({
    super.key,
    required this.icon,
    this.onPress,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: onPress,
      iconSize: size,
    );
  }
}
