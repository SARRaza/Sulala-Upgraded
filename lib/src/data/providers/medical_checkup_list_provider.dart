import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/data/classes/medical_checkup_details.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';

final medicalCheckupListProvider =
    AsyncNotifierProvider.family<MedicalCheckupList, List<MedicalCheckupDetails>, String>(
        MedicalCheckupList.new);

class MedicalCheckupList extends FamilyAsyncNotifier<List<MedicalCheckupDetails>, String> {
  @override
  FutureOr<List<MedicalCheckupDetails>> build(String arg) {
    return [];
  }

  Future<void> addCheckup(MedicalCheckupDetails checkupDetails) async {
    final checkups = List<MedicalCheckupDetails>.from(state.value ?? []);
    final newCheckup = checkupDetails.copyWith(id: generateRandomId(6));
    checkups.add(newCheckup);
    state = AsyncData(checkups);
  }

  Future<void> updateCheckup(MedicalCheckupDetails checkupDetails) async {
    final checkups = List<MedicalCheckupDetails>.from(state.value!);
    final checkupIndex =
        checkups.indexWhere((checkup) => checkup.id == checkupDetails.id);
    checkups[checkupIndex] = checkupDetails;
    state = AsyncData(checkups);
  }

  Future<void> removeCheckup(String id) async {
    final checkups = List<MedicalCheckupDetails>.from(state.value!);
    checkups.removeWhere((checkup) => checkup.id == id);
    state = AsyncData(checkups);
  }
}
