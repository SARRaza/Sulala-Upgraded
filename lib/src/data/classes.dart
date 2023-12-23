import 'dart:io';

class MainAnimalSire {
  String animalName;
  File? selectedOviImage;
  String selectedOviGender;
  MainAnimalSire? father;
  MainAnimalDam? mother;

  MainAnimalSire(
    this.animalName,
    this.selectedOviImage,
    this.selectedOviGender, {
    this.father,
    this.mother,
  });
}

class MainAnimalDam {
  final String animalName;
  final File? selectedOviImage;
  final String selectedOviGender;
  MainAnimalDam? mother;
  MainAnimalSire? father;

  MainAnimalDam(
    this.animalName,
    this.selectedOviImage,
    this.selectedOviGender, {
    this.mother,
    this.father,
  });
}

class BreedingPartner {
  final String animalName;
  final File? selectedOviImage;
  final String selectedOviGender;

  BreedingPartner(
      this.animalName, this.selectedOviImage, this.selectedOviGender);
}

class ReminderItem {
  final String animalNames;
  final String dateInfo;

  final String dateType;

  ReminderItem(this.animalNames, this.dateType, this.dateInfo);
}

class BreedChildItem {
  final String animalName;
  final File? selectedOviImage;
  final String selectedOviGender;

  BreedChildItem(
      this.animalName, this.selectedOviImage, this.selectedOviGender);
}

class BreedingEventVariables {
  final String eventNumber;
  final String sire;
  final String dam;
  final List<BreedingPartner> partner;
  final List<BreedChildItem> children;
  final File? breeddam;
  final String breedingDate;
  final String deliveryDate;
  final String notes;
  final bool shouldAddEvent;

  BreedingEventVariables({
    required this.eventNumber,
    this.breeddam,
    required this.sire,
    required this.dam,
    required this.partner,
    required this.children,
    required this.breedingDate,
    required this.deliveryDate,
    required this.notes,
    required this.shouldAddEvent,
  });
}

class OviVariables {
  final List<String> selectedFilters;
  late final String animalName;
  final List<MainAnimalSire> selectedOviSire;
  final List<MainAnimalDam> selectedOviDam;
  late final String dateOfBirth;
  final String dateOfLayingEggs;
  final String dateOfSonar;
  final String expDlvDate;
  final String incubationDate;
  final String fieldName;
  final String fieldContent;
  final String keptInOval;
  final String notes;
  final String selectedOviGender;
  final Map<String, DateTime?> selectedOviDates;
  final String selectedAnimalBreed;
  final String selectedAnimalSpecies;
  final String selectedAnimalType;
  final List<String> selectedOviChips;
  final File? selectedOviImage;
  final String layingFrequency;
  final String eggsPerMonth;
  final String numOfEggs;
  final String selectedBreedingStage;
  late final String medicalNeeds;
  final bool shouldAddAnimal;
  final String breedingeventNumber;
  final String breedsire;
  final String breeddam;
  final List<BreedingPartner> breedpartner;
  final List<BreedChildItem> breedchildren;
  final String breedingDate;
  final String breeddeliveryDate;
  final String breedingnotes;
  final bool shouldAddEvent;
  final BreedingDetails breedingDetails;
  final Map<String, List<BreedingEventVariables>> breedingEvents;
  final Map<String, List<VaccineDetails>> vaccineDetails;
  final Map<String, List<MedicalCheckupDetails>> checkUpDetails;
  final Map<String, List<SurgeryDetails>> surgeryDetails;

  OviVariables({
    required this.selectedFilters,
    required this.animalName,
    required this.selectedOviSire,
    required this.selectedOviDam,
    required this.dateOfBirth,
    required this.dateOfSonar,
    required this.expDlvDate,
    required this.incubationDate,
    required this.selectedOviGender,
    required this.fieldName,
    required this.fieldContent,
    required this.numOfEggs,
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
    required this.breedingeventNumber,
    required this.breedsire,
    required this.breeddam,
    required this.breedpartner,
    required this.breedchildren,
    required this.breedingDate,
    required this.breeddeliveryDate,
    required this.breedingnotes,
    required this.shouldAddEvent,
    required this.breedingDetails,
    required this.breedingEvents,
    required this.vaccineDetails,
    required this.dateOfLayingEggs,
    required this.checkUpDetails,
    required this.surgeryDetails,
  });
  OviVariables copyWith(
      {List<String>? selectedFilters,
      String? animalName,
      List<MainAnimalSire>? selectedOviSire,
      List<MainAnimalDam>? selectedOviDam,
      String? dateOfBirth,
      String? dateOfLayingEggs,
      String? dateOfSonar,
      String? expDlvDate,
      String? keptInOval,
      String? incubationDate,
      String? fieldName,
      String? numOfEggs,
      String? fieldContent,
      String? notes,
      String? selectedOviGender,
      Map<String, DateTime?>? selectedOviDates,
      String? selectedAnimalBreed,
      String? selectedAnimalSpecies,
      String? selectedAnimalType,
      List<String>? selectedOviChips,
      File? selectedOviImage,
      String? layingFrequency,
      String? eggsPerMonth,
      String? selectedBreedingStage,
      String? medicalNeeds,
      bool? shouldAddAnimal,
      String? breedingeventNumber,
      String? breedsire,
      String? breeddam,
      List<BreedingPartner>? breedpartner,
      List<BreedChildItem>? breedchildren,
      String? breedingDate,
      String? breeddeliveryDate,
      String? breedingnotes,
      bool? shouldAddEvent,
      Map<String, List<BreedingEventVariables>>? breedingEvents,
      Map<String, List<VaccineDetails>>? vaccineDetails,
      Map<String, List<MedicalCheckupDetails>>? checkUpDetails,
      Map<String, List<SurgeryDetails>>? surgeryDetails,
      // ignore: non_constant_identifier_names
      String? BreedingDetails}) {
    return OviVariables(
      selectedFilters: selectedFilters ?? this.selectedFilters,
      animalName: animalName ?? this.animalName,
      selectedOviSire: selectedOviSire ?? this.selectedOviSire,
      selectedOviDam: selectedOviDam ?? this.selectedOviDam,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      dateOfLayingEggs: dateOfLayingEggs ?? this.dateOfLayingEggs,
      dateOfSonar: dateOfSonar ?? this.dateOfSonar,
      expDlvDate: expDlvDate ?? this.expDlvDate,
      fieldName: fieldName ?? this.fieldName,
      fieldContent: fieldContent ?? this.fieldContent,
      notes: notes ?? this.notes,
      incubationDate: incubationDate ?? this.incubationDate,
      keptInOval: keptInOval ?? this.keptInOval,
      numOfEggs: numOfEggs ?? this.numOfEggs,
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
      breedingeventNumber: breedingeventNumber ?? this.breedingeventNumber,
      breedsire: breedsire ?? this.breedsire,
      breeddam: breeddam ?? this.breeddam,
      breedchildren: breedchildren ?? this.breedchildren,
      breedingDate: breedingDate ?? this.breedingDate,
      breeddeliveryDate: breeddeliveryDate ?? this.breeddeliveryDate,
      breedingnotes: breedingnotes ?? this.breedingnotes,
      breedpartner: breedpartner ?? this.breedpartner,
      shouldAddEvent: shouldAddEvent ?? this.shouldAddEvent,
      breedingDetails: breedingDetails,
      breedingEvents: breedingEvents ?? this.breedingEvents,
      vaccineDetails: vaccineDetails ?? this.vaccineDetails,
      checkUpDetails: checkUpDetails ?? this.checkUpDetails,
      surgeryDetails: surgeryDetails ?? this.surgeryDetails,
    );
  }
}

class BreedingDetails {
  final String breedsire;
  final String breeddam;
  final List<BreedingPartner> breedpartner;
  final List<BreedChildItem> breedchildren;
  final String breedingDate;
  final String breeddeliveryDate;
  final String breedingnotes;
  final bool shouldAddEvent;

  BreedingDetails({
    required this.breedsire,
    required this.breeddam,
    required this.breedpartner,
    required this.breedchildren,
    required this.breedingDate,
    required this.breeddeliveryDate,
    required this.breedingnotes,
    required this.shouldAddEvent,
  });
}

class VaccineDetails {
  final String vaccineName;
  final DateTime? firstDoseDate;
  final DateTime? secondDoseDate;

  VaccineDetails({
    required this.vaccineName,
    this.firstDoseDate,
    this.secondDoseDate,
  });
  VaccineDetails copyWith({
    String? vaccineName,
    DateTime? firstDoseDate,
    DateTime? secondDoseDate,

    // ignore: non_constant_identifier_names
  }) {
    return VaccineDetails(
      vaccineName: vaccineName ?? this.vaccineName,
      firstDoseDate: firstDoseDate ?? this.firstDoseDate,
      secondDoseDate: secondDoseDate ?? this.secondDoseDate,
    );
  }
}

class MedicalCheckupDetails {
  final String checkupName;
  final DateTime? firstDoseDate;
  final DateTime? secondDoseDate;

  MedicalCheckupDetails({
    required this.checkupName,
    required this.firstDoseDate,
    required this.secondDoseDate,
  });
  MedicalCheckupDetails copyWith({
    String? checkupName,
    DateTime? firstDoseDate,
    DateTime? secondDoseDate,
  }) {
    return MedicalCheckupDetails(
        checkupName: checkupName ?? this.checkupName,
        firstDoseDate: firstDoseDate ?? this.firstDoseDate,
        secondDoseDate: secondDoseDate ?? this.secondDoseDate);
  }
}

class SurgeryDetails {
  final String surgeryName;
  final DateTime? firstDoseDate;
  final DateTime? secondDoseDate;

  SurgeryDetails({
    required this.surgeryName,
    required this.firstDoseDate,
    required this.secondDoseDate,
  });
  SurgeryDetails copyWith({
    String? surgeryName,
    DateTime? firstDoseDate,
    DateTime? secondDoseDate,
  }) {
    return SurgeryDetails(
        surgeryName: surgeryName ?? this.surgeryName,
        firstDoseDate: firstDoseDate ?? this.firstDoseDate,
        secondDoseDate: secondDoseDate ?? this.secondDoseDate);
  }
}
