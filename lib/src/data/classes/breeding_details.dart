import 'breed_child_item.dart';
import 'breeding_partner.dart';

class BreedingDetails {
  final String breedSire;
  final String breedDam;
  final BreedingPartner breedPartner;
  final List<BreedChildItem> breedChildren;
  final DateTime? breedingDate;
  final DateTime? breedDeliveryDate;
  final String breedingNotes;
  final bool shouldAddEvent;

  const BreedingDetails({
    required this.breedSire,
    required this.breedDam,
    required this.breedPartner,
    required this.breedChildren,
    required this.breedingDate,
    required this.breedDeliveryDate,
    required this.breedingNotes,
    required this.shouldAddEvent,
  });
}
