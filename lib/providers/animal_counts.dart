import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../src/screens/reg_mode/reg_home_page.dart';

/// Manages a list of [AnimalData], allowing for the addition of animal data entries.
class AnimalCountNotifier extends StateNotifier<List<AnimalData>> {
  AnimalCountNotifier() : super([]);

  /// Adds [animalData] to the list of animal data.
  void addAnimalData(AnimalData animalData) {
    state = [...state, animalData];
  }
}

final animalCountNotifierProvider =
    StateNotifierProvider<AnimalCountNotifier, List<AnimalData>>((ref) {
  return AnimalCountNotifier();
});

final animalCountProvider = Provider<List<AnimalData>>((ref) {
  return ref.watch(animalCountNotifierProvider);
});
