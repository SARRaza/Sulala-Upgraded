import 'package:flutter/material.dart';

class BreedingPartner {
  final String animalId;
  final String animalName;
  final ImageProvider? selectedOviImage;
  final String selectedOviGender;

  BreedingPartner(
      {required this.animalId,
      required this.animalName,
      required this.selectedOviImage,
      required this.selectedOviGender});
}
