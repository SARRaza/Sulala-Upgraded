import 'package:flutter/material.dart';

import 'id_helper.dart';
import 'main_animal_sire.dart';

class MainAnimalDam {
  final String animalName;
  final ImageProvider? selectedOviImage;
  final String selectedOviGender;
  final MainAnimalDam? mother;
  final MainAnimalSire? father;
  int? _id;

  MainAnimalDam(
    this.animalName,
    this.selectedOviImage,
    this.selectedOviGender, {
    this.mother,
    this.father,
  });

  int get id {
    _id ??= IdHelper.lettersToIndex(animalName);
    return _id!;
  }
}
