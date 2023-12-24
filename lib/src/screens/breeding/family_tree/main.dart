// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/data/classes.dart';

import '../../../data/riverpod_globals.dart';
import 'family_tree_item.dart';
import 'family_tree_node.dart';
import 'graph_painter.dart';
import 'person.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//             seedColor: Colors.deepPurple, background: Colors.white),
//         useMaterial3: true,
//       ),
//       home: FamilyTreePage(
//         members: [
//           Person(
//             id: 100001,
//             name: 'Harry',
//             image: const AssetImage('images/harry.jpg'),
//             status: 'Borrowed',
//             gender: Gender.male,
//             fatherId: 100002,
//             motherId: 100004,
//           ),
//           Person(
//               id: 100002,
//               name: 'Rocky',
//               image: const AssetImage('images/rocky.jpg'),
//               gender: Gender.male,
//               fatherId: 100003,
//               motherId: 100009,
//               status: 'Borrowed'),
//           Person(
//               id: 100003,
//               name: 'Mustang',
//               gender: Gender.male,
//               image: const AssetImage('images/mustang.jpg'),
//               status: 'Dead'),
//           Person(
//               id: 100011,
//               name: 'Frank',
//               gender: Gender.female,
//               image: const AssetImage('images/mustang.jpg'),
//               status: 'Dead'),
//           Person(
//             id: 100004,
//             name: 'Bella',
//             image: const AssetImage('images/harry.jpg'),
//             gender: Gender.female,
//             status: 'Sold',
//             fatherId: 100010,
//             motherId: 100011,
//           ),
//           Person(
//               id: 100005,
//               name: 'Harry Jr.',
//               image: const AssetImage('images/harry.jpg'),
//               status: 'Borrowed',
//               gender: Gender.male,
//               fatherId: 100001),
//           Person(
//               id: 100006,
//               name: 'Harry Junior',
//               image: const AssetImage('images/harry.jpg'),
//               gender: Gender.male,
//               status: 'Borrowed',
//               fatherId: 100001),
//           Person(
//               id: 100007,
//               name: 'Tom',
//               gender: Gender.male,
//               image: const AssetImage('images/harry.jpg'),
//               status: 'Borrowed',
//               fatherId: 100001),
//           Person(
//               id: 100008,
//               name: 'Ruben',
//               gender: Gender.male,
//               image: const AssetImage('images/harry.jpg'),
//               status: 'Borrowed',
//               fatherId: 100001),
//           Person(
//               id: 100009,
//               name: 'Shirley',
//               gender: Gender.female,
//               image: const AssetImage('images/harry.jpg'),
//               status: 'Dead'),
//           Person(
//               id: 100010,
//               name: 'Tom',
//               gender: Gender.male,
//               image: const AssetImage('images/tom.jpg'),
//               status: 'Sold'),
//           Person(
//               id: 100013,
//               name: 'Jerry',
//               gender: Gender.male,
//               image: const AssetImage('images/harry.jpg'),
//               status: 'Borrowed',
//               fatherId: 100005),
//           Person(
//               id: 100014,
//               name: 'Carry',
//               gender: Gender.male,
//               image: const AssetImage('images/harry.jpg'),
//               status: 'Borrowed',
//               fatherId: 100005),
//           Person(
//               id: 100015,
//               name: 'Jacky',
//               gender: Gender.male,
//               image: const AssetImage('images/harry.jpg'),
//               status: 'Borrowed',
//               fatherId: 100006),
//           Person(
//               id: 100016,
//               name: 'Jessy',
//               gender: Gender.male,
//               image: const AssetImage('images/harry.jpg'),
//               status: 'Borrowed',
//               fatherId: 100006),
//           Person(
//               id: 100017,
//               name: 'Jessy',
//               gender: Gender.male,
//               image: const AssetImage('images/harry.jpg'),
//               status: 'Borrowed',
//               fatherId: 100007),
//           Person(
//               id: 100018,
//               name: 'Sweety',
//               gender: Gender.male,
//               image: const AssetImage('images/harry.jpg'),
//               status: 'Borrowed',
//               fatherId: 100007),
//           Person(
//               id: 100019,
//               name: 'Cassy',
//               gender: Gender.male,
//               image: const AssetImage('images/harry.jpg'),
//               status: 'Borrowed',
//               fatherId: 100008),
//           Person(
//               id: 100018,
//               name: 'Lewis',
//               gender: Gender.male,
//               image: const AssetImage('images/harry.jpg'),
//               status: 'Borrowed',
//               fatherId: 100008),
//         ],
//         selectedPersonId: 100001, OviDetails: wid,
//       ),
//     );
//   }
// }

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
  Set<String> addedChildIds = {};
  @override
  void initState() {
    _selectedPerson = widget.members
        .firstWhere((member) => member.id == widget.selectedPersonId);
    root = createTree(widget.members, _selectedPerson,
        attachParents: true, attachChildren: true);

    super.initState();
  }

  FamilyTreeNode createTree(List<Person> members, Person person,
      {bool attachParents = false, bool attachChildren = false}) {
    final parents = <FamilyTreeNode>[];
    if (attachParents && person.fatherId != null) {
      parents.add(createTree(
          members, members.firstWhere((member) => member.id == person.fatherId),
          attachParents: true));
    }
    if (attachParents && person.motherId != null) {
      parents.add(createTree(
          members, members.firstWhere((member) => member.id == person.motherId),
          attachParents: true));
    }
    var children = <FamilyTreeNode>[];
    if (attachChildren) {
      children = members
          .where((member) =>
              member.fatherId == person.id || member.motherId == person.id)
          .map((member) => createTree(members, member, attachChildren: true))
          .toList();
    }

    final node =
        FamilyTreeNode(person: person, parents: parents, children: children);

    return node;
  }

  @override
  Widget build(BuildContext context) {
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add a person to the children branch dynamically
      //     addPersonToChildrenBranch();
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }

  // Widget addPersonToChildrenBranch() {
  //   final animalIndex = ref.read(ovianimalsProvider).indexWhere(
  //         (animal) => animal.animalName == widget.OviDetails.animalName,
  //       );

  //   if (animalIndex == -1) {
  //     // Animal not found, you can show an error message or handle it accordingly
  //     return const SizedBox(); // Placeholder Widget, adjust as needed
  //   }

  //   final breedingEvents = ref
  //           .read(ovianimalsProvider)[animalIndex]
  //           .breedingEvents[widget.OviDetails.animalName] ??
  //       [];

  //   for (final breedingEvent in breedingEvents) {
  //     for (final child in breedingEvent.children) {
  //       // Check if the child ID is already added, skip if it exists
  //       if (addedChildIds.contains(child.animalName)) {
  //         continue;
  //       }

  //       final newPerson = Person(
  //         id: generateUniqueId(),
  //         name: child.animalName,
  //         gender: Gender.male,
  //         image: child.selectedOviImage != null
  //             ? FileImage(child.selectedOviImage!)
  //             : null,
  //         status: 'Borrowed',
  //         fatherId: 100001,
  //       );

  //       final newNode =
  //           createTree(widget.members, newPerson, attachChildren: true);

  //       // Update the UI to reflect the new person in the children branch
  //       setState(() {
  //         root.children.add(newNode);
  //       });

  //       // Add the child ID to the set to mark it as added
  //       addedChildIds.add(child.animalName);

  //       // Return the added FamilyTreeItem widget
  //       return FamilyTreeItem(
  //         node: newNode,
  //         showGender: false,
  //         key: newNode.key,
  //         onTap: (ItemType itemType) => handleTap(itemType, newNode),
  //       );
  //     }
  //   }

  //   // You might return a Widget or null based on your requirement
  //   return const SizedBox(); // Placeholder Widget, adjust as needed
  // }

  // // ... existing code ...

  // int generateUniqueId() {
  //   // You can implement a logic to generate a unique ID for the new person
  //   // For simplicity, you can use the current timestamp
  //   return DateTime.now().millisecondsSinceEpoch;
  // }

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
                        onTap: (ItemType itemType) => handleTap(itemType, node),
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
                              handleTap(itemType, node)),
                      if (node.expanded && node.children.isNotEmpty)
                        buildChildrenBranch(node.children)
                    ],
                  ))
              .toList(),
        ),
      ],
    );
  }

  void handleTap(ItemType itemType, FamilyTreeNode node) {
    if (itemType == ItemType.expandButton) {
      setState(() {
        node.expanded = true;
      });
    } else {
      selectPerson(node.person.id);
    }
  }

  void selectPerson(int id) {
    setState(() {
      _selectedPerson = widget.members.firstWhere((member) => member.id == id);
      root = createTree(widget.members, _selectedPerson,
          attachParents: true, attachChildren: true);

      // Clear the set of added child IDs when selecting a new person
      addedChildIds.clear();
    });
  }
}
