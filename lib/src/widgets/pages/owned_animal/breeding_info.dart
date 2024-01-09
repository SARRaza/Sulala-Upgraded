// ignore_for_file: dead_code, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/classes.dart';
import '../../../data/riverpod_globals.dart';
import '../../../screens/breeding/family_tree/family_tree_page.dart';
import '../../../screens/breeding/family_tree/person.dart';
import '../../../screens/breeding/list_of_breeding_events.dart';
import '../../../screens/breeding/list_of_mates.dart';

import '../../../screens/breeding/list_of_childrens.dart';
import '../../../screens/breeding/parents_page.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../other/one_information_block.dart';
import '../../other/two_information_block.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

class BreedingInfo extends ConsumerStatefulWidget {
  final OviVariables OviDetails;
  final List<BreedingEventVariables> breedingEvents;

  const BreedingInfo(
      {Key? key, required this.OviDetails, required this.breedingEvents})
      : super(key: key);

  @override
  ConsumerState<BreedingInfo> createState() => _BreedingInfoState();
}

int _uniqueIdCounter = 1; // Initialize a counter

// Function to generate a unique ID
int generateUniqueId() {
  return DateTime.now().millisecondsSinceEpoch + (_uniqueIdCounter++);
}

class _BreedingInfoState extends ConsumerState<BreedingInfo> {
  Set<String> addedChildIds = {};
  List<Person> familyMembers = [];

  @override
  Widget build(BuildContext context) {
    // List<Person> familyMembers = [
    //   Person(
    //     id: 100001,
    //     name: widget.OviDetails.animalName,
    //     image: widget.OviDetails.selectedOviImage != null
    //         ? FileImage(widget.OviDetails.selectedOviImage!)
    //         : null,
    //     status: 'Borrowed',
    //     gender: Gender.male,
    //     fatherId: 100002,
    //     motherId: 100004,
    //   ),
    //   Person(
    //       id: 100002,
    //       name: widget.OviDetails.selectedOviSire.first.animalName,
    //       image:
    //           widget.OviDetails.selectedOviSire.first.selectedOviImage != null
    //               ? FileImage(
    //                   widget.OviDetails.selectedOviSire.first.selectedOviImage!)
    //               : null,
    //       gender: Gender.male,
    //       fatherId: 100003,
    //       motherId: 100009,
    //       status: 'Borrowed'),
    //   Person(
    //     id: 100003,
    //     name: widget.OviDetails.selectedOviSire.first.father?.animalName ??
    //         'Unknown',
    //     gender: Gender.male,
    //     image:
    //         widget.OviDetails.selectedOviSire.first.father?.selectedOviImage !=
    //                 null
    //             ? FileImage(widget
    //                 .OviDetails.selectedOviSire.first.father!.selectedOviImage!)
    //             : null,
    //     status: 'Dead',
    //   ),
    //   Person(
    //       id: 100011,
    //       name: widget.OviDetails.selectedOviDam.first.mother?.animalName ??
    //           'Unknown',
    //       gender: Gender.female,
    //       image:
    //           widget.OviDetails.selectedOviDam.first.mother?.selectedOviImage !=
    //                   null
    //               ? FileImage(widget.OviDetails.selectedOviDam.first.mother!
    //                   .selectedOviImage!)
    //               : null,
    //       status: 'Dead'),
    //   Person(
    //     id: 100004,
    //     name: widget.OviDetails.selectedOviDam.first.animalName,
    //     image: widget.OviDetails.selectedOviDam.first.selectedOviImage != null
    //         ? FileImage(
    //             widget.OviDetails.selectedOviDam.first.selectedOviImage!)
    //         : null,
    //     gender: Gender.female,
    //     status: 'Sold',
    //     fatherId: 100010,
    //     motherId: 100011,
    //   ),
    //
    //   Person(
    //     id: 100009,
    //     name: widget.OviDetails.selectedOviSire.first.mother?.animalName ??
    //         'Unknown',
    //     gender: Gender.female,
    //     image:
    //         widget.OviDetails.selectedOviSire.first.mother?.selectedOviImage !=
    //                 null
    //             ? FileImage(widget
    //                 .OviDetails.selectedOviSire.first.mother!.selectedOviImage!)
    //             : null,
    //     status: 'Dead',
    //   ),
    //
    //   Person(
    //       id: 100010,
    //       name: widget.OviDetails.selectedOviDam.first.father?.animalName ??
    //           'Unknown',
    //       gender: Gender.male,
    //       image:
    //           widget.OviDetails.selectedOviDam.first.father?.selectedOviImage !=
    //                   null
    //               ? FileImage(widget.OviDetails.selectedOviDam.first.father!
    //                   .selectedOviImage!)
    //               : null,
    //       status: 'Sold'),
    // ];

    final animalIndex = ref.read(ovianimalsProvider).indexWhere(
          (animal) => animal.animalName == widget.OviDetails.animalName,
        );

    if (animalIndex == -1) {
      // Animal not found, you can show an error message or handle it accordingly
      return const SizedBox(); // Placeholder Widget, adjust as needed
    }

    final breedingEvents = ref
            .read(ovianimalsProvider)[animalIndex]
            .breedingEvents[widget.OviDetails.animalName] ??
        [];
    DateTime? lastBreedingDate;
    DateTime? nextBreedingDate;
    final now = DateTime.now();
    // Add persons based on the breeding events and children
    for (final breedingEvent in breedingEvents) {
      if (breedingEvent.breedingDate.isNotEmpty) {
        final dateSegments = breedingEvent.breedingDate.split('/');

        final breedingDate = DateTime(int.parse(dateSegments[2]),
            int.parse(dateSegments[1]), int.parse(dateSegments[0]));
        if (breedingDate.isBefore(now) &&
            (lastBreedingDate == null ||
                breedingDate.isAfter(lastBreedingDate))) {
          lastBreedingDate = breedingDate;
        }
      }

      for (final child in breedingEvent.children) {
        // Check if the child ID is already added, skip if it exists
        if (!addedChildIds.contains(child.animalName)) {
          // Add the child as a new Person if it doesn't exist in the addedChildIds list
          familyMembers.add(
            Person(
              id: generateUniqueId(),
              name: child.animalName,
              gender: Gender.male, // Change this accordingly
              image: child.selectedOviImage != null
                  ? FileImage(child.selectedOviImage!)
                  : null,
              status: 'Borrowed',
              fatherId: 100001,

              // motherId: 100002 // Change this accordingly
              // Add other details as needed
              // Example: image, gender, fatherId, motherId, status, etc.
            ),
          );
          // Add the child ID to the addedChildIds set to avoid duplication
          addedChildIds.add(child.animalName);
        }
      }
    }
    if (lastBreedingDate != null) {
      nextBreedingDate = lastBreedingDate.add(Duration(
          days: gestationPeriods[widget.OviDetails.selectedAnimalSpecies]!));
      if (nextBreedingDate.isBefore(now)) {
        nextBreedingDate = now;
      }
    }

    bool animalGender = true;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.OviDetails.selectedOviGender == 'Female')
            SizedBox(
              width: globals.widthMediaQuery * 343,
              child: OneInformationBlock(
                  head1: 'Pregnancy status',
                  subtitle1: widget.OviDetails.pregnant == true
                      ? 'Pregnant'
                      : 'Not Pregnant'),
            ),
          if (animalGender)
            SizedBox(
              height: globals.heightMediaQuery * 8,
            ),
          if (widget.OviDetails.selectedOviGender == 'Female' &&
              widget.OviDetails.selectedAnimalType == 'Oviparous' &&
              (lastBreedingDate != null || nextBreedingDate != null))
            SizedBox(
              width: 343 * globals.widthMediaQuery,
              child: TwoInformationBlock(
                head1: lastBreedingDate != null
                    ? DateFormat('dd.MM.yyyy').format(lastBreedingDate)
                    : '',
                head2: nextBreedingDate != null
                    ? DateFormat('dd.MM.yyyy').format(nextBreedingDate)
                    : '',
                subtitle1: "Last Breeding Date",
                subtitle2: 'Next Breeding Date',
              ),
            ),
          if (widget.OviDetails.selectedOviGender == 'Male')
            SizedBox(
              width: 343 * globals.widthMediaQuery,
              child: TwoInformationBlock(
                head1: widget.OviDetails.selectedOviDates
                        .containsKey('Date Of Mating')
                    ? DateFormat('dd.MM.yyyy').format(
                        widget.OviDetails.selectedOviDates['Date Of Mating']!)
                    : '',
                head2: widget.OviDetails.selectedOviDates
                        .containsKey('Next Date Of Mating')
                    ? DateFormat('dd.MM.yyyy').format(widget
                        .OviDetails.selectedOviDates['Next Date Of Mating']!)
                    : 'Add',
                subtitle1: "Date Of Mating",
                subtitle2: 'Next Date Of Mating',
                onTap2: () => updateDateField('Next Date Of Mating'),
              ),
            ),
          if (animalGender)
            SizedBox(
              height: globals.heightMediaQuery * 24,
            ),
          Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.only(right: 0, left: 0),
                leading:
                    Image.asset('assets/icons/frame/24px/breeding_history.png'),
                title: Text(
                  'Breeding History',
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                trailing: Icon(Icons.chevron_right_rounded,
                    size: 24 * globals.widthMediaQuery),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ListOfBreedingEvents(
                          // breedingEventNumberController:
                          //     TextEditingController(),
                          shouldAddBreedEvent: false,
                          OviDetails: widget.OviDetails,
                          breedingEvents: widget.breedingEvents,
                        );
                      },
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(right: 0, left: 0),
                leading: Image.asset('assets/icons/frame/24px/parents.png'),
                title: Text(
                  'Parents',
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                trailing: Icon(Icons.chevron_right_rounded,
                    size: 24 * globals.widthMediaQuery),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ParentsPage(
                          selectedMammalDam: '',
                          selectedMammalSire: '',
                          selectedOviDam: '',
                          selectedOviSire: '',
                          OviDetails: widget.OviDetails,
                        );
                      },
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(right: 0, left: 0),
                leading: Image.asset('assets/icons/frame/24px/family_tree.png'),
                title: Text(
                  'Family Tree',
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                trailing: Icon(Icons.chevron_right_rounded,
                    size: 24 * globals.widthMediaQuery),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FamilyTreePage(
                          members: getFamilyMembers(),
                          selectedPersonId: 100001,
                          OviDetails: widget.OviDetails,
                        );
                      },
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(right: 0, left: 0),
                leading: animalGender
                    ? Image.asset('assets/icons/frame/24px/male_mates.png')
                    : Image.asset('assets/icons/frame/24px/female_mates.png'),
                title: animalGender
                    ? Text(
                        'Male Mates',
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      )
                    : Text(
                        'Female Mates',
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      ),
                trailing: Icon(Icons.chevron_right_rounded,
                    size: 24 * globals.widthMediaQuery),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ListOfBreedingMates(
                          OviDetails: widget.OviDetails,
                        );
                      },
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.only(
                    right: 0, left: 0, bottom: 32 * globals.heightMediaQuery),
                leading: Image.asset('assets/icons/frame/24px/children.png'),
                title: Text(
                  'Children',
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                trailing: Icon(Icons.chevron_right_rounded,
                    size: 24 * globals.widthMediaQuery),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BreedingEventChildrenList(
                          OviDetails: widget.OviDetails,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> updateDateField(dateType) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Change the background color of the date picker
            primaryColor: AppColors.primary30,
            colorScheme: const ColorScheme.light(primary: AppColors.primary20),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            // Here you can customize more colors if needed
            // For example, you can change the header color, selected day color, etc.
          ),
          child: child!,
        );
      },
    );
    setState(() {
      widget.OviDetails.selectedOviDates[dateType] = pickedDate;
    });

    ref.read(ovianimalsProvider.notifier).update((state) {
      final index = state
          .indexWhere((animal) => animal.animalName == widget.OviDetails
          .animalName);
      state[index] = widget.OviDetails;
      return state;
    });
  }

  List<Person> getFamilyMembers() {
    familyMembers = [];
    ref.read(ovianimalsProvider).forEach((animal) {
      final person = Person(
              id: animal.id,
              name: animal.animalName,
              image: animal.selectedOviImage != null
                  ? FileImage(animal.selectedOviImage!)
                  : null,
              status: animal.selectedOviChips.join(','),
              gender: animal.selectedOviGender == 'Maile' ? Gender.male : Gender
                  .female,
              fatherId: animal.selectedOviSire.isNotEmpty ? animal
                  .selectedOviSire.first.id : null,
              motherId: animal.selectedOviDam.isNotEmpty ? animal.selectedOviDam
                  .first.id : null,
            );
      familyMembers.add(person);
    });
    return familyMembers;
  }
}
