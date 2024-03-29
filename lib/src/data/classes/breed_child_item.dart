import 'package:flutter/material.dart';

class BreedChildItem {
  final int animalId;
  final String animalName;
  final ImageProvider? selectedOviImage;
  final String selectedOviGender;

  BreedChildItem(
      {required this.animalId,
      required this.animalName,
      required this.selectedOviImage,
      required this.selectedOviGender});
}
