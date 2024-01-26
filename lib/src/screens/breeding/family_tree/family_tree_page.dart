// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/classes.dart';
import 'package:sulala_upgrade/src/screens/breeding/create_breeding_event.dart';

import '../../../data/riverpod_globals.dart';
import '../../../widgets/animal_info_modal_sheets.dart/animal_children_modal.dart';
import '../../../widgets/animal_info_modal_sheets.dart/animal_dam_modal.dart';
import '../../../widgets/animal_info_modal_sheets.dart/animal_sire_modal.dart';
import 'family_tree_item.dart';
import 'family_tree_node.dart';
import 'graph_painter.dart';

enum BranchType { parents, children }

class FamilyTreePage extends ConsumerStatefulWidget {
  const FamilyTreePage(
      {super.key,
      required this.selectedAnimalId});

  final int selectedAnimalId;

  @override
  ConsumerState<FamilyTreePage> createState() => _FamilyTreePageState();
}

class _FamilyTreePageState extends ConsumerState<FamilyTreePage> {
  late OviVariables _selectedAnimal;
  Widget? graph;
  GlobalKey stackKey = GlobalKey();
  late FamilyTreeNode root;
  late List<OviVariables> animals;
  Set<String> addedChildIds = {};

  @override
  void initState() {
    animals = ref.read(ovianimalsProvider);

    _selectedAnimal =
        animals.firstWhere((member) => member.id == widget.selectedAnimalId);


    root = createTree(_selectedAnimal, attachParents: true,
        attachChildren: true);

    super.initState();
  }

  FamilyTreeNode createTree(OviVariables? nodeAnimal, {bool attachParents = false, bool attachChildren = false}) {
    final List<FamilyTreeNode> parents = [];
    List<FamilyTreeNode> children = [];
    if(attachParents && nodeAnimal != null) {
      final father = animals.firstWhereOrNull(
              (animal) => animal.id == nodeAnimal.selectedOviSire?.id);

      if(father != null || nodeAnimal.id == _selectedAnimal.id) {
        final fatherNode = createTree(father, attachParents: true);
        parents.add(fatherNode);
      }

      final mother = animals.firstWhereOrNull(
              (animal) => animal.id == nodeAnimal.selectedOviDam?.id);

      if(mother != null || nodeAnimal.id == _selectedAnimal.id) {
        final motherNode = createTree(mother, attachParents: true);
        parents.add(motherNode);
      }
    }
    if(attachChildren && nodeAnimal != null) {
      children = animals.where((animal) => animal.selectedOviSire?.id ==
          nodeAnimal.id || animal.selectedOviDam?.id == nodeAnimal.id).map(
              (animal) => createTree(animal, attachChildren: true)).toList();
      if(nodeAnimal.id == _selectedAnimal.id) {
        children.add(FamilyTreeNode(animal: null, parents: [], children: []));
      }
    }
    final node = FamilyTreeNode(animal: nodeAnimal, parents: parents,
        children: children);

    return node;
  }

  @override
  Widget build(BuildContext context) {
    for (var parent in root.parents) {
      if (parent.animal != null) {
        parent.expanded = true;
      }
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 52),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x28D8D9DA),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  height: 52,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF7F6F6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  width: 24,
                                  height: 24,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: Image.asset(
                                      'assets/avatars/48px/arrow-left.png')),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 247,
                        child: Text(
                          '${_selectedAnimal.animalName}’s Family Tree',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF14181F),
                            fontSize: 16,
                            fontFamily: 'IBM Plex Sans',
                            fontWeight: FontWeight.w500,
                            height: 0.09,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(double.infinity),
        child: Center(
          child: FittedBox(
            fit: BoxFit.cover,
            child: Column(
              children: [
                buildTree(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTree() {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Stack(
          key: stackKey,
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: GraphPainter(root, stackKey),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 20),
              constraints:
                  BoxConstraints(minWidth: MediaQuery.of(context).size.width),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (root.parents.isNotEmpty)
                    buildParentsBranch(root.parents,
                        itemMargin: const EdgeInsets.symmetric(horizontal: 52)),
                  FamilyTreeItem(
                    node: root,
                    selected: true,
                    showGender: true,
                    key: root.key,
                  ),
                  if (root.children.isNotEmpty)
                    buildChildrenBranch(root.children)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildParentsBranch(List<FamilyTreeNode> nodes,
      {EdgeInsets itemMargin = const EdgeInsets.symmetric(horizontal: 7.5)}) {

    final parentItems = <Widget>[];
    for(var i=0; i < 2; i++) {
      final node = nodes[i];
      parentItems.add(Column(
        children: [
          if (node.expanded && node.parents.isNotEmpty)
            buildParentsBranch(node.parents),
          FamilyTreeItem(
            margin: itemMargin,
            node: node,
            showGender: true,
            key: node.key,
            onTap: (ItemType itemType) =>
                handleTap(itemType, node, BranchType.parents, gender: i == 0
                    ? 'Male' : 'Female'),
          ),
        ],
      ));
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: nodes.any((node) => node.expanded)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: parentItems
        ),
        const SizedBox(
          height: 96,
        ),
      ],
    );
  }

  Widget buildChildrenBranch(List<FamilyTreeNode> nodes) {
    return Column(
      children: [
        const SizedBox(
          height: 96,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: nodes
              .map((node) => Column(
                    children: [
                      FamilyTreeItem(
                          node: node,
                          showGender: false,
                          key: node.key,
                          onTap: (ItemType itemType) =>
                              handleTap(itemType, node, BranchType.children)),
                      if (node.expanded && node.children.isNotEmpty)
                        buildChildrenBranch(node.children)
                    ],
                  ))
              .toList(),
        ),
      ],
    );
  }

  void handleTap(
      ItemType itemType, FamilyTreeNode node, BranchType branchType, {String? gender}) {
    if (itemType == ItemType.expandButton) {
      if (node.animal == null && branchType == BranchType.parents) {
        addParent(gender!);
      } else if (node.animal == null && branchType == BranchType.children) {
        addChildren();
      } else {
        setState(() {
          node.expanded = true;
        });
      }
    } else {
      selectAnimal(node.animal!.id);
    }
  }

  void selectAnimal(int id) {
    setState(() {
      _selectedAnimal = animals.firstWhere((member) => member.id == id);
      root = createTree(_selectedAnimal, attachParents: true,
          attachChildren: true);
    });
  }

  Future<void> addParent(String gender) async {
    final selectedAnimal = ref
        .read(ovianimalsProvider)
        .firstWhere((animal) => animal.id == _selectedAnimal.id);
    final ovianimals = ref.watch(ovianimalsProvider);
    List<MainAnimalSire> selectedSire = [];
    List<MainAnimalDam> selectedDam = [];

    final selectedPersonIndex =
        animals.indexWhere((person) => person.id == _selectedAnimal.id);

    final fatherDetails = ref.read(ovianimalsProvider).firstWhereOrNull((animal
        ) => selectedAnimal.selectedOviSire != null && animal.id ==
        selectedAnimal.selectedOviSire!.id);
    var selectedFather = fatherDetails != null ? MainAnimalSire(fatherDetails
        .animalName, fatherDetails.selectedOviImage, 'Male') : null;
    final motherDetails = ref.read(ovianimalsProvider).firstWhereOrNull((animal
        ) => selectedAnimal.selectedOviDam != null && animal.id ==
        selectedAnimal.selectedOviDam!.id);
    var selectedMother = motherDetails != null ? MainAnimalDam(motherDetails
        .animalName, motherDetails.selectedOviImage, 'Female') : null;

    final selectedChildren = <BreedChildItem>[];
    for (var node in root.children) {
      if(node.animal != null) {
        selectedChildren.add(BreedChildItem(node.animal!.animalName, node.animal!
            .selectedOviImage, node.animal!.selectedOviGender));
      }
    }

    if (gender == 'Male') {
      selectedFather = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        showDragHandle: false,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AnimalSireModal(selectedAnimal: selectedAnimal,
            selectedFather: selectedFather, selectedMother: selectedMother,
            selectedChildren: selectedChildren,);
        },
      );
      if(selectedFather != null) {
        selectedAnimal.selectedOviSire = selectedFather;
        animals[selectedPersonIndex] = animals[selectedPersonIndex].copyWith(
            selectedOviSire: selectedFather);
      }

    } else if (gender == 'Female') {
      selectedMother = await showModalBottomSheet(
        context: context,
        showDragHandle: false,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AnimalDamModal(
              selectedFather: selectedFather,
              selectedMother: selectedMother,
              selectedAnimal: selectedAnimal,
              selectedChildren: selectedChildren,
          );
        },
      );

      if(selectedMother != null) {
        selectedAnimal.selectedOviDam = selectedMother;
        animals[selectedPersonIndex] = animals[selectedPersonIndex].copyWith(
            selectedOviDam: selectedMother);
      }
    }

    ref.read(ovianimalsProvider.notifier).update((state) {
      final index = state
          .indexWhere((animal) => animal.animalName == selectedAnimal.animalName);
      state[index] = selectedAnimal;
      return state;
    });
    setState(() {
      root = createTree(_selectedAnimal, attachParents: true,
          attachChildren: true);
    });
  }

  Future<void> addChildren() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) =>
        CreateBreedingEvents(OviDetails: _selectedAnimal,
            breedingEvents: const [])));
    setState(() {
      animals = ref.read(ovianimalsProvider);
      root = createTree(_selectedAnimal, attachParents: true,
          attachChildren: true);
    });
  }
}
