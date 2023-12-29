// ignore_for_file: camel_case_types

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'classes.dart';

// Join Now Global Variables
final whoOwnTheFarmProvider = StateProvider<String>((ref) => '');
final whatIsTheNameOfYourFarmProvider = StateProvider<String>((ref) => '');
final hasErrorProvider = StateProvider<bool>((ref) => false);

// Sign Up Global Variables
final selectedCountryCodeProvider = StateProvider<String>((ref) => "+966");
final selectedCountryFlagProvider =
    StateProvider<String>((ref) => "assets/icons/flags/Country=SA.png");
final phoneNumberProvider = StateProvider<String>((ref) => '');
final emailAdressProvider = StateProvider<String>((ref) => '');

// Create Password Global Variables
final passwordProvider = StateProvider<String>((ref) => '');
final passwrodConfirmProvider = StateProvider<String>((ref) => '');

// Add Personal Information Gloabl Varibales
final firstNameProvider = StateProvider<String>((ref) => '');
final lastNameProvider = StateProvider<String>((ref) => '');

// Add Some Details Global Variables
final cityProvider = StateProvider<String>((ref) => '');
final countryProvider = StateProvider<String>((ref) => '');
final proflePictureProvider = StateProvider<File?>((ref) => null);

// Selected Language
final languageProvider = StateProvider<String>((ref) => '');

// Privacy & Security Global Variables
final emailAddressVisibilityProvider = StateProvider<bool>((ref) => false);
final phoneNumberVisibilityProvider = StateProvider<bool>((ref) => false);

// Create Animal Global Variables
final selectedAnimalTypeProvider = StateProvider<String>((ref) => '');
final selectedAnimalSpeciesProvider = StateProvider<String>((ref) => '');
final selectedAnimalBreedsProvider = StateProvider<String>((ref) => '');

// Enter Complete Info Global Varibales
final selectedAnimalImageProvider = StateProvider<File?>((ref) => null);
final animalNameProvider = StateProvider<String>((ref) => '');
final shoudlAddAnimalProvider = StateProvider<bool>((ref) => false);
final layingFrequencyProvider = StateProvider<String>((ref) => '');
final eggsPerMonthProvider = StateProvider<String>((ref) => '');
final selectedBreedingStageProvider = StateProvider<String>((ref) => '');
final selectedDateProvider = StateProvider<String>((ref) => '');
final medicalNeedsProvider = StateProvider<String>((ref) => '');
final numOfEggsProvider = StateProvider<String>((ref) => '');
final fieldNameProvider = StateProvider<String>((ref) => '');
final incbationDateProvider = StateProvider<String>((ref) => '');
final fieldContentProvider = StateProvider<String>((ref) => '');
final additionalnotesProvider = StateProvider<String>((ref) => '');
final selectedOviGenderProvider = StateProvider<String>((ref) => '');
final selectedOviDatesProvider =
    StateProvider<Map<String, DateTime?>>((ref) => {});
final keptInOvalProvider = StateProvider<String>((ref) => '');
final selectedOviChipsProvider = StateProvider<List<String>>((ref) => []);
final customOviTextFieldsProvider = StateProvider<List<Widget>>((ref) => []);
final selectedFiltersProvider = StateProvider<List<String>>((ref) => []);
final dateOfBirthProvider = StateProvider<String>((ref) => '');
final dateOfLayingEggsProvider = StateProvider<String>((ref) => '');
final dateOfSonarProvider = StateProvider<String>((ref) => '');
final expDeliveryDateProvider = StateProvider<String>((ref) => '');
final breedingEventNumberProvider = StateProvider<String>((ref) => '');
final breedingSireDetailsProvider = StateProvider<String>((ref) => 'Add');
final breedingDamDetailsProvider = StateProvider<String>((ref) => 'Add');
final breedingPartnerDetailsProvider = StateProvider<String>((ref) => 'Add');
final breedingDateProvider = StateProvider<String>((ref) => '');
final deliveryDateProvider = StateProvider<String>((ref) => '');
final breedingnotesProvider = StateProvider<String>((ref) => '');
final shoudlAddEventProvider = StateProvider<bool>((ref) => false);
final ovianimalsProvider = StateProvider<List<OviVariables>>((ref) => []);
final breedingEventsProvider =
    StateProvider<List<BreedingEventVariables>>((ref) => []);
final vaccineDetailsListProvider =
    StateProvider<List<VaccineDetails>>((ref) => []);
final medicalCheckupDetailsProvider =
    StateProvider<List<MedicalCheckupDetails>>((ref) => []);
final surgeryDetailsProvider = StateProvider<List<SurgeryDetails>>((ref) => []);

// final grandfatherNamesProvider = StateProvider<String>((ref) => 'Add');
// final grandmotherNamesProvider = StateProvider<String>((ref) => 'Add');

final animalSireDetailsProvider =
    StateProvider<List<MainAnimalSire>>((ref) => []);
final animalDamDetailsProvider =
    StateProvider<List<MainAnimalDam>>((ref) => []);

// Reg Home Page Pie Chart Global Variables
final mammalCountProvider = Provider<int>((ref) {
  return ref
      .watch(ovianimalsProvider)
      .where((animal) => animal.selectedAnimalType.toLowerCase() == 'mammal')
      .length;
});
final oviparousCountProvider = Provider<int>((ref) {
  return ref
      .watch(ovianimalsProvider)
      .where((animal) => animal.selectedAnimalType.toLowerCase() == 'oviparous')
      .length;
});

final totalAnimalsCountProvider = Provider<int>((ref) {
  return ref
      .watch(ovianimalsProvider)
      .length;
});

List<String> mammalSpeciesList = [
  'Dog',
  'Cat',
  'Elephant',
  'Lion',
  'Monkey',
  'Bear',
  'Tiger',
  'Giraffe',
  'Kangaroo',
  'Horse',
  'Zebra',
  'Panda',
];

List<String> oviparousSpeciesList = [
  'Duck',
  'Chicken',
  'Turtle',
  'Snake',
  'Crocodile',
  'Eagle',
  'Frog',
  'Fish',
  'Penguin',
  'Alligator',
  'Salmon',
  'Gecko',
];
final mammalSpeciesCountProvider = Provider<Map<String, int>>((ref) {
  final mammals = ref
      .watch(ovianimalsProvider)
      .where((animal) => animal.selectedAnimalType.toLowerCase() == 'mammal')
      .toList();

  Map<String, int> speciesCount = {};

  for (final species in mammalSpeciesList) {
    final count = mammals
        .where((animal) => animal.selectedAnimalSpecies == species)
        .length;
    speciesCount[species] = count;
  }

  return speciesCount;
});

final oviparousSpeciesCountProvider = Provider<Map<String, int>>((ref) {
  final oviparous = ref
      .watch(ovianimalsProvider)
      .where((animal) => animal.selectedAnimalType.toLowerCase() == 'oviparous')
      .toList();

  Map<String, int> speciesCount = {};

  for (final species in oviparousSpeciesList) {
    final count = oviparous
        .where((animal) => animal.selectedAnimalSpecies == species)
        .length;
    speciesCount[species] = count;
  }

  return speciesCount;
});

// Breeding Events Global Variable
final listOfBreedingEventsProvider = Provider<List<String>>((ref) => []);
final dateOfHatchingProvider = StateProvider<DateTime?>((ref) => null);
final dateOfDeathProvider = StateProvider<DateTime?>((ref) => null);
final dateOfSaleProvider = StateProvider<DateTime?>((ref) => null);
final dateOfWeaningProvider = StateProvider<DateTime?>((ref) => null);
final dateOfMatingProvider = StateProvider<DateTime?>((ref) => null);
final uploadedFilesProvider = Provider<List<String>>((ref) => []);
final selectedAnimalNameProvider = Provider<String>((ref) => '');
final selectedbreeddamProvider = Provider<String>((ref) => '');
final breeddamPictureProvider = StateProvider<File?>((ref) => null);

final breedingChildrenDetailsProvider =
    StateProvider<List<BreedChildItem>>((ref) => []);

final remindersProvider = StateProvider<List<ReminderItem>>((ref) => []);

final breedingPartnerProvider =
    StateProvider<List<BreedingPartner>>((ref) => []);
