import 'package:flutter/material.dart';

class Person {
  final int id;
  int? fatherId;
  int? motherId;
  final String name;
  ImageProvider? image;
  String status;
  final Gender gender;

  Person(
      {required this.id,
      this.fatherId,
      this.motherId,
      required this.name,
      this.image,
      this.status = '',
      required this.gender});
}

enum Gender { male, female }
