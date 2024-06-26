import 'package:flutter/material.dart';

class ChangeButton extends StatelessWidget {
  final void Function()? onPress;
  const ChangeButton({super.key, this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(50, 50),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          )),
      child: const Text("Change"),
    );
  }
}
