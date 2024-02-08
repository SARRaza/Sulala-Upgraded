import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/classes/breeding_event_variables.dart';
import '../../../data/classes/ovi_variables.dart';
import '../../../data/riverpod_globals.dart';
import '../../../screens/breeding/family_tree/family_tree_page.dart';
import '../../../screens/breeding/list_of_breeding_events.dart';
import '../../../screens/breeding/list_of_mates.dart';

import '../../../screens/breeding/list_of_children.dart';
import '../../../screens/breeding/parents_page.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../other/one_information_block.dart';
import '../../other/two_information_block.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

class BreedingInfo extends ConsumerStatefulWidget {
  final OviVariables oviDetails;
  final List<BreedingEventVariables> breedingEvents;

  const BreedingInfo(
      {Key? key, required this.oviDetails, required this.breedingEvents})
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
    final animalIndex = ref.read(oviAnimalsProvider).indexWhere(
          (animal) => animal.animalName == widget.oviDetails.animalName,
        );

    if (animalIndex == -1) {
      // Animal not found, you can show an error message or handle it accordingly
      return const SizedBox(); // Placeholder Widget, adjust as needed
    }
    final breedingEvents = ref
        .read(breedingEventsProvider)
        .where((event) =>
            event.sire?.id == widget.oviDetails.id ||
            event.dam?.id == widget.oviDetails.id)
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
          days: widget.oviDetails.selectedAnimalType == 'Mammal'
              ? gestationPeriods[widget.oviDetails.selectedAnimalSpecies]!
              : incubationPeriods[widget.oviDetails.selectedAnimalSpecies]!));
      if (nextBreedingDate.isBefore(now)) {
        nextBreedingDate = now;
      }
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.oviDetails.selectedOviGender == 'Female')
            SizedBox(
              width: SizeConfig.widthMultiplier(context) * 343,
              child: OneInformationBlock(
                  head1: 'Pregnancy status',
                  subtitle1: widget.oviDetails.pregnant == true
                      ? 'Pregnant'
                      : 'Not Pregnant'),
            ),
          if (widget.oviDetails.selectedOviGender == 'Male')
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 8,
            ),
          if (widget.oviDetails.selectedOviGender == 'Female' &&
              widget.oviDetails.selectedAnimalType == 'Oviparous' &&
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
          if (widget.oviDetails.selectedOviGender == 'Male')
            SizedBox(
              width: 343 * SizeConfig.widthMultiplier(context),
              child: TwoInformationBlock(
                head1: widget.oviDetails.selectedOviDates
                        .containsKey('Date Of Mating')
                    ? DateFormat('dd.MM.yyyy').format(
                        widget.oviDetails.selectedOviDates['Date Of Mating']!)
                    : '',
                head2: widget.oviDetails.selectedOviDates
                        .containsKey('Next Date Of Mating')
                    ? DateFormat('dd.MM.yyyy').format(widget
                        .oviDetails.selectedOviDates['Next Date Of Mating']!)
                    : 'Add',
                subtitle1: "Date Of Mating",
                subtitle2: 'Next Date Of Mating',
                onTap2: () => _updateDateField('Next Date Of Mating'),
              ),
            ),
          if (widget.oviDetails.selectedOviGender == 'Male')
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
                          shouldAddBreedEvent: false,
                          oviDetails: widget.oviDetails,
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
                          oviDetails: widget.oviDetails,
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
                          selectedAnimalId: widget.oviDetails.id,
                        );
                      },
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(right: 0, left: 0),
                leading: widget.oviDetails.selectedOviGender == 'Male'
                    ? Image.asset('assets/icons/frame/24px/male_mates.png')
                    : Image.asset('assets/icons/frame/24px/female_mates.png'),
                title: widget.oviDetails.selectedOviGender == 'Male'
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
                          oviDetails: widget.oviDetails,
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
                          oviDetails: widget.oviDetails,
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

  Future<void> _updateDateField(dateType) async {
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
      widget.oviDetails.selectedOviDates[dateType] = pickedDate;
    });

    ref.read(oviAnimalsProvider.notifier).update((state) {
      final index = state.indexWhere(
          (animal) => animal.animalName == widget.oviDetails.animalName);
      state[index] = widget.oviDetails;
      return state;
    });
  }
}
