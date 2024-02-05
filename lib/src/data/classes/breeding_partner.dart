import 'package:flutter/material.dart';

import 'id_helper.dart';

class BreedingPartner {
  final String animalName;
  final ImageProvider? selectedOviImage;
  final String selectedOviGender;
  int? _id;

  BreedingPartner(
      this.animalName, this.selectedOviImage, this.selectedOviGender);

  int get id {
    _id ??= IdHelper.lettersToIndex(animalName);
    return _id!;
  }
}
