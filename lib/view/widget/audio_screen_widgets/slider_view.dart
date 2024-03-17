// import 'package:flutter/material.dart';
// import 'package:quraan/controller/audio_controller.dart';

// class SliderView extends StatelessWidget {
//   final AudioController controller;
//   const SliderView({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.green,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Column(
//         children: [
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //   children: [
//           //     // IconButton(
//           //     //   onPressed: () async {
//           //     //     Duration? currentPosition =
//           //     //         await controller.player.getCurrentPosition();
//           //     //     if (currentPosition != null) {
//           //     //       int targetPosition = currentPosition.inMilliseconds -
//           //     //           10000; // Adding 10 seconds in milliseconds
//           //     //       if (targetPosition < 0) {
//           //     //         targetPosition =
//           //     //             0; // تأكد من أن القيمة المستهدفة للموقع لا تكون أقل من الصفر
//           //     //       }
//           //     //       await controller.player
//           //     //           .seek(Duration(milliseconds: targetPosition));
//           //     //     }
//           //     //   },
//           //     //   icon: const Icon(
//           //     //     Icons.replay_10,
//           //     //     size: 40,
//           //     //   ),
//           //     // ),
//           //     // CircleAvatar(
//           //     //   backgroundColor: Colors.greenAccent,
//           //     //   radius: 25,
//           //     //   child: IconButton(
//           //     //     color: const Color(0xFFfaf3e3),
//           //     //     iconSize: 30,
//           //     //     onPressed: () {
//           //     //       controller.isPlay == false
//           //     //           ? controller.player.resume()
//           //     //           : controller.player.pause();
//           //     //       controller.isExist = true;
//           //     //       controller.isPlay = !controller.isPlay;
//           //     //       controller.update();
//           //     //     },
//           //     //     icon: Icon(controller.isPlay == false
//           //     //         ? Icons.play_arrow
//           //     //         : Icons.pause),
//           //     //   ),
//           //     // ),
//           //     // IconButton(
//           //     //   onPressed: () async {
//           //     //     Duration? currentPosition =
//           //     //         await controller.player.getCurrentPosition();
//           //     //     if (currentPosition != null) {
//           //     //       int targetPosition = currentPosition.inMilliseconds +
//           //     //           10000; // Adding 10 seconds in milliseconds
//           //     //       await controller.player
//           //     //           .seek(Duration(milliseconds: targetPosition));
//           //     //     }
//           //     //   },
//           //     //   icon: const Icon(
//           //     //     Icons.forward_10,
//           //     //     size: 40,
//           //     //   ),
//           //     // ),
//           //   ],
//           // ),
//           // controller.isExist == false
//           //     ? const Text(
//           //         'Please press the play button',
//           //         style: TextStyle(fontFamily: 'poppins', color: Colors.white),
//           //       )
//           //     :
//         ],
//       ),
//     );
//   }
// }
