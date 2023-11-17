import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/breeding/list_of_breeding_events.dart';
import '../screens/create_animal/sar_listofanimals.dart';

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

// Privacy & Security Global Variables
final emailAddressVisibilityProvider = StateProvider<bool>((ref) => false);
final phoneNumberVisibilityProvider = StateProvider<bool>((ref) => false);

// Create Animal Global Variables
final selectedAnimalTypeProvider = StateProvider<String>((ref) => '');
final selectedAnimalSpeciesProvider = StateProvider<String>((ref) => '');
final selectedAnimalBreedsProvider = StateProvider<String>((ref) => '');

// final selectedSearchFarmProvider =
//     StateProvider<Map<String, dynamic>?>(((ref) => null));
// final selectedSearchAnimalProvider =
//     StateProvider<Map<String, dynamic>?>(((ref) => null));

// Enter Complete Info Global Varibales
final selectedAnimalImageProvider = StateProvider<File?>((ref) => null);
final animalNameProvider = StateProvider<String>((ref) => '');
final animalSireDetailsProvider = StateProvider<String>((ref) => 'Add');
final animalDamDetailsProvider = StateProvider<String>((ref) => 'Add');
final shoudlAddAnimalProvider = StateProvider<bool>((ref) => false);
final layingFrequencyProvider = StateProvider<String>((ref) => '');
final eggsPerMonthProvider = StateProvider<String>((ref) => '');
final selectedBreedingStageProvider = StateProvider<String>((ref) => '');
final selectedDateProvider = StateProvider<String>((ref) => '');
final medicalNeedsProvider = StateProvider<String>((ref) => '');
final fieldNameProvider = StateProvider<String>((ref) => '');
final fieldContentProvider = StateProvider<String>((ref) => '');
final additionalnotesProvider = StateProvider<String>((ref) => '');
final selectedOviGenderProvider = StateProvider<String>((ref) => '');
final selectedOviDatesProvider =
    StateProvider<Map<String, DateTime?>>((ref) => {});
final selectedOviChipsProvider = StateProvider<List<String>>((ref) => []);
final customOviTextFieldsProvider = StateProvider<List<Widget>>((ref) => []);
final selectedFiltersProvider = StateProvider<List<String>>((ref) => []);
final dateOfBirthProvider = StateProvider<String>((ref) => '');
final breedingEventNumberProvider = StateProvider<String>((ref) => '');
final breedingSireDetailsProvider = StateProvider<String>((ref) => 'Add');
final breedingChildrenDetailsProvider = StateProvider<String>((ref) => 'Add');
final breedingDamDetailsProvider = StateProvider<String>((ref) => 'Add');
final breedingPartnerDetailsProvider = StateProvider<String>((ref) => 'Add');
final breedingDateProvider = StateProvider<String>((ref) => '');
final deliveryDateProvider = StateProvider<String>((ref) => '');
final breedingnotesProvider = StateProvider<String>((ref) => '');
final shoudlAddEventProvider = StateProvider<bool>((ref) => false);
final ovianimalsProvider = StateProvider<List<OviVariables>>((ref) => []);
final breedingEventsProvider =
    StateProvider<List<BreedingEventVariables>>((ref) => []);
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
final listOfBreedingEventsProvider = Provider<List<String>>((ref) => []);
// final animalFiltersProvider = Provider<Map<String, String?>>((ref) {
//   // This provider will store the selected filters
//   return {};
// });

