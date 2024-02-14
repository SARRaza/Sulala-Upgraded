import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/data/classes/surgery_details.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';

final surgeryListProvider =
    AsyncNotifierProvider.family<SurgeryList, List<SurgeryDetails>, String>(
        SurgeryList.new);

class SurgeryList extends FamilyAsyncNotifier<List<SurgeryDetails>, String> {
  @override
  FutureOr<List<SurgeryDetails>> build(String arg) {
    return [];
  }

  Future<void> addSurgery(SurgeryDetails surgeryDetails) async {
    final surgeries = List<SurgeryDetails>.from(state.value ?? []);
    final newSurgery = surgeryDetails.copyWith(id: generateRandomId(6));
    surgeries.add(newSurgery);
  }

  Future<void> updateSurgery(SurgeryDetails surgeryDetails) async {
    final surgeries = List<SurgeryDetails>.from(state.value!);
    final index =
        surgeries.indexWhere((surgery) => surgery.id == surgeryDetails.id);
    surgeries[index] = surgeryDetails;
    state = AsyncData(surgeries);
  }

  Future<void> removeSurgery(String id) async {
    final surgeries = List<SurgeryDetails>.from(state.value!);
    surgeries.removeWhere((surgery) => surgery.id == id);
    state = AsyncData(surgeries);
  }
}
