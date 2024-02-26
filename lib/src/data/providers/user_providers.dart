import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/staff_member.dart';

final staffProvider = AsyncNotifierProvider<StaffList, List<StaffMember>>(StaffList.new);

class StaffList extends AsyncNotifier<List<StaffMember>> {
  @override
  FutureOr<List<StaffMember>> build() {
    return [
      StaffMember(
          id: 1,
          image: const AssetImage('assets/avatars/120px/Staff1.png'),
          name: 'Paul Rivera',
          role: 'Viewer',
          email: 'paul@example.com',
          phoneNumber: '+1 234 567 890',
          address: 'United Arab Emirates'),
      StaffMember(
          id: 2,
          image: const AssetImage('assets/avatars/120px/Staff2.png'),
          name: 'Rebecca Wilson',
          role: 'Helper',
          email: 'paul@example.com',
          phoneNumber: '+1 234 567 890',
          address: 'United Arab Emirates'),
    ];
  }

  Future<void> addMember(StaffMember memberDetails) async {
    final members = List<StaffMember>.from(state.value ?? []);
    final newMember = memberDetails.copyWith();
    members.add(newMember);
    state = AsyncData(members);
  }

  Future<void> updateMember(StaffMember memberDetails) async {
    final members = List<StaffMember>.from(state.value!);
    final memberIndex = members.indexWhere((member) => member.id ==
        memberDetails.id);
    members[memberIndex] = memberDetails;
    state = AsyncData(members);
  }

  Future<void> removeMember(int id) async {
    final members = List<StaffMember>.from(state.value!);
    members.removeWhere((member) => member.id == id);
    state = AsyncData(members);
  }

}

final totalStaffProvider = Provider<int>((ref) {
  final staff = ref.watch(staffProvider);
  return staff.hasValue ? staff.value!.length : 0;
});

final staffMemberProvider = FutureProvider.autoDispose.family<StaffMember, int>((ref, id) async {
  final staff = await ref.watch(staffProvider.future);
  return staff.firstWhere((member) => member.id == id);
});

final collaborationRequestsProvider =
StateProvider<List<StaffMember>>((ref) => [
  StaffMember(
      id: 3,
      image: const AssetImage('assets/avatars/120px/Staff3.png'),
      name: 'Patricia Williams',
      role: 'Viewer',
      email: 'paul@example.com',
      phoneNumber: '+1 234 567 890',
      address: 'United Arab Emirates'),
  StaffMember(
      id: 4,
      image: const AssetImage('assets/avatars/120px/Staff1.png'),
      name: 'Scott Simmons',
      role: 'Viewer',
      email: 'paul@example.com',
      phoneNumber: '+1 234 567 890',
      address: 'United Arab Emirates'),
  StaffMember(
      id: 5,
      image: const AssetImage('assets/avatars/120px/Staff2.png'),
      name: 'Lee Hall',
      role: 'Viewer',
      email: 'paul@example.com',
      phoneNumber: '+1 234 567 890',
      address: 'United Arab Emirates'),
]);