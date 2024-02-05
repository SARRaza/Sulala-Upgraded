import 'dart:io';

class MedicalCheckupDetails {
  final String checkupName;
  final DateTime? firstCheckUp;
  final DateTime? secondCheckUp;
  final List<File>? files;

  MedicalCheckupDetails(
      {required this.checkupName,
      required this.firstCheckUp,
      required this.secondCheckUp,
      this.files});
  MedicalCheckupDetails copyWith(
      {String? checkupName,
      DateTime? firstCheckUp,
      DateTime? secondCheckUp,
      List<File>? files}) {
    return MedicalCheckupDetails(
        checkupName: checkupName ?? this.checkupName,
        firstCheckUp: firstCheckUp ?? this.firstCheckUp,
        secondCheckUp: secondCheckUp ?? this.secondCheckUp,
        files: files ?? this.files);
  }
}
