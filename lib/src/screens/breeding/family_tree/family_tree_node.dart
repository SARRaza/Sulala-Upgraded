import 'package:flutter/material.dart';

import 'person.dart';

class FamilyTreeNode {
  final Person? person;
  final List<FamilyTreeNode> parents;
  final List<FamilyTreeNode> children;
  final GlobalKey key = GlobalKey();
  bool expanded = false;

  FamilyTreeNode(
      {required this.person, required this.parents, required this.children});
}
