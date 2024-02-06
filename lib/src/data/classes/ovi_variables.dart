import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/data/classes/surgery_details.dart';
import 'package:sulala_upgrade/src/data/classes/vaccine_details.dart';

import 'breed_child_item.dart';
import 'breeding_details.dart';
import 'breeding_partner.dart';
import 'id_helper.dart';
import 'main_animal_dam.dart';
import 'main_animal_sire.dart';
import 'medical_checkup_details.dart';

class OviVariables {
  final List<String> selectedFilters;
  late final String animalName;
  final MainAnimalSire? selectedOviSire;
  final MainAnimalDam? selectedOviDam;
  late final DateTime? dateOfBirth;
  final DateTime? dateOfLayingEggs;
  final DateTime? dateOfSonar;
  final DateTime? expDlvDate;
  final DateTime? incubationDate;
  final Map<String, String>? customFields;
  final String keptInOval;
  final String notes;
  final String selectedOviGender;
  final Map<String, DateTime?> selectedOviDates;
  final String selectedAnimalBreed;
  final String selectedAnimalSpecies;
  final String selectedAnimalType;
  final List<String> selectedOviChips;
  ImageProvider? selectedOviImage;
  final String layingFrequency;
  final String eggsPerMonth;
  final String selectedBreedingStage;
  final String? medicalNeeds;
  final bool shouldAddAnimal;
  final String breedingEventNumber;
  final String breedSire;
  final String breedDam;
  final BreedingPartner? breedPartner;
  final List<BreedChildItem> breedChildren;
  final DateTime? breedingDate;
  final DateTime? breedDeliveryDate;
  final String breedingNotes;
  final bool shouldAddEvent;
  final BreedingDetails? breedingDetails;
  final Map<String, List<VaccineDetails>> vaccineDetails;
  final Map<String, List<MedicalCheckupDetails>> checkUpDetails;
  final Map<String, List<SurgeryDetails>> surgeryDetails;
  final List<File>? files;
  final int? pregnanciesCount;
  final bool? pregnant;
  int? _age;
  int? _id;

  OviVariables(
      {required this.selectedFilters,
      required this.animalName,
      required this.selectedOviSire,
      required this.selectedOviDam,
      required this.dateOfBirth,
      required this.dateOfSonar,
      required this.expDlvDate,
      required this.incubationDate,
      required this.selectedOviGender,
      this.customFields,
      required this.keptInOval,
      required this.notes,
      required this.selectedOviDates,
      required this.selectedAnimalBreed,
      required this.selectedAnimalSpecies,
      required this.selectedAnimalType,
      required this.selectedOviChips,
      required this.selectedOviImage,
      required this.layingFrequency,
      required this.eggsPerMonth,
      required this.selectedBreedingStage,
      required this.shouldAddAnimal,
      required this.medicalNeeds,
      required this.breedingEventNumber,
      required this.breedSire,
      required this.breedDam,
      this.breedPartner,
      required this.breedChildren,
      required this.breedingDate,
      required this.breedDeliveryDate,
      required this.breedingNotes,
      required this.shouldAddEvent,
      this.breedingDetails,
      required this.vaccineDetails,
      required this.dateOfLayingEggs,
      required this.checkUpDetails,
      required this.surgeryDetails,
      this.pregnant,
      this.files,
      this.pregnanciesCount});
  OviVariables copyWith(
      {List<String>? selectedFilters,
      String? animalName,
      MainAnimalSire? selectedOviSire,
      MainAnimalDam? selectedOviDam,
      DateTime? dateOfBirth,
      DateTime? dateOfLayingEggs,
      DateTime? dateOfSonar,
      DateTime? expDlvDate,
      String? keptInOval,
      DateTime? incubationDate,
      String? fieldName,
      String? fieldContent,
      String? notes,
      String? selectedOviGender,
      Map<String, DateTime?>? selectedOviDates,
      String? selectedAnimalBreed,
      String? selectedAnimalSpecies,
      String? selectedAnimalType,
      List<String>? selectedOviChips,
      ImageProvider? selectedOviImage,
      String? layingFrequency,
      String? eggsPerMonth,
      String? selectedBreedingStage,
      String? medicalNeeds,
      bool? shouldAddAnimal,
      String? breedingEventNumber,
      String? breedSire,
      String? breedDam,
      BreedingPartner? breedPartner,
      List<BreedChildItem>? breedChildren,
      DateTime? breedingDate,
      DateTime? breedDeliveryDate,
      String? breedingNotes,
      bool? shouldAddEvent,
      List<File>? files,
      Map<String, List<VaccineDetails>>? vaccineDetails,
      Map<String, List<MedicalCheckupDetails>>? checkUpDetails,
      Map<String, List<SurgeryDetails>>? surgeryDetails,
      Map<String, String>? customFields,
      bool? pregnant,
      int? pregnanciesCount,
      // ignore: non_constant_identifier_names
      BreedingDetails? BreedingDetails}) {
    return OviVariables(
        selectedFilters: selectedFilters ?? this.selectedFilters,
        animalName: animalName ?? this.animalName,
        selectedOviSire: selectedOviSire ?? this.selectedOviSire,
        selectedOviDam: selectedOviDam ?? this.selectedOviDam,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        dateOfLayingEggs: dateOfLayingEggs ?? this.dateOfLayingEggs,
        dateOfSonar: dateOfSonar ?? this.dateOfSonar,
        expDlvDate: expDlvDate ?? this.expDlvDate,
        customFields: customFields ?? this.customFields,
        notes: notes ?? this.notes,
        incubationDate: incubationDate ?? this.incubationDate,
        keptInOval: keptInOval ?? this.keptInOval,
        selectedOviGender: selectedOviGender ?? this.selectedOviGender,
        selectedOviDates: selectedOviDates ?? this.selectedOviDates,
        selectedAnimalBreed: selectedAnimalBreed ?? this.selectedAnimalBreed,
        selectedAnimalSpecies:
            selectedAnimalSpecies ?? this.selectedAnimalSpecies,
        selectedAnimalType: selectedAnimalType ?? this.selectedAnimalType,
        selectedOviChips: selectedOviChips ?? this.selectedOviChips,
        selectedOviImage: selectedOviImage ?? this.selectedOviImage,
        layingFrequency: layingFrequency ?? this.layingFrequency,
        eggsPerMonth: eggsPerMonth ?? this.eggsPerMonth,
        selectedBreedingStage:
            selectedBreedingStage ?? this.selectedBreedingStage,
        medicalNeeds: medicalNeeds ?? this.medicalNeeds,
        shouldAddAnimal: shouldAddAnimal ?? this.shouldAddAnimal,
        breedingEventNumber: breedingEventNumber ?? this.breedingEventNumber,
        breedSire: breedSire ?? this.breedSire,
        breedDam: breedDam ?? this.breedDam,
        breedChildren: breedChildren ?? this.breedChildren,
        breedingDate: breedingDate ?? this.breedingDate,
        breedDeliveryDate: breedDeliveryDate ?? this.breedDeliveryDate,
        breedingNotes: breedingNotes ?? this.breedingNotes,
        breedPartner: breedPartner,
        shouldAddEvent: shouldAddEvent ?? this.shouldAddEvent,
        breedingDetails: breedingDetails,
        vaccineDetails: vaccineDetails ?? this.vaccineDetails,
        checkUpDetails: checkUpDetails ?? this.checkUpDetails,
        surgeryDetails: surgeryDetails ?? this.surgeryDetails,
        files: files ?? this.files,
        pregnant: pregnant ?? this.pregnant,
        pregnanciesCount: pregnanciesCount ?? this.pregnanciesCount);
  }

  int get age {
    if (_age == null) {
      if (dateOfBirth == null) {
        _age = 0;
      } else {
        final currentDate = DateTime.now();
        int age = currentDate.year - dateOfBirth!.year;
        if (currentDate.month < dateOfBirth!.month ||
            (currentDate.month == dateOfBirth!.month &&
                currentDate.day < dateOfBirth!.day)) {
          age--;
        }
        _age = age;
      }
    }
    return _age!;
  }

  int get id {
    _id ??= IdHelper.lettersToIndex(animalName);
    return _id!;
  }
}
