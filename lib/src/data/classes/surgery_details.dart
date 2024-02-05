import 'dart:io';

class SurgeryDetails {
  final String surgeryName;
  final DateTime? firstSurgery;
  final DateTime? secondSurgery;
  final List<File>? files;

  SurgeryDetails(
      {required this.surgeryName,
      required this.firstSurgery,
      required this.secondSurgery,
      this.files});
  SurgeryDetails copyWith(
      {String? surgeryName,
      DateTime? firstSurgery,
      DateTime? secondSurgery,
      List<File>? files}) {
    return SurgeryDetails(
        surgeryName: surgeryName ?? this.surgeryName,
        firstSurgery: firstSurgery ?? this.firstSurgery,
        secondSurgery: secondSurgery ?? this.secondSurgery,
        files: files ?? this.files);
  }
}
