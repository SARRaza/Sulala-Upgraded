import 'package:flutter/material.dart';

import 'id_helper.dart';

class BreedChildItem {
  final String animalName;
  final ImageProvider? selectedOviImage;
  final String selectedOviGender;
  int? _id;

  BreedChildItem(
      this.animalName, this.selectedOviImage, this.selectedOviGender);

  int get id {
    _id ??= IdHelper.lettersToIndex(animalName);
    return _id!;
  }
}
