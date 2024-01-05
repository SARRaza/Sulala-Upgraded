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
  File? selectedOviImage;
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
  bool? pregnant;
  int? _age;

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
    this.pregnant
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

  int get age {
    if(_age == null) {
      DateTime currentDate = DateTime.now();
      List birthDateSegments = dateOfBirth.split('/');
      if(birthDateSegments.isEmpty) {
        _age = 0;
      } else {
        DateTime birthDate = DateTime(int.parse(birthDateSegments[2]), int
            .parse(birthDateSegments[1]), int.parse(birthDateSegments[0]));
        int age = currentDate.year - birthDate.year;
        if (currentDate.month < birthDate.month ||
            (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
          age--;
        }
        _age = age;
      }
    }
    return _age!;
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

class BreedingEventVariables {
  final String eventNumber;
  final String sire;
  final String dam;
  final List<BreedingPartner> partner;
  final List<BreedChildItem> children;
  final File? breeddam;
  final String breedingDate;
  final String? deliveryDate;
  final String? layingEggsDate;
  final int? eggsNumber;
  final String? incubationDate;
  final String? hatchingDate;
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
    this.deliveryDate,
    required this.notes,
    required this.shouldAddEvent,
    this.layingEggsDate, this.eggsNumber, this.incubationDate, this.hatchingDate
  });
  BreedingEventVariables copyWith({
    String? eventNumber,
    String? sire,
    String? dam,
    List<BreedingPartner>? partner,
    List<BreedChildItem>? children,
    File? breeddam,
    String? breedingDate,
    String? deliveryDate,
    String? notes,

    // ignore: non_constant_identifier_names
  }) {
    return BreedingEventVariables(
      eventNumber: eventNumber ?? this.eventNumber,
      sire: sire ?? this.sire,
      dam: dam ?? this.dam,
      partner: partner ?? this.partner,
      children: children ?? this.children,
      breedingDate: breedingDate ?? this.breedingDate,
      breeddam: breeddam ?? this.breeddam,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      notes: notes ?? this.notes,
      shouldAddEvent: shouldAddEvent,
    );
  }
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
  final DateTime? firstCheckUp;
  final DateTime? secondCheckUp;

  MedicalCheckupDetails({
    required this.checkupName,
    required this.firstCheckUp,
    required this.secondCheckUp,
  });
  MedicalCheckupDetails copyWith({
    String? checkupName,
    DateTime? firstCheckUp,
    DateTime? secondCheckUp,
  }) {
    return MedicalCheckupDetails(
        checkupName: checkupName ?? this.checkupName,
        firstCheckUp: firstCheckUp ?? this.firstCheckUp,
        secondCheckUp: secondCheckUp ?? this.secondCheckUp);
  }
}

class SurgeryDetails {
  final String surgeryName;
  final DateTime? firstSurgery;
  final DateTime? secondSurgery;

  SurgeryDetails({
    required this.surgeryName,
    required this.firstSurgery,
    required this.secondSurgery,
  });
  SurgeryDetails copyWith({
    String? surgeryName,
    DateTime? firstSurgery,
    DateTime? secondSurgery,
  }) {
    return SurgeryDetails(
        surgeryName: surgeryName ?? this.surgeryName,
        firstSurgery: firstSurgery ?? this.firstSurgery,
        secondSurgery: secondSurgery ?? this.secondSurgery);
  }
}
