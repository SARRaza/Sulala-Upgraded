class ReminderItem {
  final int? id;
  final int animalId;
  final String animalNames;
  final String dateInfo;
  final String dateType;

  ReminderItem(
      {this.id,
      required this.animalId,
      required this.animalNames,
      required this.dateType,
      required this.dateInfo});
}
