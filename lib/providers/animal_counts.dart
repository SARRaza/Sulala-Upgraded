import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/data/dummy_data.dart';
import '../src/screens/reg_mode/reg_home_page.dart';

class AnimalCountNotifier extends StateNotifier<List<AnimalData>> {
  AnimalCountNotifier() : super([]);

  void addAnimalData(AnimalData animalData) {
    state = [...state, animalData];
  }
}

final chartDataProvider1 =
    StateNotifierProvider<AnimalCountNotifier, List<AnimalData>>(
  (ref) {
    return AnimalCountNotifier();
  },
);

final animalCountProvider = Provider(
  (ref) {
    return chartDataProvider;
  },
);
