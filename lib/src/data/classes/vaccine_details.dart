import 'dart:io';

class VaccineDetails {
  final String vaccineName;
  final DateTime? firstDoseDate;
  final DateTime? secondDoseDate;
  final List<File>? files;

  VaccineDetails(
      {required this.vaccineName,
      this.firstDoseDate,
      this.secondDoseDate,
      this.files});
  VaccineDetails copyWith(
      {String? vaccineName,
      DateTime? firstDoseDate,
      DateTime? secondDoseDate,
      List<File>? files
      // ignore: non_constant_identifier_names
      }) {
    return VaccineDetails(
        vaccineName: vaccineName ?? this.vaccineName,
        firstDoseDate: firstDoseDate ?? this.firstDoseDate,
        secondDoseDate: secondDoseDate ?? this.secondDoseDate,
        files: files ?? this.files);
  }
}
