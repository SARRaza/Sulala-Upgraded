import 'package:flutter/material.dart';

class StaffMember {
  final int id;
  final ImageProvider image;
  final String name;
  final String role;
  final String email;
  final String phoneNumber;

  StaffMember(
      {required this.id,
      required this.image,
      required this.name,
      required this.role,
      required this.email,
      required this.phoneNumber});

  StaffMember copyWith({
    int? id,
    ImageProvider? image,
    String? name,
    String? role,
    String? email,
    String? phoneNumber,
  }) {
    return StaffMember(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        role: role ?? this.role,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber);
  }
}
