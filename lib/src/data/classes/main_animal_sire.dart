import 'package:flutter/material.dart';
import 'main_animal_dam.dart';

class MainAnimalSire {
  final int animalId;
  final String animalName;
  final ImageProvider? selectedOviImage;
  final String selectedOviGender;
  final MainAnimalSire? father;
  final MainAnimalDam? mother;

  MainAnimalSire({
    required this.animalId,
    required this.animalName,
    this.selectedOviImage,
    required this.selectedOviGender,
    this.father,
    this.mother,
  });
}
