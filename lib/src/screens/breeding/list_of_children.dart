// import 'package:flutter/material.dart';
// import 'package:sulala_upgrade/src/data/globals.dart' as globals;
// import '../../theme/colors/colors.dart';
// import '../../theme/fonts/fonts.dart';
// import '../../widgets/controls_and_buttons/buttons/primary_button.dart';

// class ListOfChildren extends StatefulWidget {
//   const ListOfChildren({super.key});

//   @override
//   State<ListOfChildren> createState() => _ListOfChildrenState();
// }

// class _ListOfChildrenState extends State<ListOfChildren> {
//   final List<Map<String, dynamic>> children = [
//     {
//       'heading': 'Breeding Event 1',
//       'date': '02.09.2023',
//       'children': [
//         {
//           'title': 'Willie',
//           'subtitle': 'Male, 0.5 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Cat.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         // Add more children for Breeding Event 1 if needed
//       ],
//     },
//     {
//       'heading': 'Breeding Event 2',
//       'date': '02.09.2023',
//       'children': [
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Horse.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Cat.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         // Add more children for Breeding Event 2 if needed
//       ],
//     },
//     {
//       'heading': 'Breeding Event 3',
//       'date': '02.09.2023',
//       'children': [
//         {
//           'title': 'Shirley',
//           'subtitle': 'Male, 0.5 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Cat.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         // Add more children for Breeding Event 3 if needed
//       ],
//     },
//     {
//       'heading': 'Breeding Event 4',
//       'date': '02.09.2023',
//       'children': [
//         {
//           'title': 'Shirley',
//           'subtitle': 'Male, 0.5 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Cat.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         // Add more children for Breeding Event 3 if needed
//       ],
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         scrolledUnderElevation: 0.0,
//         centerTitle: true,
//         title: Text(
//           'Harry',
//           style: AppFonts.headline3(color: AppColors.grayscale90),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: AppColors.grayscale10,
//             ),
//             child: IconButton(
//               icon: const Icon(
//                 Icons.arrow_back,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.only(
//             right: 16 * globals.widthMediaQuery,
//             left: 16 * globals.widthMediaQuery),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'List Of Children',
//               style: AppFonts.title3(color: AppColors.grayscale90),
//             ),
//             SizedBox(
//               height: 16 * globals.heightMediaQuery,
//             ),
//             Expanded(
//               child: children.isEmpty
//                   ? Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             height: 151 * globals.heightMediaQuery,
//                           ),
//                           Image.asset('assets/illustrations/cow_childx.png'),
//                           SizedBox(height: 32 * globals.heightMediaQuery),
//                           Text(
//                             'No Children',
//                             style: AppFonts.headline3(
//                                 color: AppColors.grayscale90),
//                           ),
//                           SizedBox(
//                             height: 8 * globals.heightMediaQuery,
//                           ),
//                           Text(
//                             "This animal doesn’t have children.",
//                             style: AppFonts.body2(color: AppColors.grayscale70),
//                           ),
//                           Text(
//                             "Add a child to see it here.",
//                             style: AppFonts.body2(color: AppColors.grayscale70),
//                           ),
//                           SizedBox(
//                             height: 125 * globals.heightMediaQuery,
//                           ),
//                           SizedBox(
//                             width: 130 * globals.widthMediaQuery,
//                             height: 52 * globals.heightMediaQuery,
//                             child: PrimaryButton(
//                               text: 'Add Children',
//                               onPressed: () {
//                                 // Implement the logic to add children here
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: children.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         final breedingEvent = children[index];

//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   breedingEvent['heading'],
//                                   style: AppFonts.caption1(
//                                       color: AppColors.grayscale80),
//                                 ),
//                                 Text(
//                                   breedingEvent['date'],
//                                   style: AppFonts.caption2(
//                                       color: AppColors.grayscale80),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 8 * globals.heightMediaQuery,
//                             ),
//                             ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: breedingEvent['children'].length,
//                               itemBuilder:
//                                   (BuildContext context, int childIndex) {
//                                 final child =
//                                     breedingEvent['children'][childIndex];

//                                 return ListTile(
//                                   contentPadding: EdgeInsets.zero,
//                                   leading: CircleAvatar(
//                                     radius: 24 * globals.widthMediaQuery,
//                                     backgroundColor: Colors.transparent,
//                                     backgroundImage:
//                                         AssetImage(child['avatarImage']),
//                                   ),
//                                   title: Text(
//                                     child['title'],
//                                     style: AppFonts.headline3(
//                                         color: AppColors.grayscale90),
//                                   ),
//                                   subtitle: Text(
//                                     child['subtitle'],
//                                     style: AppFonts.body2(
//                                         color: AppColors.grayscale70),
//                                   ),
//                                   trailing: Text(
//                                     child['trailing'],
//                                     style: AppFonts.body2(
//                                         color: AppColors.grayscale90),
//                                   ),
//                                 );
//                               },
//                             ),
//                             SizedBox(
//                               height: 16 * globals.heightMediaQuery,
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../create_animal/owned_animal_detail_reg_mode.dart';
import '../create_animal/sar_listofanimals.dart';
import 'breeding_event_detail.dart';
import 'create_breeding_event.dart';
import 'list_of_breeding_events.dart';

// class BreedingEventVariables {
//   final String eventNumber;
//   final String sire;
//   final String dam;
//   final String partner;
//   final List<breedChildItem> children;
//   final File? breeddam;
//   final String breedingDate;
//   final String deliveryDate;
//   final String notes;
//   final bool shouldAddEvent;

//   BreedingEventVariables({
//     required this.eventNumber,
//     this.breeddam,
//     required this.sire,
//     required this.dam,
//     required this.partner,
//     required this.children,
//     required this.breedingDate,
//     required this.deliveryDate,
//     required this.notes,
//     required this.shouldAddEvent,
//   });
// }

// List<BreedingEventVariables> breedingEvents = [];

class ListOfBreedingChildren extends ConsumerStatefulWidget {
  final TextEditingController breedingNotesController;
  final TextEditingController breedingEventNumberController;
  final String selectedBreedSire;
  final String selectedBreedDam;
  final String selectedBreedPartner;
  final String selectedBreedChildren;
  final String selectedBreedingDate;
  final String selectedDeliveryDate;
  final bool shouldAddBreedEvent;
  final OviVariables OviDetails;
  final List<BreedingEventVariables> breedingEvents;

  const ListOfBreedingChildren(
      {super.key,
      required this.breedingNotesController,
      required this.breedingEventNumberController,
      required this.selectedBreedSire,
      required this.selectedBreedDam,
      required this.selectedBreedPartner,
      required this.selectedBreedChildren,
      required this.selectedBreedingDate,
      required this.selectedDeliveryDate,
      required this.shouldAddBreedEvent,
      required this.OviDetails,
      required this.breedingEvents});

  @override
  ConsumerState<ListOfBreedingChildren> createState() =>
      _ListOfBreedingChildren();
}

class _ListOfBreedingChildren extends ConsumerState<ListOfBreedingChildren> {
  String filterQuery = '';
  @override
  void initState() {
    super.initState();
    // Add the initial breeding event to the list
    if (widget.shouldAddBreedEvent) {
      addBreedingEvent(ref.read(breedingEventNumberProvider));
    }
  }

  void addBreedingEvent(String eventNumber) {
    final breedingEvent = BreedingEventVariables(
      eventNumber: ref.read(breedingEventNumberProvider),
      breeddam: ref.read(breeddamPictureProvider),
      sire: ref.read(breedingSireDetailsProvider),
      dam: ref.read(breedingDamDetailsProvider),
      partner: ref.read(breedingPartnerDetailsProvider),
      children: ref.read(breedingChildrenDetailsProvider),
      breedingDate: ref.read(breedingDateProvider),
      deliveryDate: ref.read(deliveryDateProvider),
      notes: ref.read(breedingnotesProvider),
      shouldAddEvent: ref.read(shoudlAddEventProvider),
    );

    setState(() {
      if (ref.read(breedingEventsProvider).isEmpty) {
        ref.read(breedingEventsProvider).add(breedingEvent);
      } else {
        ref.read(breedingEventsProvider).insert(0, breedingEvent);
      }
      final animalIndex = ref.read(ovianimalsProvider).indexWhere(
          (animal) => animal.animalName == widget.OviDetails.animalName);

      if (animalIndex != -1) {
        ref.read(ovianimalsProvider)[animalIndex] =
            ref.read(ovianimalsProvider)[animalIndex].copyWith(breedingEvents: {
          ...ref.read(ovianimalsProvider)[animalIndex].breedingEvents,
          widget.OviDetails.animalName: [
            ...ref
                .read(ovianimalsProvider)[animalIndex]
                .breedingEvents[widget.OviDetails.animalName]!,
            breedingEvent
          ]
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final animalIndex = ref.read(ovianimalsProvider).indexWhere(
        (animal) => animal.animalName == widget.OviDetails.animalName);

    if (animalIndex == -1) {
      // Animal not found, you can show an error message or handle it accordingly
      return const Center(
        child: Text('Animal not found.'),
      );
    }

    final breedingEvents = ref
            .read(ovianimalsProvider)[animalIndex]
            .breedingEvents[widget.OviDetails.animalName] ??
        [];

    // Filter the breeding events based on the query
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.OviDetails.animalName,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.grayscale10,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OwnedAnimalDetailsRegMode(
                      OviDetails: widget.OviDetails,
                      imagePath: '',
                      title: '',
                      geninfo: '',
                      breedingEvents: widget.breedingEvents,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.grayscale10,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateBreedingEvents(
                        selectedAnimalType: '',
                        selectedAnimalSpecies: '',
                        selectedAnimalBreed: '',
                        OviDetails: widget.OviDetails,
                        breedingEvents: widget.breedingEvents,
                      ),
                    ),
                  ).then((_) {
                    // When returning from CreateBreedingEvents, add the new event
                    if (ref.read(breedingEventNumberProvider).isNotEmpty) {
                      addBreedingEvent(ref.read(breedingEventNumberProvider));
                    }
                  });
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: 16 * globals.widthMediaQuery,
          left: 16 * globals.widthMediaQuery,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Breeding History',
                style: AppFonts.title3(color: AppColors.grayscale90)),
            SizedBox(
              height: 16 * globals.heightMediaQuery,
            ),
            breedingEvents.isEmpty
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/illustrations/child_x.png'),
                          SizedBox(
                            height: 32 * globals.heightMediaQuery,
                          ),
                          Text(
                            'No Breeding Events Yet',
                            style: AppFonts.headline3(
                                color: AppColors.grayscale90),
                          ),
                          SizedBox(
                            height: 8 * globals.heightMediaQuery,
                          ),
                          Text(
                            'Add a breeding event to get started',
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                          SizedBox(
                            height: 140 * globals.heightMediaQuery,
                          ),
                          SizedBox(
                            height: 52 * globals.heightMediaQuery,
                            child: PrimaryButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateBreedingEvents(
                                      selectedAnimalType: '',
                                      selectedAnimalSpecies: '',
                                      selectedAnimalBreed: '',
                                      OviDetails: widget.OviDetails,
                                      breedingEvents: widget.breedingEvents,
                                    ),
                                  ),
                                ).then((_) {
                                  // When returning from CreateBreedingEvents, add the new event
                                  if (widget.breedingEventNumberController.text
                                      .isNotEmpty) {
                                    addBreedingEvent(widget
                                        .breedingEventNumberController.text);
                                  }
                                });
                              },
                              text: 'Add Breeding Event',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: breedingEvents.length,
                      itemBuilder: (context, index) {
                        final breedingEvent = breedingEvents[index];

                        return Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BreedingEventDetails(
                                      breedingEvents: breedingEvents,
                                      OviDetails: widget.OviDetails,
                                      breedingEvent: breedingEvent,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  breedingEvent.eventNumber.isEmpty
                                      ? const Text('New Event')
                                      : Text(
                                          breedingEvent.eventNumber,
                                          style: AppFonts.body2(
                                              color: AppColors.grayscale90),
                                        ),
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    color: AppColors.grayscale50,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                            if (breedingEvent.children.isNotEmpty)
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: breedingEvent.children.length,
                                itemBuilder: (context, index) {
                                  final child = breedingEvent.children[index];
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      radius: 24 * globals.widthMediaQuery,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: child.selectedOviImage !=
                                              null
                                          ? FileImage(child.selectedOviImage!)
                                          : null,
                                      child: child.selectedOviImage == null
                                          ? const Icon(
                                              Icons.camera_alt_outlined,
                                              size: 50,
                                              color: Colors.grey,
                                            )
                                          : null,
                                    ),
                                    title: Text(
                                      child.animalName,
                                      style: AppFonts.headline3(
                                          color: AppColors.grayscale90),
                                    ),
                                    // ignore: unnecessary_null_comparison
                                    subtitle: child.selectedOviGender.isEmpty
                                        ? Text(
                                            'Gender Not Selected',
                                            style: AppFonts.body2(
                                                color: AppColors.grayscale70),
                                          )
                                        : Text(
                                            child.selectedOviGender,
                                            style: AppFonts.body2(
                                                color: AppColors.grayscale70),
                                          ),
                                    trailing: Text(
                                      'ID #13542',
                                      style: AppFonts.body2(
                                          color: AppColors.grayscale90),
                                    ),
                                    // Add more information about the child as needed
                                    // Example: subtitle: Text('DOB: ${child.dateOfBirth}'),
                                  );
                                },
                              ),
                            const Divider(
                              height: 25,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
