import 'package:sulala_upgrade/src/data/riverpod_globals.dart';


Map<String, List<String>> filterItems = {
  'Animal Type': ['Mammal', 'Oviparous'],
  'Animal Species': mammalSpeciesList + oviparousSpeciesList,
  'Animal Breed': totalBreedsList,
  'Animal Sex': ['Male', 'Female'],
  'Breeding Stage': ['Ready for breeding', 'Pregnant', 'Lactating'],
  'Tags': ['Borrowed', 'Adopted', 'Donated', 'Escaped', 'Stolen', 'Transferred',
    'Injured', 'Sick', 'Quarantined', 'Medication', 'Testing', 'Sold', 'Dead'],
};