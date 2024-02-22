import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/breeding_event_variables.dart';
import '../riverpod_globals.dart';

final breedingEventListProvider =
    AsyncNotifierProvider.family<BreedingEventList, List<BreedingEventVariables>, int>(
        BreedingEventList.new);

class BreedingEventList extends FamilyAsyncNotifier<List<BreedingEventVariables>, int> {
  @override
  FutureOr<List<BreedingEventVariables>> build(int arg) {
    return [];
  }

  Future<void> addEvent(BreedingEventVariables eventDetails) async {
    final events = List<BreedingEventVariables>.from(state.value ?? []);
    final newEvent = eventDetails.copyWith(id: generateRandomId(6));
    events.add(newEvent);
    state = AsyncData(events);
    final partnerId = newEvent.partner?.animalId;
    if(partnerId != null && partnerId != arg) {
      ref.read(breedingEventListProvider(partnerId).notifier)
          .addEvent(newEvent);
    }
  }

  Future<void> updateEvent(BreedingEventVariables eventDetails) async {
    final events = List<BreedingEventVariables>.from(state.value!);
    final eventIndex =
        events.indexWhere((event) => event.id == eventDetails.id);
    events[eventIndex] = eventDetails;
    state = AsyncData(events);
    final partnerId = eventDetails.partner?.animalId;
    if(partnerId != null && partnerId != arg) {
      ref.read(breedingEventListProvider(partnerId).notifier).updateEvent(
          eventDetails);
    }
  }

  Future<void> removeEvent(int id) async {
    final events = List<BreedingEventVariables>.from(state.value!);
    final eventDetails = events.firstWhere((event) => event.id == id);
    final partnerId = eventDetails.partner?.animalId;
    if(partnerId != null && partnerId != arg) {
      ref.read(breedingEventListProvider(partnerId).notifier).removeEvent(id);
    }
    events.removeWhere((event) => event.id == id);
    state = AsyncData(events);
  }
}
