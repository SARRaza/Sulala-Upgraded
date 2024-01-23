import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/classes.dart';

import '../data/riverpod_globals.dart';

class BreedingHelper {

  BreedingHelper(this.ref);

  final WidgetRef ref;
  List<OviVariables> allAnimals = [];


  List<OviVariables> getPossibleFathers(OviVariables selectedAnimal) {
    allAnimals = ref.read(ovianimalsProvider);
    final ancestors = _getAncestors(selectedAnimal);
    final descendants = _getDescendants(selectedAnimal);
    return allAnimals.where((animal) => animal.id !=
        selectedAnimal.id && animal.selectedAnimalSpecies == selectedAnimal
        .selectedAnimalSpecies && (animal.id == selectedAnimal
        .selectedOviSire?.id || !ancestors.contains(animal.id)) && !descendants
        .contains(animal.id)).toList();
  }

  List<OviVariables> getPossibleMothers(OviVariables selectedAnimal) {
    allAnimals = ref.read(ovianimalsProvider);
    final ancestors = _getAncestors(selectedAnimal);
    final descendants = _getDescendants(selectedAnimal);
    return allAnimals.where((animal) => animal.id !=
        selectedAnimal.id && animal.selectedAnimalSpecies == selectedAnimal
        .selectedAnimalSpecies && (animal.id == selectedAnimal
        .selectedOviDam?.id || !ancestors.contains(animal.id)) && !descendants
        .contains(animal.id)).toList();
  }

  List<OviVariables> getPossibleChildren(OviVariables selectedAnimal) {
    allAnimals = ref.read(ovianimalsProvider);
    final ancestors = _getAncestors(selectedAnimal);
    final descendants = _getDescendants(selectedAnimal);
    return allAnimals.where((animal) => animal.id !=
        selectedAnimal.id && animal.selectedAnimalSpecies == selectedAnimal
        .selectedAnimalSpecies && !ancestors.contains(animal.id) && (selectedAnimal.breedchildren.any((child
        ) => child.id == animal.id) || !descendants.contains(animal.id)) && (
        selectedAnimal.breedpartner == null || animal.id != selectedAnimal
            .breedpartner!.id)).toList();
  }

  List<OviVariables> getPossiblePartners(OviVariables selectedAnimal) {
    allAnimals = ref.read(ovianimalsProvider);
    final ancestors = _getAncestors(selectedAnimal);
    final descendants = _getDescendants(selectedAnimal);
    return allAnimals.where((animal) => animal.id !=
        selectedAnimal.id && animal.selectedAnimalSpecies == selectedAnimal
        .selectedAnimalSpecies && !ancestors.contains(animal.id) && !descendants
        .contains(animal.id)).toList();
  }

  List<int> _getAncestors(OviVariables selectedAnimal, {List<int> prevAncestors = const []}) {
    final ancestors = List<int>.from(prevAncestors);
    if(selectedAnimal.selectedOviSire != null && !ancestors.contains(
        selectedAnimal.selectedOviSire!.id)) {
      ancestors.add(selectedAnimal.selectedOviSire!.id);
      final father = allAnimals.firstWhereOrNull((animal) => animal.id ==
          selectedAnimal.selectedOviSire!.id);
      if(father != null) {
        ancestors.addAll(_getAncestors(father, prevAncestors: ancestors));
      }
    }
    if(selectedAnimal.selectedOviDam != null && !ancestors.contains(
        selectedAnimal.selectedOviDam!.id)) {
      ancestors.add(selectedAnimal.selectedOviDam!.id);
      final mother = allAnimals.firstWhereOrNull((animal) => animal.id ==
          selectedAnimal.selectedOviDam!.id);
      if(mother != null) {
        ancestors.addAll(_getAncestors(mother, prevAncestors: ancestors));
      }
    }

    return ancestors;
  }

  List<int> _getDescendants(OviVariables selectedAnimal, {List<int> prevDescendants = const []}) {
    final descendants = List<int>.from(prevDescendants);
    var children = [];
    if(descendants.isEmpty && selectedAnimal.breedchildren.isNotEmpty) {
      children = allAnimals.where((animal) => selectedAnimal.breedchildren.any((
          child) => child.id == animal.id)).toList();
    } else {
      children = allAnimals.where((animal) => (animal.selectedOviSire !=
          null && animal.selectedOviSire!.id == selectedAnimal.id) || (animal
          .selectedOviDam != null && animal.selectedOviDam!.id == selectedAnimal
          .id)).toList();
    }

    for (var child in children) {
      descendants.add(child.id);
      descendants.addAll(_getDescendants(child, prevDescendants: descendants));
    }

    return descendants;
  }

}