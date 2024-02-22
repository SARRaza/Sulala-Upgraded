import 'dart:io';

class MedicalCheckupDetails {
  final int? id;
  final String checkupName;
  final DateTime? firstCheckUp;
  final DateTime? secondCheckUp;
  final List<File>? files;
  final int animalId;

  MedicalCheckupDetails(
      {this.id,
      required this.checkupName,
      required this.firstCheckUp,
      required this.secondCheckUp,
      required this.animalId,
      this.files});

  MedicalCheckupDetails copyWith(
      {int? id,
      String? checkupName,
      DateTime? firstCheckUp,
      DateTime? secondCheckUp,
      List<File>? files,
      int? animalId}) {
    return MedicalCheckupDetails(
        id: id ?? this.id,
        checkupName: checkupName ?? this.checkupName,
        firstCheckUp: firstCheckUp ?? this.firstCheckUp,
        secondCheckUp: secondCheckUp ?? this.secondCheckUp,
        files: files ?? this.files,
        animalId: animalId ?? this.animalId);
  }
}
