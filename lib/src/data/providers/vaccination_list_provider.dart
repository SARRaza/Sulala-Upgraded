import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';

import '../classes/vaccine_details.dart';

final vaccinationListProvider =
    AsyncNotifierProvider.family<VaccinationList, List<VaccineDetails>, int>(
        VaccinationList.new);

class VaccinationList
    extends FamilyAsyncNotifier<List<VaccineDetails>, int> {
  @override
  FutureOr<List<VaccineDetails>> build(int arg) {
    return [];
  }

  Future<void> addVaccination(VaccineDetails vaccinationDetails) async {
    final vaccinations = List<VaccineDetails>.from(state.value ?? []);
    final newVaccination = vaccinationDetails.copyWith(id: generateRandomId(6));
    vaccinations.add(newVaccination);
    state = AsyncData(vaccinations);
  }

  Future<void> updateVaccination(VaccineDetails vaccinationDetails) async {
    final vaccinations = List<VaccineDetails>.from(state.value!);
    final vaccinationIndex = vaccinations
        .indexWhere((vaccination) => vaccination.id == vaccinationDetails.id);
    vaccinations[vaccinationIndex] = vaccinationDetails;
    state = AsyncData(vaccinations);
  }

  Future<void> removeVaccination(int id) async {
    final vaccinations = List<VaccineDetails>.from(state.value!);
    vaccinations.removeWhere((vaccination) => vaccination.id == id);
    state = AsyncData(vaccinations);
  }
}
