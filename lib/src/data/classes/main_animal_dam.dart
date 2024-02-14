import 'package:flutter/material.dart';

import 'main_animal_sire.dart';

class MainAnimalDam {
  final String animalId;
  final String animalName;
  final ImageProvider? selectedOviImage;
  final String selectedOviGender;
  final MainAnimalDam? mother;
  final MainAnimalSire? father;

  MainAnimalDam({
    required this.animalId,
    required this.animalName,
    this.selectedOviImage,
    required this.selectedOviGender,
    this.mother,
    this.father,
  });
}
