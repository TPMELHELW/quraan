import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class DetailSurahController extends GetxController {
  final player = AudioPlayer();
  bool isPlaying = false;
  bool isPlay = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  double value = 0;
      bool isExist = false;


  double x = 0;
  double y = 0;
  bool isDrawer = false;

  @override
  void onInit() {
    player.onPlayerStateChanged.listen((event) {
      isPlaying = event == PlayerState.playing;
      update();
    });

    player.onPositionChanged.listen((event) {
      position = event;
      update();
    });

    player.onDurationChanged.listen((event) {
      duration = event;
      update();
    });
    super.onInit();
  }
}
