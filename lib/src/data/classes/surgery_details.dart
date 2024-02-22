import 'dart:io';

class SurgeryDetails {
  final int? id;
  final String surgeryName;
  final DateTime? firstSurgery;
  final DateTime? secondSurgery;
  final List<File>? files;
  final int animalId;

  SurgeryDetails(
      {this.id,
      required this.surgeryName,
      required this.firstSurgery,
      required this.secondSurgery,
      required this.animalId,
      this.files});

  SurgeryDetails copyWith(
      {int? id,
      String? surgeryName,
      DateTime? firstSurgery,
      DateTime? secondSurgery,
      List<File>? files,
      int? animalId}) {
    return SurgeryDetails(
        id: id ?? this.id,
        surgeryName: surgeryName ?? this.surgeryName,
        firstSurgery: firstSurgery ?? this.firstSurgery,
        secondSurgery: secondSurgery ?? this.secondSurgery,
        files: files ?? this.files,
        animalId: animalId ?? this.animalId);
  }
}
