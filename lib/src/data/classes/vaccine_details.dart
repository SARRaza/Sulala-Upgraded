import 'dart:io';

class VaccineDetails {
  final int? id;
  final String vaccineName;
  final DateTime? firstDoseDate;
  final DateTime? secondDoseDate;
  final List<File>? files;
  final int animalId;

  VaccineDetails(
      {this.id,
      required this.vaccineName,
      this.firstDoseDate,
      this.secondDoseDate,
      this.files,
      required this.animalId});

  VaccineDetails copyWith(
      {int? id,
      String? vaccineName,
      DateTime? firstDoseDate,
      DateTime? secondDoseDate,
      List<File>? files,
      int? animalId}) {
    return VaccineDetails(
        id: id ?? this.id,
        vaccineName: vaccineName ?? this.vaccineName,
        firstDoseDate: firstDoseDate ?? this.firstDoseDate,
        secondDoseDate: secondDoseDate ?? this.secondDoseDate,
        files: files ?? this.files,
        animalId: animalId ?? this.animalId);
  }
}
