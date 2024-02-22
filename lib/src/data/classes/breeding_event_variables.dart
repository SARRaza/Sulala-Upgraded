import 'package:flutter/material.dart';

import 'breed_child_item.dart';
import 'breeding_partner.dart';
import 'main_animal_dam.dart';
import 'main_animal_sire.dart';

class BreedingEventVariables {
  final int? id;
  final String eventNumber;
  final MainAnimalSire? sire;
  final MainAnimalDam? dam;
  final BreedingPartner? partner;
  final List<BreedChildItem> children;
  final ImageProvider? breedDam;
  final DateTime? breedingDate;
  final DateTime? deliveryDate;
  final DateTime? layingEggsDate;
  final int? eggsNumber;
  final DateTime? incubationDate;
  final DateTime? hatchingDate;
  final String notes;
  final bool shouldAddEvent;

  BreedingEventVariables(
      {this.id,
      required this.eventNumber,
      this.breedDam,
      this.sire,
      this.dam,
      required this.partner,
      required this.children,
      required this.breedingDate,
      this.deliveryDate,
      required this.notes,
      required this.shouldAddEvent,
      this.layingEggsDate,
      this.eggsNumber,
      this.incubationDate,
      this.hatchingDate});
  BreedingEventVariables copyWith(
      {int? id,
      String? eventNumber,
      MainAnimalSire? sire,
      MainAnimalDam? dam,
      BreedingPartner? partner,
      List<BreedChildItem>? children,
      ImageProvider? breedDam,
      DateTime? breedingDate,
      DateTime? deliveryDate,
      String? notes,
      DateTime? layingEggsDate,
      int? eggsNumber,
      DateTime? incubationDate,
      DateTime? hatchingDate,
      bool? shouldAddEvent
      }) {
    return BreedingEventVariables(
      id: id ?? this.id,
      eventNumber: eventNumber ?? this.eventNumber,
      sire: sire ?? this.sire,
      dam: dam ?? this.dam,
      partner: partner ?? this.partner,
      children: children ?? this.children,
      breedingDate: breedingDate ?? this.breedingDate,
      breedDam: breedDam ?? this.breedDam,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      notes: notes ?? this.notes,
      shouldAddEvent: shouldAddEvent ?? this.shouldAddEvent,
      layingEggsDate: layingEggsDate ?? this.layingEggsDate,
      eggsNumber: eggsNumber ?? this.eggsNumber,
      incubationDate: incubationDate ?? this.incubationDate,
      hatchingDate: hatchingDate ?? this.hatchingDate,
    );
  }
}
