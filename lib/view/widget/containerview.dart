import 'package:flutter/material.dart';

class ContainerView extends StatelessWidget {
  final String mainText, subText;
  final void Function()? onPressed;
  const ContainerView(
      {super.key, required this.mainText, required this.subText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: MediaQuery.of(context).size.height - 550,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          image: DecorationImage(
              image: AssetImage('assets/images/4.jpg'), fit: BoxFit.fill),
          color: Colors.blue),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mainText,
              style: const TextStyle(
                  color: Colors.grey, fontSize: 15, fontFamily: "poppins"),
            ),
            Text(
              subText,
              style: const TextStyle(
                  color: Colors.white, fontSize: 35, fontFamily: "poppins"),
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  minimumSize: const Size(20, 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  )),
              child: const Text("Go To"),
            )
          ]),
    );
  }
}
