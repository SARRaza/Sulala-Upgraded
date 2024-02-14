import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/data/providers/animal_list_provider.dart';
import 'classes/breed_child_item.dart';
import 'classes/breeding_partner.dart';
import 'classes/main_animal_dam.dart';
import 'classes/main_animal_sire.dart';
import 'classes/reminder_item.dart';
import 'classes/staff_member.dart';

// Join Now Global Variables
final whoOwnTheFarmProvider = StateProvider<String>((ref) => '');
final whatIsTheNameOfYourFarmProvider = StateProvider<String>((ref) => '');
final hasErrorProvider = StateProvider<bool>((ref) => false);

// Sign Up Global Variables
final selectedCountryCodeProvider = StateProvider<String>((ref) => "+966");
final selectedCountryFlagProvider =
    StateProvider<String>((ref) => "assets/icons/flags/Country=SA.png");
final phoneNumberProvider = StateProvider<String>((ref) => '');
final emailAddressProvider = StateProvider<String>((ref) => '');

// Create Password Global Variables
final passwordProvider = StateProvider<String>((ref) => '');
final passwordConfirmProvider = StateProvider<String>((ref) => '');

// Add Personal Information Global Variables
final firstNameProvider = StateProvider<String>((ref) => '');
final lastNameProvider = StateProvider<String>((ref) => '');

// Add Some Details Global Variables
final farmAddressProvider = StateProvider<String>((ref) => '');
final cityProvider = StateProvider<String>((ref) => '');
final countryProvider = StateProvider<String>((ref) => '');
final profilePictureProvider = StateProvider<File?>((ref) => null);

// Privacy & Security Global Variables
final emailAddressVisibilityProvider = StateProvider<bool>((ref) => false);
final phoneNumberVisibilityProvider = StateProvider<bool>((ref) => false);

// Create Animal Global Variables
final selectedAnimalTypeProvider = StateProvider<String>((ref) => '');
final selectedAnimalSpeciesProvider = StateProvider<String>((ref) => '');
final selectedAnimalBreedsProvider = StateProvider<String>((ref) => '');

// Enter Complete Info Global Variables
final selectedAnimalImageProvider =
    StateProvider<ImageProvider?>((ref) => null);
final animalNameProvider = StateProvider<String>((ref) => '');
final shouldAddAnimalProvider = StateProvider<bool>((ref) => false);
final layingFrequencyProvider = StateProvider<String>((ref) => '');
final eggsPerMonthProvider = StateProvider<String>((ref) => '');
final selectedBreedingStageProvider = StateProvider<String>((ref) => '');
final selectedDateProvider = StateProvider<String>((ref) => '');
final medicalNeedsProvider = StateProvider<String>((ref) => '');
final numOfEggsProvider = StateProvider<String>((ref) => '');
final fieldNameProvider = StateProvider<String>((ref) => '');
final incubationDateProvider = StateProvider<DateTime?>((ref) => null);
final fieldContentProvider = StateProvider<String>((ref) => '');
final additionalNotesProvider = StateProvider<String>((ref) => '');
final selectedOviGenderProvider = StateProvider<String>((ref) => '');
final selectedOviDatesProvider =
    StateProvider<Map<String, DateTime?>>((ref) => {});
final keptInOvalProvider = StateProvider<String>((ref) => '');
final selectedOviChipsProvider = StateProvider<List<String>>((ref) => []);
final customOviTextFieldsProvider =
    StateProvider<Map<String, String>>((ref) => {});
final selectedFiltersProvider = StateProvider<List<String>>((ref) => []);
final dateOfBirthProvider = StateProvider<DateTime?>((ref) => null);
final dateOfLayingEggsProvider = StateProvider<DateTime?>((ref) => null);
final dateOfSonarProvider = StateProvider<DateTime?>((ref) => null);
final expDeliveryDateProvider = StateProvider<DateTime?>((ref) => null);
final breedingEventNumberProvider = StateProvider<String>((ref) => '');
final breedingSireDetailsProvider = StateProvider<String?>((ref) => null);
final breedingDamDetailsProvider = StateProvider<String?>((ref) => null);
final breedingPartnerDetailsProvider = StateProvider<String?>((ref) => null);
final breedingDateProvider = StateProvider<DateTime?>((ref) => null);
final deliveryDateProvider = StateProvider<DateTime?>((ref) => null);
final breedingNotesProvider = StateProvider<String>((ref) => '');
final shouldAddEventProvider = StateProvider<bool>((ref) => false);


final animalSireDetailsProvider = StateProvider<MainAnimalSire?>((ref) => null);
final animalDamDetailsProvider = StateProvider<MainAnimalDam?>((ref) => null);

// Reg Home Page Pie Chart Global Variables
final mammalCountProvider = Provider<int>((ref) {
  return (ref.watch(animalListProvider).value ?? [])
      .where((animal) => animal.selectedAnimalType.toLowerCase() == 'mammal')
      .length;
});
final oviparousCountProvider = Provider<int>((ref) {
  return (ref.watch(animalListProvider).value ?? [])
      .where((animal) => animal.selectedAnimalType.toLowerCase() == 'oviparous')
      .length;
});

final totalAnimalsCountProvider = Provider<int>((ref) {
  return (ref.watch(animalListProvider).value ?? []).length;
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

List<String> totalBreedsList = [
  'Adelie Penguin',
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
  'suhail'
];

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

Map<String, List<String>> moreSpeciesToBreedsMap = {
  'Dog': ['German Shepherd', 'Golden Retriever'],
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

Map<String, int> gestationPeriods = {
  // Mammals
  'Dog': 63,
  'Cat': 66,
  'Elephant': 650,
  'Lion': 110,
  'Monkey': 174,
  'Bear': 225,
  'Tiger': 103,
  'Giraffe': 430,
  'Kangaroo': 34,
  'Horse': 338,
  'Zebra': 375,
  'Panda': 135,
};

Map<String, int> breedingToLayingPeriods = {
  'Duck': 7, // Ducks may lay eggs about a week after mating
  'Chicken': 1, // Chickens can lay an egg a day or two after mating
  'Turtle': 30, // Turtles might lay eggs about a month after mating
  'Snake': 30, // Snakes often lay eggs around a month after mating
  'Crocodile': 30, // Crocodiles usually lay eggs about a month after mating
  'Eagle': 40, // Eagles lay eggs several weeks after mating
  'Frog': 7, // Frogs lay eggs shortly after mating
  'Fish':
      2, // Many fish species lay eggs within a few days after mating/spawning
  'Penguin': 15, // Penguins may lay eggs a couple of weeks after mating
  'Alligator': 35, // Alligators typically lay eggs about a month after mating
  'Salmon': 3, // Salmon lay eggs shortly after spawning
  'Gecko': 20, // Geckos might lay eggs a few weeks after mating
};

Map<String, int> incubationPeriods = {
  'Duck': 28,
  'Chicken': 21,
  'Turtle': 60,
  'Snake': 60,
  'Crocodile': 80,
  'Eagle': 35,
  'Frog': 21,
  'Fish': 14,
  'Penguin': 65,
  'Alligator': 65,
  'Salmon': 40,
  'Gecko': 60,
};

final mammalSpeciesCountProvider = Provider<Map<String, int>>((ref) {
  final mammals = (ref.watch(animalListProvider).value ?? [])
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
  final oviparous = (ref.watch(animalListProvider).value ?? [])
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
final dateOfHatchingProvider = StateProvider<DateTime?>((ref) => null);
final dateOfDeathProvider = StateProvider<DateTime?>((ref) => null);
final dateOfSaleProvider = StateProvider<DateTime?>((ref) => null);
final dateOfWeaningProvider = StateProvider<DateTime?>((ref) => null);
final dateOfMatingProvider = StateProvider<DateTime?>((ref) => null);
final uploadedFilesProvider = Provider<List<String>>((ref) => []);
final selectedAnimalNameProvider = Provider<String>((ref) => '');
final selectedBreedDamProvider = Provider<String>((ref) => '');
final breedDamPictureProvider = StateProvider<File?>((ref) => null);

final breedingChildrenDetailsProvider =
    StateProvider<List<BreedChildItem>>((ref) => []);

final remindersProvider = StateProvider<List<ReminderItem>>((ref) => []);

final breedingPartnerProvider = StateProvider<BreedingPartner?>((ref) => null);

final staffProvider = StateProvider<List<StaffMember>>((ref) => [
      StaffMember(
          id: '1',
          image: const AssetImage('assets/avatars/120px/Staff1.png'),
          name: 'Paul Rivera',
          role: 'Viewer',
          email: 'paul@example.com',
          phoneNumber: '+1 234 567 890',
          address: 'United Arab Emirates'),
      StaffMember(
          id: '2',
          image: const AssetImage('assets/avatars/120px/Staff2.png'),
          name: 'Rebecca Wilson',
          role: 'Helper',
          email: 'paul@example.com',
          phoneNumber: '+1 234 567 890',
          address: 'United Arab Emirates'),
    ]);
final totalStaffProvider = Provider<int>((ref) {
  return ref.watch(staffProvider).length;
});
final collaborationRequestsProvider =
    StateProvider<List<StaffMember>>((ref) => [
          StaffMember(
              id: '3',
              image: const AssetImage('assets/avatars/120px/Staff3.png'),
              name: 'Patricia Williams',
              role: 'Viewer',
              email: 'paul@example.com',
              phoneNumber: '+1 234 567 890',
              address: 'United Arab Emirates'),
          StaffMember(
              id: '4',
              image: const AssetImage('assets/avatars/120px/Staff1.png'),
              name: 'Scott Simmons',
              role: 'Viewer',
              email: 'paul@example.com',
              phoneNumber: '+1 234 567 890',
              address: 'United Arab Emirates'),
          StaffMember(
              id: '5',
              image: const AssetImage('assets/avatars/120px/Staff2.png'),
              name: 'Lee Hall',
              role: 'Viewer',
              email: 'paul@example.com',
              phoneNumber: '+1 234 567 890',
              address: 'United Arab Emirates'),
        ]);

final passwordValidationProvider = Provider.autoDispose<bool>((ref) {
  final password = ref.watch(passwordProvider);
  final confirmPassword = ref.watch(passwordConfirmProvider);

  return password == confirmPassword &&
      password.length >= 8 &&
      RegExp(r'[0-9]').hasMatch(password);
});

String generateRandomId(int length) {
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  Random rnd = Random();

  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}