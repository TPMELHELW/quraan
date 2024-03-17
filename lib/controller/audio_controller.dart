import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:Moshafi/controller/surah_controller.dart';
import 'package:Moshafi/core/constant/enum.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends GetxController {
  bool isSelected = false;
  bool isPlaying = false;
  bool isPlay = false;
  bool isLoop = false;
  List selectedSheikhSuar = [];
  Map audioSelected = {};
  double sliderValue = 0;
  late StatusRequest statusRequest;
  AudioPlayer player = AudioPlayer();
  late int currentPlay;
  int nextAudio = 1;
  String imageUrl =
      'https://img.freepik.com/free-photo/free-photo-ramadan-kareem-eid-mubarak-royal-elegant-lamp-with-mosque-holy-gate-with-fireworks_1340-23603.jpg?t=st=1710550968~exp=1710554568~hmac=974217304834aa7c0586bea2746f45381510876fadeebb52c874639a913ff2c0&w=996';
  SurahController controller = Get.find<SurahController>();

  checkInternetConnection() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    isConnected
        ? statusRequest = StatusRequest.success
        : statusRequest = StatusRequest.offline;
    update();
  }

  Future<void> playSurah(int i) async {
    await checkInternetConnection();
    if (statusRequest == StatusRequest.offline) {
    } else {
      await player.setAudioSource(
        AudioSource.uri(
          Uri.parse(
            '${audioSelected['moshaf'][0]['server']}/${selectedSheikhSuar[i]['array'][0]['filename']}',
          ),
          tag: MediaItem(
            id: '1',
            album: audioSelected['name'],
            title: selectedSheikhSuar[i]['name_translation'],
            artUri: Uri.parse(imageUrl),
          ),
        ),
      );

      isPlaying = true;
      isPlay = true;
      player.play();
      currentPlay = i;
      update();
    }
  }

  Future<void> nextSurah() async {
    await checkInternetConnection();
    if (statusRequest == StatusRequest.offline) {}
    await player.setAudioSource(
      AudioSource.uri(
        Uri.parse(
          '${audioSelected['moshaf'][0]['server']}/${selectedSheikhSuar[currentPlay + nextAudio]['array'][0]['filename']}',
        ),
        tag: MediaItem(
          id: '1',
          album: audioSelected['name'],
          title: selectedSheikhSuar[currentPlay + nextAudio]
              ['name_translation'],
          artUri: Uri.parse(imageUrl),
        ),
      ),
    );
    isPlaying = true;
    currentPlay++;
    player.play();
    update();
  }

  Future<void> previousSurah() async {
    await checkInternetConnection();
    if (statusRequest == StatusRequest.offline) {}
    await player.setAudioSource(
      AudioSource.uri(
        Uri.parse(
          '${audioSelected['moshaf'][0]['server']}/${selectedSheikhSuar[currentPlay - nextAudio]['array'][0]['filename']}',
        ),
        tag: MediaItem(
          id: '1',
          album: audioSelected['name'],
          title: selectedSheikhSuar[currentPlay - nextAudio]
              ['name_translation'],
          artUri: Uri.parse(imageUrl),
        ),
      ),
    );
    isPlaying = true;

    currentPlay--;
    player.play();
    update();
  }

  Future<void> downloadSurah(int i) async {
    Permission.storage;
    FileDownloader.downloadFile(
      name: "${audioSelected['id']}${selectedSheikhSuar[i]['id']}",
      url:
          "${audioSelected['moshaf'][0]['server']}/${selectedSheikhSuar[i]['array'][0]['filename']}",
      downloadDestination: DownloadDestinations.appFiles,
      onDownloadCompleted: (val) async {
        Get.snackbar("Success", "Download Complete");
        update();
      },
    );
  }

  Future<void> playSurahOffline(int i) async {
    await player.setUrl(
      '/storage/emulated/0/Android/data/com.example.quraan/files/data/user/0/com.example.quraan/files/${audioSelected['id']}${selectedSheikhSuar[i]['id']}.mp3',
    );

    isPlaying = true;
    isPlay = true;
    await player.play();
    currentPlay = i;
    update();
  }

  void onPress(int i) {
    try {
      audioSelected = controller.readers[i];
      List m = controller.readers[i]['moshaf'][0]["surah_list"]
          .split(",")
          .map(int.parse)
          .toList();
      selectedSheikhSuar.clear();
      for (int i = 0; i < m.length; i++) {
        List filtired = controller.quranData
            .where((element) => m[i] == element['id'])
            .toList();
        selectedSheikhSuar.addAll(filtired);
      }
      isSelected = true;
    } catch (e) {}
    update();
  }

  @override
  void onInit() {
    statusRequest = StatusRequest.none;
    player.positionStream.listen((event) {
      sliderValue = event.inSeconds.toDouble();
      update();
    });
    super.onInit();
  }
}
