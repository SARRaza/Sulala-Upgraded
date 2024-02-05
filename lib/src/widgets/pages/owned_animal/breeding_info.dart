// ignore_for_file: dead_code, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/classes/breeding_event_variables.dart';
import '../../../data/classes/ovi_variables.dart';
import '../../../data/riverpod_globals.dart';
import '../../../screens/breeding/family_tree/family_tree_page.dart';
import '../../../screens/breeding/list_of_breeding_events.dart';
import '../../../screens/breeding/list_of_mates.dart';

import '../../../screens/breeding/list_of_childrens.dart';
import '../../../screens/breeding/parents_page.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../other/one_information_block.dart';
import '../../other/two_information_block.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

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
  List<OviVariables> familyMembers = [];

  @override
  Widget build(BuildContext context) {
    final animalIndex = ref.read(ovianimalsProvider).indexWhere(
          (animal) => animal.animalName == widget.OviDetails.animalName,
        );

    if (animalIndex == -1) {
      // Animal not found, you can show an error message or handle it accordingly
      return const SizedBox(); // Placeholder Widget, adjust as needed
    }
    final breedingEvents = ref
        .read(breedingEventsProvider)
        .where((event) =>
            event.sire?.id == widget.OviDetails.id ||
            event.dam?.id == widget.OviDetails.id)
        .toList();

    DateTime? lastBreedingDate;
    DateTime? nextBreedingDate;
    final now = DateTime.now();
    // Add persons based on the breeding events and children
    for (final breedingEvent in breedingEvents) {
      if (breedingEvent.breedingDate != null) {
        if (breedingEvent.breedingDate!.isBefore(now) &&
            (lastBreedingDate == null ||
                breedingEvent.breedingDate!.isAfter(lastBreedingDate))) {
          lastBreedingDate = breedingEvent.breedingDate;
        }
      }
    }
    if (lastBreedingDate != null) {
      nextBreedingDate = lastBreedingDate.add(Duration(
          days: widget.OviDetails.selectedAnimalType == 'Mammal'
              ? gestationPeriods[widget.OviDetails.selectedAnimalSpecies]!
              : incubationPeriods[widget.OviDetails.selectedAnimalSpecies]!));
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
              width: SizeConfig.widthMultiplier(context) * 343,
              child: OneInformationBlock(
                  head1: 'Pregnancy status',
                  subtitle1: widget.OviDetails.pregnant == true
                      ? 'Pregnant'
                      : 'Not Pregnant'),
            ),
          if (animalGender)
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 8,
            ),
          if (widget.OviDetails.selectedOviGender == 'Female' &&
              widget.OviDetails.selectedAnimalType == 'Oviparous' &&
              (lastBreedingDate != null || nextBreedingDate != null))
            SizedBox(
              width: 343 * SizeConfig.widthMultiplier(context),
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
              width: 343 * SizeConfig.widthMultiplier(context),
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
              height: SizeConfig.heightMultiplier(context) * 24,
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
                    size: 24 * SizeConfig.widthMultiplier(context)),
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
                    size: 24 * SizeConfig.widthMultiplier(context)),
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
                    size: 24 * SizeConfig.widthMultiplier(context)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FamilyTreePage(
                          selectedAnimalId: widget.OviDetails.id,
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
                    size: 24 * SizeConfig.widthMultiplier(context)),
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
                    right: 0,
                    left: 0,
                    bottom: 32 * SizeConfig.heightMultiplier(context)),
                leading: Image.asset('assets/icons/frame/24px/children.png'),
                title: Text(
                  'Children',
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                trailing: Icon(Icons.chevron_right_rounded,
                    size: 24 * SizeConfig.widthMultiplier(context)),
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
      final index = state.indexWhere(
          (animal) => animal.animalName == widget.OviDetails.animalName);
      state[index] = widget.OviDetails;
      return state;
    });
  }
}
