import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/data/classes.dart';

class FamilyTreeNode {
  final OviVariables? animal;
  final List<FamilyTreeNode> parents;
  final List<FamilyTreeNode> children;
  final GlobalKey key = GlobalKey();
  bool expanded = false;

  FamilyTreeNode(
      {required this.animal, required this.parents, required this.children});
}
