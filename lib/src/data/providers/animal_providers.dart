import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../classes/main_animal_dam.dart';
import '../classes/main_animal_sire.dart';
import '../classes/ovi_variables.dart';
import '../classes/reminder_item.dart';
import '../riverpod_globals.dart';

final animalListProvider =
AsyncNotifierProvider<AnimalList, List<OviVariables>>(AnimalList.new);

class AnimalList extends AsyncNotifier<List<OviVariables>> {
  @override
  FutureOr<List<OviVariables>> build() {
    return [];
  }

  Future<void> addAnimal(OviVariables animalDetails) async {
    final animals = List<OviVariables>.from(state.value ?? []);
    final newAnimal = animalDetails.copyWith(id: generateRandomId(6));
    if (animals.isEmpty) {
      animals.add(newAnimal);
    } else {
      animals.insert(0, newAnimal);
    }

    final breedingChildrenDetails = newAnimal.breedChildren;
    for (var child in breedingChildrenDetails) {
      final childIndex = animals.indexWhere((animal) => animal.id == child.animalId);
      final animal = animals[childIndex];
      if (newAnimal.selectedOviGender == 'Male') {
        ref.read(animalListProvider.notifier).updateAnimal(animal.copyWith(
            selectedOviSire: MainAnimalSire(
                animalId: newAnimal.id!,
                animalName: newAnimal.animalName,
                selectedOviImage: newAnimal.selectedOviImage,
                selectedOviGender: newAnimal.selectedOviGender)));
      } else {
        ref.read(animalListProvider.notifier).updateAnimal(animal.copyWith(
            selectedOviDam: MainAnimalDam(
                animalId: newAnimal.id!,
                animalName: newAnimal.animalName,
                selectedOviImage: newAnimal.selectedOviImage,
                selectedOviGender: newAnimal.selectedOviGender)));
      }
    }

    // Check if the selected date is five days away from today
    final DateTime today = DateTime.now();
    final DateTime fiveDaysAway = today.add(const Duration(days: 5));
    newAnimal.selectedOviDates.forEach((dateType, selectedDate) {
      if (selectedDate?.isAfter(today) == true && selectedDate?.isBefore(fiveDaysAway) == true) {
        // Format the selected date as a string (excluding time)
        final formattedDate =
        DateFormat('dd/MM/yyyy').format(selectedDate!.toLocal());

        // Add the selected date to the must do Dates list
        final ReminderItem newItem = ReminderItem(
          animalId: newAnimal.id!,
          animalNames: newAnimal.animalName, // Add the animal name
          dateType: dateType,
          dateInfo: formattedDate,
        );
        ref.read(remindersProvider.notifier).state = [
          ...ref.read(remindersProvider),
          newItem
        ];
      }
    });



    state = AsyncData(animals);
  }

  Future<void> updateAnimal(OviVariables animalDetails) async {
    final newAnimals = List<OviVariables>.from(state.value!);
    final animalIndex =
    newAnimals.indexWhere((animal) => animal.id == animalDetails.id);
    newAnimals[animalIndex] = animalDetails;
    state = AsyncData(newAnimals);
  }

  Future<void> removeAnimal(int id) async {
    final animals = List<OviVariables>.from(state.value!);
    animals.removeWhere((animal) => animal.id == id);
    state = AsyncData(animals);
  }
}