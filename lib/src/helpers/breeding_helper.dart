import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../data/classes/ovi_variables.dart';
import '../data/riverpod_globals.dart';

class BreedingHelper {
  BreedingHelper(this.ref);

  final WidgetRef ref;
  List<OviVariables> allAnimals = [];

  List<OviVariables> getPossibleFathers(OviVariables selectedAnimal) {
    allAnimals = ref.read(animalListProvider).value?? [];
    final ancestors = _getAncestors(selectedAnimal);
    final descendants = _getDescendants(selectedAnimal);
    return allAnimals
        .where((animal) =>
            animal.id != selectedAnimal.id &&
            animal.selectedAnimalSpecies ==
                selectedAnimal.selectedAnimalSpecies &&
            (animal.id == selectedAnimal.selectedOviSire?.id ||
                !ancestors.contains(animal.id)) &&
            !descendants.contains(animal.id))
        .toList();
  }

  List<OviVariables> getPossibleMothers(OviVariables selectedAnimal) {
    allAnimals = ref.read(animalListProvider).value?? [];
    final ancestors = _getAncestors(selectedAnimal);
    final descendants = _getDescendants(selectedAnimal);
    return allAnimals
        .where((animal) =>
            animal.id != selectedAnimal.id &&
            animal.selectedAnimalSpecies ==
                selectedAnimal.selectedAnimalSpecies &&
            (animal.id == selectedAnimal.selectedOviDam?.id ||
                !ancestors.contains(animal.id)) &&
            !descendants.contains(animal.id))
        .toList();
  }

  List<OviVariables> getPossibleChildren(OviVariables selectedAnimal) {
    allAnimals = ref.read(animalListProvider).value?? [];
    final ancestors = _getAncestors(selectedAnimal);
    final descendants = _getDescendants(selectedAnimal);
    return allAnimals
        .where((animal) =>
            animal.id != selectedAnimal.id &&
            animal.selectedAnimalSpecies ==
                selectedAnimal.selectedAnimalSpecies &&
            !ancestors.contains(animal.id) &&
            (selectedAnimal.breedChildren
                    .any((child) => child.id == animal.id) ||
                !descendants.contains(animal.id)) &&
            (selectedAnimal.breedPartner == null ||
                animal.id != selectedAnimal.breedPartner!.id))
        .toList();
  }

  List<OviVariables> getPossiblePartners(OviVariables selectedAnimal) {
    allAnimals = ref.read(animalListProvider).value?? [];
    final ancestors = _getAncestors(selectedAnimal);
    final descendants = _getDescendants(selectedAnimal);
    return allAnimals
        .where((animal) =>
            animal.id != selectedAnimal.id &&
            animal.selectedAnimalSpecies ==
                selectedAnimal.selectedAnimalSpecies &&
            !ancestors.contains(animal.id) &&
            !descendants.contains(animal.id))
        .toList();
  }

  Set<int> _getAncestors(OviVariables selectedAnimal,
      {Set<int> prevAncestors = const {}}) {
    final ancestors = Set<int>.from(prevAncestors);
    if (selectedAnimal.selectedOviSire != null &&
        !ancestors.contains(selectedAnimal.selectedOviSire!.id)) {
      ancestors.add(selectedAnimal.selectedOviSire!.id);
      final father = allAnimals.firstWhereOrNull(
          (animal) => animal.id == selectedAnimal.selectedOviSire!.id);
      if (father != null) {
        ancestors.addAll(_getAncestors(father, prevAncestors: ancestors));
      }
    }
    if (selectedAnimal.selectedOviDam != null &&
        !ancestors.contains(selectedAnimal.selectedOviDam!.id)) {
      ancestors.add(selectedAnimal.selectedOviDam!.id);
      final mother = allAnimals.firstWhereOrNull(
          (animal) => animal.id == selectedAnimal.selectedOviDam!.id);
      if (mother != null) {
        ancestors.addAll(_getAncestors(mother, prevAncestors: ancestors));
      }
    }

    return ancestors;
  }

  Set<int> _getDescendants(OviVariables selectedAnimal,
      {Set<int> prevDescendants = const {}}) {
    final descendants = Set<int>.from(prevDescendants);
    var children = [];
    if (descendants.isEmpty && selectedAnimal.breedChildren.isNotEmpty) {
      children = allAnimals
          .where((animal) => selectedAnimal.breedChildren
              .any((child) => child.id == animal.id))
          .toList();
    } else {
      children = allAnimals
          .where((animal) =>
              (animal.selectedOviSire != null &&
                  animal.selectedOviSire!.id == selectedAnimal.id) ||
              (animal.selectedOviDam != null &&
                  animal.selectedOviDam!.id == selectedAnimal.id))
          .toList();
    }

    for (var child in children) {
      descendants.add(child.id);
      descendants.addAll(_getDescendants(child, prevDescendants: descendants));
    }

    return descendants;
  }
}
