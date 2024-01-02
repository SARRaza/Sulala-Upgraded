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

List<String> totalBreedsList = ['Adelie Penguin',
  'African Elephant',
  'African Lion',
  'American Alligator',
  'Anaconda',
  'Arabian Horse',
  'Asian Elephant',
  'Asiatic Lion',
  'Atlantic Salmon',
  'Bald Eagle',
  'Bengal Tiger',
  'Betta',
  'Black Bear',
  'Bullfrog',
  'Chimpanzee',
  'Chinese Alligator',
  'Chinook Salmon',
  'Cobra',
  'Coho Salmon',
  'Crested Gecko',
  'Eastern Grey Kangaroo',
  'Emperor Penguin',
  'German Shepherd',
  'Gharial',
  'Giant Panda',
  'Golden Eagle',
  'Golden Retriever',
  'Goldfish',
  'Gorilla',
  "Grevy's Zebra",
  'Grizzly Bear',
  'Guppy',
  'Harpy Eagle',
  'Indochinese Tiger',
  'Khaki Campbell',
  'King Penguin',
  'Labrador',
  'Leghorn',
  'Leopard Gecko',
  'Maine Coon',
  'Mallard',
  'Masai Giraffe',
  'Nile Crocodile',
  'Orangutan',
  'Painted Turtle',
  'Pekin',
  'Persian',
  'Plains Zebra',
  'Plymouth Rock',
  'Poison Dart Frog',
  'Polar Bear',
  'Python',
  'Quarter Horse',
  'Red Kangaroo',
  'Red Panda',
  'Red-eared Slider',
  'Reticulated Giraffe',
  'Rhode Island Red',
  'Saltwater Crocodile',
  'Siamese',
  'Siberian Tiger',
  'Snapping Turtle',
  'Thoroughbred',
  'Tokay Gecko',
  'Tree Frog',
  'suhail'];

Map<String, List<String>> speciesToBreedsMap = {
  'Dog': ['Labrador', 'German Shepherd', 'Golden Retriever'],
  'Cat': ['Siamese', 'Persian', 'Maine Coon'],
  'Elephant': ['African Elephant', 'Asian Elephant'],
  'Lion': ['African Lion', 'Asiatic Lion'],
  'Duck': ['Mallard', 'Pekin', 'Khaki Campbell'],
  'Chicken': ['Rhode Island Red', 'Leghorn', 'Plymouth Rock'],
  'Turtle': ['Red-eared Slider', 'Snapping Turtle', 'Painted Turtle'],
  'Snake': ['Python', 'Cobra', 'Anaconda'],
  'Monkey': ['Chimpanzee', 'Gorilla', 'Orangutan'],
  'Bear': ['Grizzly Bear', 'Polar Bear', 'Black Bear'],
  'Tiger': ['Bengal Tiger', 'Siberian Tiger', 'Indochinese Tiger'],
  'Giraffe': ['Masai Giraffe', 'Reticulated Giraffe'],
  'Kangaroo': ['Red Kangaroo', 'Eastern Grey Kangaroo'],
  'Horse': ['Thoroughbred', 'Quarter Horse', 'Arabian Horse'],
  'Zebra': ['Plains Zebra', 'Grevy\'s Zebra'],
  'Panda': ['Giant Panda', 'Red Panda'],
  'Crocodile': ['Nile Crocodile', 'Saltwater Crocodile', 'Gharial'],
  'Eagle': ['Bald Eagle', 'Golden Eagle', 'Harpy Eagle'],
  'Frog': ['Bullfrog', 'Tree Frog', 'Poison Dart Frog'],
  'Fish': ['Goldfish', 'Guppy', 'Betta'],
  'Penguin': ['Emperor Penguin', 'Adelie Penguin', 'King Penguin'],
  'Alligator': ['American Alligator', 'Chinese Alligator'],
  'Salmon': ['Atlantic Salmon', 'Chinook Salmon', 'Coho Salmon'],
  'Gecko': ['Leopard Gecko', 'Crested Gecko', 'Tokay Gecko'],
};

Map<String, List<String>> morespeciesToBreedsMap = {
  'Dog': ['suhail', 'German Shepherd', 'Golden Retriever'],
  'Cat': ['Siamese', 'Persian', 'Maine Coon'],
  'Elephant': ['African Elephant', 'Asian Elephant'],
  'Lion': ['African Lion', 'Asiatic Lion'],
  'Duck': ['Mallard', 'Pekin', 'Khaki Campbell'],
  'Chicken': ['Rhode Island Red', 'Leghorn', 'Plymouth Rock'],
  'Turtle': ['Red-eared Slider', 'Snapping Turtle', 'Painted Turtle'],
  'Snake': ['Python', 'Cobra', 'Anaconda'],
  'Monkey': ['Chimpanzee', 'Gorilla', 'Orangutan'],
  'Bear': ['Grizzly Bear', 'Polar Bear', 'Black Bear'],
  'Tiger': ['Bengal Tiger', 'Siberian Tiger', 'Indochinese Tiger'],
  'Giraffe': ['Masai Giraffe', 'Reticulated Giraffe'],
  'Kangaroo': ['Red Kangaroo', 'Eastern Grey Kangaroo'],
  'Horse': ['Thoroughbred', 'Quarter Horse', 'Arabian Horse'],
  'Zebra': ['Plains Zebra', 'Grevy\'s Zebra'],
  'Panda': ['Giant Panda', 'Red Panda'],
  'Crocodile': ['Nile Crocodile', 'Saltwater Crocodile', 'Gharial'],
  'Eagle': ['Bald Eagle', 'Golden Eagle', 'Harpy Eagle'],
  'Frog': ['Bullfrog', 'Tree Frog', 'Poison Dart Frog'],
  'Fish': ['Goldfish', 'Guppy', 'Betta'],
  'Penguin': ['Emperor Penguin', 'Adelie Penguin', 'King Penguin'],
  'Alligator': ['American Alligator', 'Chinese Alligator'],
  'Salmon': ['Atlantic Salmon', 'Chinook Salmon', 'Coho Salmon'],
  'Gecko': ['Leopard Gecko', 'Crested Gecko', 'Tokay Gecko'],
};

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
