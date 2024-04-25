import 'package:Moshafi/core/model/selection_container_model.dart';
import 'package:Moshafi/view/screen/audio_screen.dart';
import 'package:Moshafi/view/screen/quran_surah_screen.dart';
import 'package:Moshafi/view/screen/settings_screen.dart';
import 'package:get/get.dart';

List<SelectionContainerModel> selectionContainerData = [
  SelectionContainerModel(
    mainText: 'Quran',
    subText: 'Holy Quran',
    onPress: () => Get.to(
      () => const QuranSurahScreen(),
    ),
  ),
  SelectionContainerModel(
    mainText: 'Audio',
    subText: 'Quran Audio',
    onPress: () => Get.to(
      () => const AudioScreen(),
    ),
  ),
  SelectionContainerModel(
    mainText: 'Ideas',
    subText: 'Settings',
    onPress: () => Get.to(
      () => const SettingsScreen(),
    ),
  ),
];
