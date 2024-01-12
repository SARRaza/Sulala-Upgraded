// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/data/classes.dart';

import '../../../data/riverpod_globals.dart';
import '../../../widgets/animal_info_modal_sheets.dart/animal_children_modal.dart';
import '../../../widgets/animal_info_modal_sheets.dart/animal_dam_modal.dart';
import '../../../widgets/animal_info_modal_sheets.dart/animal_sire_modal.dart';
import 'family_tree_item.dart';
import 'family_tree_node.dart';
import 'graph_painter.dart';
import 'person.dart';

enum BranchType { parents, children }

class FamilyTreePage extends ConsumerStatefulWidget {
  final OviVariables OviDetails;
  const FamilyTreePage(
      {super.key,
      required this.members,
      required this.OviDetails,
      required this.selectedPersonId});
  final List<Person> members;
  final int selectedPersonId;

  @override
  ConsumerState<FamilyTreePage> createState() => _FamilyTreePageState();
}

class _FamilyTreePageState extends ConsumerState<FamilyTreePage> {
  late Person _selectedPerson;
  Widget? graph;
  GlobalKey stackKey = GlobalKey();
  late FamilyTreeNode root;
  late List<Person> members;
  Set<String> addedChildIds = {};

  @override
  void initState() {
    members = widget.members;

    _selectedPerson = members
        .firstWhere((member) => member.id == widget.selectedPersonId);

    root = createTree(members, _selectedPerson,
        attachParents: true, attachChildren: true);

    super.initState();
  }

  FamilyTreeNode createTree(List<Person> members, Person person,
      {bool attachParents = false, bool attachChildren = false}) {
    final parents = <FamilyTreeNode>[];
    if (attachParents) {
      final fatherNode = person.fatherId != null ? createTree(
          members, members.firstWhere((member) => member.id == person.fatherId),
          attachParents: true) : person.id == _selectedPerson.id ?
      FamilyTreeNode(person: Person(id: 0,
          name: 'ADD', gender: Gender.male), parents: [], children: []) : null;
      if(fatherNode != null) {
        parents.add(fatherNode);
      }


      final motherNode = person.motherId != null ? createTree(
          members, members.firstWhere((member) => member.id == person.motherId),
          attachParents: true) : person.id == _selectedPerson.id ?
      FamilyTreeNode(person: Person(id: 0,
          name: 'ADD', gender: Gender.female), parents: [], children: []) :
      null;
      if(motherNode != null) {
        parents.add(motherNode);
      }
    }
    var children = <FamilyTreeNode>[];
    if (attachChildren) {
      children = members
          .where((member) =>
              member.fatherId == person.id || member.motherId == person.id)
          .map((member) => createTree(members, member, attachChildren: true))
          .toList();
    }
    if(person.id == _selectedPerson.id) {
      final newChildNode = FamilyTreeNode(person: Person(id: 0, name: 'ADD',
          gender: Gender.male), children: [], parents: []);
      children.add(newChildNode);
    }

    final node =
        FamilyTreeNode(person: person, parents: parents, children: children);

    return node;
  }

  @override
  Widget build(BuildContext context) {
    for (var parent in root.parents) {
      if(parent.person.id != 0) {
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
                          '${_selectedPerson.name}’s Family Tree',
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: nodes.any((node) => node.expanded)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: nodes
              .map((node) => Column(
                    children: [
                      if (node.expanded && node.parents.isNotEmpty)
                        buildParentsBranch(node.parents),
                      FamilyTreeItem(
                        margin: itemMargin,
                        node: node,
                        showGender: true,
                        key: node.key,
                        onTap: (ItemType itemType) => handleTap(itemType, node,
                            BranchType.parents),
                      ),
                    ],
                  ))
              .toList(),
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

  void handleTap(ItemType itemType, FamilyTreeNode node, BranchType branchType)
  {
    if (itemType == ItemType.expandButton) {
      if(node.person.id == 0 && branchType == BranchType.parents) {
        addParent(node.person.gender);
      } else if(node.person.id == 0 && branchType == BranchType.children) {
        addChildren();
      } else {
        setState(() {
          node.expanded = true;
        });
      }
    } else {
      selectPerson(node.person.id);
    }
  }

  void selectPerson(int id) {
    setState(() {
      _selectedPerson = widget.members.firstWhere((member) => member.id == id);
      root = createTree(widget.members, _selectedPerson,
          attachParents: true, attachChildren: true);
    });
  }

  Future<void> addParent(Gender gender) async {
    final ovianimals = ref.watch(ovianimalsProvider).where((animal) => animal.id
        != _selectedPerson.id).toList();
    final selectedFather = <MainAnimalSire>[];
    final selectedMother = <MainAnimalDam>[];
    List<MainAnimalSire> selectedSire = [];
    List<MainAnimalDam> selectedDam = [];
    final oviDetails = widget.OviDetails;

    final selectedPersonIndex = members.indexWhere((person) => person.id ==
        _selectedPerson.id);

    if(gender == Gender.male) {
      await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        showDragHandle: false,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AnimalSireModal(
              ovianimals: ovianimals,
              selectedSire: selectedSire,
              selectedFather: selectedFather,
              selectedMother: selectedMother,
              ref: ref,
              selectedDam: selectedDam);
        },
      );
      final selectedOviSire = ref.read(animalSireDetailsProvider).first;
      oviDetails.selectedOviSire[0] = selectedOviSire;
      members[selectedPersonIndex].fatherId = _selectedPerson.fatherId =
          selectedOviSire.id;
    } else if(gender == Gender.female) {
      await showModalBottomSheet(
        context: context,
        showDragHandle: false,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AnimalDamModal(
              ovianimals: ovianimals,
              selectedDam: selectedDam,
              selectedFather: selectedFather,
              selectedMother: selectedMother,
              ref: ref);
        },
      );
      final selectedOviDam = ref.read(animalDamDetailsProvider).first;
      oviDetails.selectedOviDam[0] = selectedOviDam;
      members[selectedPersonIndex].motherId = _selectedPerson.motherId =
          selectedOviDam.id;
    }

    ref.read(ovianimalsProvider.notifier).update((state) {
      final index = state.indexWhere((animal) => animal.animalName == oviDetails.animalName);
      state[index] = oviDetails;
      return state;
    });
    setState(() {
      root = createTree(members, _selectedPerson,
          attachParents: true, attachChildren: true);
    });
  }

  Future<void> addChildren() async {
    final ovianimals = ref.read(ovianimalsProvider).where((animal) => animal.id
        != _selectedPerson.id).toList();
    final selectedChildren = <BreedChildItem>[];
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: false,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimalChildrenModal(ovianimals: ovianimals,
            selectedChildren: selectedChildren, ref: ref);

      },
    );
    final breedingChildrenDetails = ref.read(breedingChildrenDetailsProvider);

    setState(() {
      for (var child in breedingChildrenDetails) {
        final selectedPersonIndex = ovianimals.indexWhere((animal) => animal.id ==
            _selectedPerson.id);
        final childIndex = ovianimals.indexWhere(
                (animal) => animal.id == child.id);
        final childMemberIndex = members.indexWhere((member) => member.id ==
            child.id);
        ref.read(ovianimalsProvider.notifier).update((state) {
          final selectedPerson = state[selectedPersonIndex];
          if(selectedPerson.selectedOviGender == 'Male') {
            state[childIndex].selectedOviSire = [MainAnimalSire(selectedPerson
                .animalName, selectedPerson.selectedOviImage, selectedPerson
                .selectedOviGender)];
            members[childMemberIndex].fatherId = _selectedPerson.id;
          } else {
            state[childIndex].selectedOviDam = [MainAnimalDam(selectedPerson
                .animalName, selectedPerson.selectedOviImage, selectedPerson
                .selectedOviGender)];
            members[childMemberIndex].motherId = _selectedPerson.id;
          }
          return state;
        });
      }
      root = createTree(members, _selectedPerson,
          attachParents: true, attachChildren: true);
      ref.read(breedingChildrenDetailsProvider.notifier).update((state) => []);
    });

  }
}
