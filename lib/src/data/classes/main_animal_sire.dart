import 'package:flutter/material.dart';

import 'id_helper.dart';
import 'main_animal_dam.dart';

class MainAnimalSire {
  final String animalName;
  final ImageProvider? selectedOviImage;
  final String selectedOviGender;
  final MainAnimalSire? father;
  final MainAnimalDam? mother;
  int? _id;

  MainAnimalSire(
    this.animalName,
    this.selectedOviImage,
    this.selectedOviGender, {
    this.father,
    this.mother,
  });

  int get id {
    _id ??= IdHelper.lettersToIndex(animalName);
    return _id!;
  }
}
