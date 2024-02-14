import 'dart:io';

class VaccineDetails {
  final String? id;
  final String vaccineName;
  final DateTime? firstDoseDate;
  final DateTime? secondDoseDate;
  final List<File>? files;
  final String animalId;

  VaccineDetails(
      {this.id,
      required this.vaccineName,
      this.firstDoseDate,
      this.secondDoseDate,
      this.files,
      required this.animalId});

  VaccineDetails copyWith(
      {String? id,
      String? vaccineName,
      DateTime? firstDoseDate,
      DateTime? secondDoseDate,
      List<File>? files,
      String? animalId}) {
    return VaccineDetails(
        id: id ?? this.id,
        vaccineName: vaccineName ?? this.vaccineName,
        firstDoseDate: firstDoseDate ?? this.firstDoseDate,
        secondDoseDate: secondDoseDate ?? this.secondDoseDate,
        files: files ?? this.files,
        animalId: animalId ?? this.animalId);
  }
}
