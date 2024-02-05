import 'package:sulala_upgrade/src/data/riverpod_globals.dart';

/// Defines filter items used for categorizing animals within the application.
///
/// Each category contains a list of options that can be applied as filters.
class AnimalFilters {
  static final Map<String, List<String>> filterItems = {
    'Animal Type': ['Mammal', 'Oviparous'],
    'Animal Species': mammalSpeciesList + oviparousSpeciesList,
    'Animal Breed': totalBreedsList,
    'Animal Sex': ['Male', 'Female'],
    'Breeding Stage': ['Ready for breeding', 'Pregnant', 'Lactating'],
    'Tags': [
      'Borrowed',
      'Adopted',
      'Donated',
      'Escaped',
      'Stolen',
      'Transferred',
      'Injured',
      'Sick',
      'Quarantined',
      'Medication',
      'Testing',
      'Sold',
      'Dead'
    ],
  };
}
