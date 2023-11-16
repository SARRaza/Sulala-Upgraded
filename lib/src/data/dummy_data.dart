import 'dart:ui';

import '../screens/reg_mode/reg_home_page.dart';

int mammals = 10;
int oviparous = 20;

int animalsCount(int mammals, int oviparous) {
  return mammals + oviparous;
}

final List<AnimalData> chartDataProvider = [
  AnimalData(
    'All',
    animalsCount(mammals, oviparous),
    const Color.fromRGBO(255, 255, 255, 1),
  ),
  AnimalData(
    'Mammals',
    mammals,
    const Color.fromRGBO(175, 197, 86, 1),
  ),
  AnimalData(
    'Oviparous',
    oviparous,
    const Color.fromRGBO(244, 233, 174, 1),
  ),
];
