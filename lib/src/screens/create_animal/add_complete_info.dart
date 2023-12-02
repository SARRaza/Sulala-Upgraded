// ignore_for_file: non_constant_identifier_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/buttons/sar_buttonwidget.dart';
import '../../widgets/controls_and_buttons/tags/custom_tags.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/controls_and_buttons/toggles/toggle_active.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';

import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../widgets/inputs/paragraph_text_fields/paragraph_text_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import '../breeding/list_of_breeding_events.dart';
import 'sar_listofanimals.dart';

class CreateOviCumMammal extends ConsumerStatefulWidget {
  final List<BreedingEventVariables> breedingEvents;

  const CreateOviCumMammal({super.key, required this.breedingEvents});

  @override
  // ignore: library_private_types_in_public_api
  _CreateOviCumMammal createState() => _CreateOviCumMammal();
}

class _CreateOviCumMammal extends ConsumerState<CreateOviCumMammal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _frequencyEggsController =
      TextEditingController();
  final TextEditingController _numberofEggsController = TextEditingController();
  String fieldName = '';
  String fieldContent = '';
  String selectedOviSire = 'Add';
  String selectedOviDam = 'Add';
  // String selectedDate = '';
  String selectedBreedingStage = '';
  List<reminderItem> mathdDates = [];
  List<MainAnimalSire> selectedSire = [];
  List<MainAnimalDam> selectedDam = [];
  // ignore: non_constant_identifier_names
  // void dateOfBirth(String DateOfBirth) {
  //   setState(() {
  //     ref.read(dateOfBirthProvider.notifier).update((state) => DateOfBirth);
  //   });
  // }

  Map<String, DateTime?> selectedMammalDates = {};
  List<String> selectedOviChips = [];
  List<Widget> customOviTextFields = [];
  Map<String, DateTime?> selectedOviDates = {};
  bool showAdditionalFields = false;
  String selectedOviDateType = "Date Of Birth"; // Default value
  // Initial text for the button
  String selectedOviGender = '';
  bool _addAnimalParents = false;
  bool _addOviChildren = false;
  // ignore: non_constant_identifier_names
  final ImagePicker _Animalpicker = ImagePicker();

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              ListTile(
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.grayscale50,
                ),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedAnimalImage =
                      await _Animalpicker.pickImage(source: ImageSource.camera);
                  if (pickedAnimalImage != null) {
                    ref
                        .read(selectedAnimalImageProvider.notifier)
                        .update((state) => File(pickedAnimalImage.path));
                    // setState(() {
                    //   _selectedOviImage = File(pickedAnimalImage.path);
                    // });
                  }
                },
              ),
              Container(
                height: 1,
                width: globals.widthMediaQuery * 343,
                color: AppColors.grayscale20,
              ),
              ListTile(
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.grayscale50,
                ),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedAnimalImage = await _Animalpicker.pickImage(
                      source: ImageSource.gallery);
                  if (pickedAnimalImage != null) {
                    ref
                        .read(selectedAnimalImageProvider.notifier)
                        .update((state) => File(pickedAnimalImage.path));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showmainAnimalSireSelectionSheet(BuildContext context) async {
    // Initialize an empty list
    final ovianimals = ref.watch(ovianimalsProvider);

    String searchQuery = '';
    final selectedFather = <MainAnimalSire>[];
    final selectedMother = <MainAnimalDam>[];

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 1,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Select Sire",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              border: Border.all(),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value.toLowerCase();
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: "Search By Name Or ID",
                                prefixIcon: Icon(Icons.search),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: ovianimals.length,
                        itemBuilder: (context, index) {
                          // ignore: non_constant_identifier_names
                          final OviDetails = ovianimals[index];

                          final bool isSelected =
                              selectedSire.contains(OviDetails.animalName);

                          // Apply the filter here
                          if (!OviDetails.animalName
                                  .toLowerCase()
                                  .contains(searchQuery) &&
                              !OviDetails.selectedAnimalType
                                  .toLowerCase()
                                  .contains(searchQuery)) {
                            return Container(); // Skip this item if it doesn't match the search query
                          }

                          return ListTile(
                            tileColor: isSelected
                                ? Colors.green.withOpacity(0.5)
                                : null,
                            shape: isSelected
                                ? RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  )
                                : null,
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey[100],
                              backgroundImage:
                                  OviDetails.selectedOviImage != null
                                      ? FileImage(OviDetails.selectedOviImage!)
                                      : null,
                              child: OviDetails.selectedOviImage == null
                                  ? const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 50,
                                      color: Colors.grey,
                                    )
                                  : null,
                            ),
                            title: Text(OviDetails.animalName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Gender: ${OviDetails.selectedOviGender}'),
                                Text(
                                    'Father: ${OviDetails.selectedOviSire.first.animalName}'),
                                if (OviDetails.selectedOviSire.first.father !=
                                    null)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Paternal Father: ${OviDetails.selectedOviSire.first.father!.animalName}'),
                                      if (OviDetails
                                              .selectedOviSire.first.mother !=
                                          null)
                                        Text(
                                            'Paternal Mother: ${OviDetails.selectedOviSire.first.mother!.animalName}'),
                                    ],
                                  ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedSire.removeWhere(
                                    (sire) =>
                                        sire.animalName ==
                                        OviDetails.animalName,
                                  );
                                } else {
                                  // Use a default image (icon) if selectedOviImage is null
                                  final File? oviImage =
                                      OviDetails.selectedOviImage;

                                  // Select the father if available
                                  MainAnimalSire father =
                                      OviDetails.selectedOviSire.first;

                                  // Select the mother if available
                                  MainAnimalDam mother =
                                      OviDetails.selectedOviDam.first;

                                  selectedSire.add(MainAnimalSire(
                                    OviDetails.animalName,
                                    oviImage,
                                    OviDetails.selectedOviGender,
                                    father: father,
                                    mother: mother,
                                  ));

                                  // Add father to the list
                                  selectedFather.add(father);

                                  // Add mother to the list
                                  selectedMother.add(mother);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(animalSireDetailsProvider.notifier)
                            .update((state) => selectedSire);
                        Navigator.pop(context);
                        // Append the selected children to the existing list
                        final List<MainAnimalSire> existingSelectedSire =
                            ref.read(animalSireDetailsProvider);
                        existingSelectedSire.addAll(selectedSire);

                        // Also, add fathers to the list
                        existingSelectedSire.addAll(selectedFather);

                        // Append the selected mothers to the existing list
                        final List<MainAnimalDam> existingSelectedDam =
                            ref.read(animalDamDetailsProvider);
                        existingSelectedDam.addAll(selectedMother);
                      },
                      child: const Text("Done"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showmainAnimalDamSelectionSheet(BuildContext context) async {
    // Initialize an empty list
    final ovianimals = ref.watch(ovianimalsProvider);

    String searchQuery = '';

    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 1,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Select Dam",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              border: Border.all(),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value.toLowerCase();
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: "Search By Name Or ID",
                                prefixIcon: Icon(Icons.search),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: ovianimals.length,
                        itemBuilder: (context, index) {
                          final OviDetails = ovianimals[index];

                          final bool isSelected =
                              // ignore: iterable_contains_unrelated_type
                              selectedDam.contains(OviDetails.animalName);

                          // Apply the filter here
                          if (!OviDetails.animalName
                                  .toLowerCase()
                                  .contains(searchQuery) &&
                              !OviDetails.selectedAnimalType
                                  .toLowerCase()
                                  .contains(searchQuery)) {
                            return Container(); // Skip this item if it doesn't match the search query
                          }

                          return ListTile(
                            tileColor: isSelected
                                ? Colors.green.withOpacity(0.5)
                                : null,
                            shape: isSelected
                                ? RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  )
                                : null,
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey[100],
                              backgroundImage:
                                  OviDetails.selectedOviImage != null
                                      ? FileImage(OviDetails.selectedOviImage!)
                                      : null,
                              child: OviDetails.selectedOviImage == null
                                  ? const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 50,
                                      color: Colors.grey,
                                    )
                                  : null,
                            ),
                            title: Text(OviDetails.animalName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Gender: ${OviDetails.selectedOviGender}'),
                                Text(
                                    'Mother: ${OviDetails.selectedOviDam.first.animalName}'),
                                if (OviDetails.selectedOviDam.first.mother !=
                                    null)
                                  Text(
                                      'Grandmother: ${OviDetails.selectedOviDam.first.mother!.animalName}'),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedDam.removeWhere(
                                    (dam) =>
                                        dam.animalName == OviDetails.animalName,
                                  );
                                } else {
                                  // Use a default image (icon) if selectedOviImage is null
                                  final File? oviImage =
                                      OviDetails.selectedOviImage;
                                  MainAnimalDam mother =
                                      OviDetails.selectedOviDam.first;

                                  selectedDam.add(MainAnimalDam(
                                      OviDetails.animalName,
                                      oviImage,
                                      OviDetails.selectedOviGender,
                                      mother: mother));
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(animalDamDetailsProvider.notifier)
                            .update((state) => selectedDam);
                        Navigator.pop(context);
                        // Append the selected children to the existing list
                        final List<MainAnimalDam> existingSelectedDam =
                            ref.read(animalDamDetailsProvider);
                        existingSelectedDam.addAll(selectedDam);

                        for (MainAnimalDam dam in selectedDam) {
                          if (dam.mother != null) {
                            existingSelectedDam.add(dam.mother!);
                          }
                        }
                      },
                      child: const Text("Done"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  final List<Map<String, String>> animalDams = [
    {'name': 'Alice'},
    {'name': 'John'},
    {'name': 'Jack'},
    {'name': 'Kiran'},
    {'name': 'Mantic'},
    {'name': 'Mongolia'},
    // Add more country codes and names as needed
  ];

  void _showDateSelectionSheet(BuildContext context) async {
    final selectedAnimalType = ref.watch(selectedAnimalTypeProvider);
    // ignore: non_constant_identifier_names
    List<String> OvidateTypes = [
      'Date Of Hatching',
      'Date Of Death',
      'Date Of Sale',
    ];
    // ignore: non_constant_identifier_names
    List<String> MammaldateTypes = [
      'Date Of Weaning',
      'Date Of Mating',
      'Date Of Death',
      'Date Of Sale',
    ];

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Add Date ',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (selectedAnimalType == "Oviparous")
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: OvidateTypes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(OvidateTypes[index]),
                            dense: true,
                            minVerticalPadding: double.minPositive,
                            trailing: const Icon(Icons.arrow_right_alt_rounded),
                            onTap: () {
                              Navigator.pop(context);
                              _showOviDatePicker(context, OvidateTypes[index]);
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ),
              if (selectedAnimalType == "Mammal")
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: MammaldateTypes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(MammaldateTypes[index]),
                            dense: true,
                            minVerticalPadding: double.minPositive,
                            trailing: const Icon(Icons.arrow_right_alt_rounded),
                            onTap: () {
                              Navigator.pop(context);
                              _showOviDatePicker(
                                  context, MammaldateTypes[index]);
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showOviDatePicker(BuildContext context, String dateType) async {
    final selectedAnimalName = ref.watch(animalNameProvider);

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: selectedOviDates[dateType] ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      // Check if the selected date is five days away from today
      final DateTime today = DateTime.now();
      final DateTime fiveDaysAway = today.add(const Duration(days: 5));

      if (selectedDate.isAfter(today) && selectedDate.isBefore(fiveDaysAway)) {
        // Format the selected date as a string (excluding time)
        final formattedDate =
            DateFormat('dd/MM/yyyy').format(selectedDate.toLocal());

        // Add the selected date to the mathdDates list
        final reminderItem newItem = reminderItem(
          selectedAnimalName, // Add the animal name
          dateType,
          formattedDate,
        );
        ref.read(remindersProvider.notifier).state = [
          ...ref.read(remindersProvider),
          newItem
        ];
      }

      // Get the existing selectedOviDates
      final Map<String, DateTime?> existingDates =
          ref.read(selectedOviDatesProvider);

      // Update the selectedOviDatesProvider with the new entry added
      ref.read(selectedOviDatesProvider.notifier).state = {
        ...existingDates,
        dateType: selectedDate,
      };
    }
  }

  void _animalTagsModalSheet() async {
    final result = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Tags',
                        style: AppFonts.title2(color: AppColors.grayscale90),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        'Current State',
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      ),
                      SizedBox(
                        height: globals.heightMediaQuery * 10,
                      ),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          CustomTag(
                            label: 'Borrowed',
                            selected: ref
                                .read(selectedOviChipsProvider)
                                .contains('Borrowed'),
                            onTap: () {
                              setState(() {
                                if (ref
                                    .read(selectedOviChipsProvider)
                                    .contains('Borrowed')) {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .remove('Borrowed');
                                } else {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .add('Borrowed');
                                }
                              });
                            },
                          ),
                          CustomTag(
                            label: 'Adopted',
                            selected: ref
                                .read(selectedOviChipsProvider)
                                .contains('Adopted'),
                            onTap: () {
                              setState(() {
                                if (ref
                                    .read(selectedOviChipsProvider)
                                    .contains('Adopted')) {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .remove('Adopted');
                                } else {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .add('Adopted');
                                }
                              });
                            },
                          ),
                          CustomTag(
                            label: 'Donated',
                            selected: ref
                                .read(selectedOviChipsProvider)
                                .contains('Donated'),
                            onTap: () {
                              setState(() {
                                if (ref
                                    .read(selectedOviChipsProvider)
                                    .contains('Donated')) {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .remove('Donated');
                                } else {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .add('Donated');
                                }
                              });
                            },
                          ),
                          CustomTag(
                            label: 'Escaped',
                            selected: ref
                                .read(selectedOviChipsProvider)
                                .contains('Escaped'),
                            onTap: () {
                              setState(() {
                                if (ref
                                    .read(selectedOviChipsProvider)
                                    .contains('Escaped')) {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .remove('Escaped');
                                } else {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .add('Escaped');
                                }
                              });
                            },
                          ),
                          CustomTag(
                            label: 'Stolen',
                            selected: ref
                                .read(selectedOviChipsProvider)
                                .contains('Stolen'),
                            onTap: () {
                              setState(() {
                                if (ref
                                    .read(selectedOviChipsProvider)
                                    .contains('Stolen')) {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .remove('Stolen');
                                } else {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .add('Stolen');
                                }
                              });
                            },
                          ),
                          CustomTag(
                            label: 'Trasnferred',
                            selected: ref
                                .read(selectedOviChipsProvider)
                                .contains('Trasnferred'),
                            onTap: () {
                              setState(() {
                                if (ref
                                    .read(selectedOviChipsProvider)
                                    .contains('Trasnferred')) {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .remove('Trasnferred');
                                } else {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .add('Trasnferred');
                                }
                              });
                            },
                          ),

                          // Add more chips here
                        ],
                      ),
                      SizedBox(
                        height: globals.heightMediaQuery * 20,
                      ),
                      Text(
                        'Medical State',
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      ),
                      SizedBox(
                        height: globals.heightMediaQuery * 10,
                      ),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          CustomTag(
                            label: 'Injured',
                            selected: ref
                                .read(selectedOviChipsProvider)
                                .contains('Injured'),
                            onTap: () {
                              setState(() {
                                if (ref
                                    .read(selectedOviChipsProvider)
                                    .contains('Injured')) {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .remove('Injured');
                                } else {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .add('Injured');
                                }
                              });
                            },
                          ),
                          CustomTag(
                            label: 'Sick',
                            selected: ref
                                .read(selectedOviChipsProvider)
                                .contains('Sick'),
                            onTap: () {
                              setState(() {
                                if (ref
                                    .read(selectedOviChipsProvider)
                                    .contains('Sick')) {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .remove('Sick');
                                } else {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .add('Sick');
                                }
                              });
                            },
                          ),
                          CustomTag(
                            label: 'Quarantined',
                            selected: ref
                                .read(selectedOviChipsProvider)
                                .contains('Quarantined'),
                            onTap: () {
                              setState(() {
                                if (ref
                                    .read(selectedOviChipsProvider)
                                    .contains('Quarantined')) {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .remove('Quarantined');
                                } else {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .add('Quarantined');
                                }
                              });
                            },
                          ),
                          CustomTag(
                            label: 'Medication',
                            selected: ref
                                .read(selectedOviChipsProvider)
                                .contains('Medication'),
                            onTap: () {
                              setState(() {
                                if (ref
                                    .read(selectedOviChipsProvider)
                                    .contains('Medication')) {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .remove('Medication');
                                } else {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .add('Medication');
                                }
                              });
                            },
                          ),
                          CustomTag(
                            label: 'Testing',
                            selected: ref
                                .read(selectedOviChipsProvider)
                                .contains('Testing'),
                            onTap: () {
                              setState(() {
                                if (ref
                                    .read(selectedOviChipsProvider)
                                    .contains('Testing')) {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .remove('Testing');
                                } else {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .add('Testing');
                                }
                              });
                            },
                          ),
                          CustomTag(
                            label: 'Pregnant',
                            selected: ref
                                .read(selectedOviChipsProvider)
                                .contains('Pregnant'),
                            onTap: () {
                              setState(() {
                                if (ref
                                    .read(selectedOviChipsProvider)
                                    .contains('Pregnant')) {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .remove('Pregnant');
                                } else {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .add('Pregnant');
                                }
                              });
                            },
                          ),
                          CustomTag(
                            label: 'Lactating',
                            selected: ref
                                .read(selectedOviChipsProvider)
                                .contains('Lactating'),
                            onTap: () {
                              setState(() {
                                if (ref
                                    .read(selectedOviChipsProvider)
                                    .contains('Lactating')) {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .remove('Lactating');
                                } else {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .add('Lactating');
                                }
                              });
                            },
                          ),

                          // Add more chips here
                        ],
                      ),
                      SizedBox(
                        height: globals.heightMediaQuery * 20,
                      ),
                      const Text(
                        'Other',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: globals.heightMediaQuery * 10,
                      ),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          CustomTag(
                            label: 'Sold',
                            selected: ref
                                .read(selectedOviChipsProvider)
                                .contains('Sold'),
                            onTap: () {
                              setState(() {
                                if (ref
                                    .read(selectedOviChipsProvider)
                                    .contains('Sold')) {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .remove('Sold');
                                } else {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .add('Sold');
                                }
                              });
                            },
                          ),
                          CustomTag(
                            label: 'Dead',
                            selected: ref
                                .read(selectedOviChipsProvider)
                                .contains('Dead'),
                            onTap: () {
                              setState(() {
                                if (ref
                                    .read(selectedOviChipsProvider)
                                    .contains('Dead')) {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .remove('Dead');
                                } else {
                                  ref
                                      .read(selectedOviChipsProvider)
                                      .add('Dead');
                                }
                              });
                            },
                          ),
                          // Add more chips here
                        ],
                      ),
                      const SizedBox(height: 77.0),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(children: [
                          Expanded(
                            child: PrimaryButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(ref.read(selectedOviChipsProvider));
                              },
                              status: PrimaryButtonStatus.idle,
                              text: 'Save',
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedOviChips = List<String>.from(result);
      });
    }
  }

  void _showOviFieldNameModal(BuildContext context) {
    TextEditingController fieldname = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Custom Field',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                PrimaryTextField(
                    hintText: 'Enter Custom Field Name',
                    labelText: 'Enter Field Name',
                    onChanged: (value) {
                      ref
                          .read(fieldNameProvider.notifier)
                          .update((state) => value);
                    },
                    controller: fieldname),
                SizedBox(height: globals.heightMediaQuery * 130),
                ButtonWidget(
                  onPressed: () {
                    Navigator.pop(context);
                    _showOviFieldContentModal(context);
                  },
                  buttonText: 'Confirm',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 238, 238, 238),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showOviFieldContentModal(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Text Area',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Enter Field Content',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                  onChanged: (value) {
                    ref
                        .read(fieldContentProvider.notifier)
                        .update((state) => value);
                  },
                ),
                const SizedBox(
                  height: 35,
                ),
                ButtonWidget(
                  onPressed: () {
                    Navigator.pop(context);
                    _addNewOviTextField(context);
                  },
                  buttonText: 'Confirm',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 238, 238, 238),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addNewOviTextField(BuildContext context) {
    final fieldName = ref.read(fieldNameProvider);
    final fieldContent = ref.read(fieldContentProvider);

    ref.read(customOviTextFieldsProvider).add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(fieldName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      ref.read(customOviTextFieldsProvider).removeLast();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                ),
                controller: TextEditingController(text: fieldContent),
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final selectedAnimalType = ref.watch(selectedAnimalTypeProvider);
    final selectedAnimalImage = ref.watch(selectedAnimalImageProvider);
    final animalDam = ref.watch(animalDamDetailsProvider);
    final animalSire = ref.watch(animalSireDetailsProvider);
    final chips = ref.watch(selectedOviChipsProvider);
    final customFields = ref.watch(customOviTextFieldsProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create ',
                style: AppFonts.headline3(color: AppColors.grayscale90),
              ),
              Text(
                selectedAnimalType,
                style: AppFonts.headline3(color: AppColors.grayscale90),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.only(left: globals.widthMediaQuery * 16),
            child: Container(
              width: globals.widthMediaQuery * 40,
              decoration: const BoxDecoration(
                  color: AppColors.grayscale10, shape: BoxShape.circle),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: globals.widthMediaQuery * 24,
                ),
                onPressed: () {
                  // Handle close button press
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: globals.widthMediaQuery * 16),
              child: Container(
                width: globals.widthMediaQuery * 40,
                decoration: const BoxDecoration(
                    color: AppColors.grayscale10, shape: BoxShape.circle),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                    size: globals.widthMediaQuery * 24,
                  ),
                  onPressed: () {
                    // Handle close button press
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: globals.widthMediaQuery * 16,
                right: globals.widthMediaQuery * 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: globals.heightMediaQuery * 40),
                Center(
                  child: GestureDetector(
                    child: CircleAvatar(
                      radius: globals.widthMediaQuery * 60,
                      backgroundColor: AppColors.grayscale10,
                      backgroundImage: selectedAnimalImage != null
                          ? FileImage(selectedAnimalImage)
                          : null,
                      child: selectedAnimalImage == null
                          ? const Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                              color: AppColors.grayscale90,
                            )
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: globals.heightMediaQuery * 16),
                Center(
                  child: TextButton(
                    onPressed: () {
                      _showImagePicker(context);
                    },
                    child: const Text(
                      'Add Photo',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primary40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: globals.heightMediaQuery * 24),
                PrimaryTextField(
                    onChanged: (value) {
                      ref
                          .read(animalNameProvider.notifier)
                          .update((state) => value);
                    },
                    labelText: 'Name',
                    hintText: 'Enter Name',
                    controller: _nameController),
                SizedBox(height: globals.heightMediaQuery * 32),
                Text(
                  "Family Tree",
                  style: AppFonts.headline2(color: AppColors.grayscale90),
                ),
                SizedBox(height: globals.heightMediaQuery * 8),
                Text(
                  "Add Parents If They're In The System",
                  style: AppFonts.body2(color: AppColors.grayscale60),
                ),
                SizedBox(height: globals.heightMediaQuery * 16),
                Padding(
                  padding: EdgeInsets.only(
                      top: globals.heightMediaQuery * 8,
                      bottom: globals.heightMediaQuery * 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Add Parents',
                          style: AppFonts.body2(color: AppColors.grayscale90),
                        ),
                      ),
                      ToggleActive(
                        value: _addAnimalParents,
                        onChanged: (value) {
                          setState(() {
                            _addAnimalParents = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _addAnimalParents,
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: globals.heightMediaQuery * 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Sire (Father)',
                              style:
                                  AppFonts.body2(color: AppColors.grayscale70),
                            ),
                            const Spacer(),
                            PrimaryTextButton(
                              onPressed: () {
                                _showmainAnimalSireSelectionSheet(context);
                              },
                              status: TextStatus.idle,
                              text: animalSire.first.animalName,
                              position: TextButtonPosition.right,
                            ),
                          ],
                        ),
                        SizedBox(height: globals.heightMediaQuery * 16),
                        Row(
                          children: [
                            Text(
                              'Dam (Mother)',
                              style:
                                  AppFonts.body2(color: AppColors.grayscale70),
                            ),
                            const Spacer(),
                            PrimaryTextButton(
                              onPressed: () {
                                _showmainAnimalDamSelectionSheet(context);
                              },
                              status: TextStatus.idle,
                              text: animalDam.first.animalName,
                              position: TextButtonPosition.right,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: globals.heightMediaQuery * 8),
                Padding(
                  padding: EdgeInsets.only(
                      top: globals.heightMediaQuery * 8,
                      bottom: globals.heightMediaQuery * 8),
                  child: Row(
                    children: [
                      Text(
                        'Add Children',
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                      const Spacer(),
                      ToggleActive(
                        value: _addOviChildren,
                        onChanged: (value) {
                          setState(() {
                            _addOviChildren = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _addOviChildren,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: globals.heightMediaQuery * 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Children',
                              style:
                                  AppFonts.body2(color: AppColors.grayscale70),
                            ),
                            const Spacer(),
                            PrimaryTextButton(
                              onPressed: () {
                                _showmainAnimalSireSelectionSheet(context);
                              },
                              status: TextStatus.idle,
                              text: animalSire.first.animalName,
                              position: TextButtonPosition.right,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: globals.heightMediaQuery * 16,
                ),
                const Divider(
                  color: AppColors.grayscale20,
                ),
                SizedBox(
                  height: globals.heightMediaQuery * 16,
                ),
                Text(
                  "Animal Sex",
                  style: AppFonts.headline2(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: globals.heightMediaQuery * 16,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: globals.heightMediaQuery * 12,
                    bottom: globals.heightMediaQuery * 12,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        ref
                            .read(selectedOviGenderProvider.notifier)
                            .update((state) => 'Unknown');

                        showAdditionalFields = false;
                      });
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Unknown',
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                        ),
                        Container(
                          width: globals.widthMediaQuery * 24,
                          height: globals.widthMediaQuery * 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ref.read(selectedOviGenderProvider) ==
                                      'Unknown'
                                  ? AppColors.primary20
                                  : AppColors.grayscale30,
                              width: ref.read(selectedOviGenderProvider) ==
                                      'Unknown'
                                  ? 6.0
                                  : 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: globals.heightMediaQuery * 12,
                      bottom: globals.heightMediaQuery * 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        ref
                            .read(selectedOviGenderProvider.notifier)
                            .update((state) => 'Male');
                        showAdditionalFields = false;
                      });
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Male',
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                        ),
                        Container(
                          width: globals.widthMediaQuery * 24,
                          height: globals.widthMediaQuery * 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  ref.read(selectedOviGenderProvider) == 'Male'
                                      ? AppColors.primary20
                                      : AppColors.grayscale30,
                              width:
                                  ref.read(selectedOviGenderProvider) == 'Male'
                                      ? 6.0
                                      : 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: globals.heightMediaQuery * 12,
                      bottom: globals.heightMediaQuery * 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        ref
                            .read(selectedOviGenderProvider.notifier)
                            .update((state) => 'Female');
                        showAdditionalFields = true;
                        // Show additional fields when Female is selected
                      });
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Female',
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                        ),
                        Container(
                          width: globals.widthMediaQuery * 24,
                          height: globals.widthMediaQuery * 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ref.read(selectedOviGenderProvider) ==
                                      'Female'
                                  ? AppColors.primary20
                                  : AppColors.grayscale30,
                              width: ref.read(selectedOviGenderProvider) ==
                                      'Female'
                                  ? 6.0
                                  : 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: globals.heightMediaQuery * 16),
                const Divider(
                  color: AppColors.grayscale20,
                ),
                SizedBox(height: globals.heightMediaQuery * 16),
                if (showAdditionalFields) // Show additional fields when Female is selected
                  Visibility(
                    visible: selectedAnimalType == 'Oviparous',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Frequency Of Laying Eggs/Month',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          onChanged: (value) {
                            ref
                                .read(layingFrequencyProvider.notifier)
                                .update((state) => value);
                          },
                          controller: _frequencyEggsController,
                          decoration: InputDecoration(
                            hintText:
                                'Enter Frequency', // Add your hint text here
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                          ),
                          textInputAction: TextInputAction
                              .done, // Change the keyboard action
                        ),
                        // Your first additional text field widget here
                        const SizedBox(height: 10),
                        const Text(
                          'Number Of Eggs/Month',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          onChanged: (value) {
                            ref
                                .read(eggsPerMonthProvider.notifier)
                                .update((state) => value);
                          },
                          controller: _numberofEggsController,
                          decoration: InputDecoration(
                            hintText:
                                'Enter The Number', // Add your hint text here
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                          ),
                          textInputAction: TextInputAction
                              .done, // Change the keyboard action
                        ),
                        const SizedBox(height: 15),
                        const Divider(),
                        // Your second additional text field widget here
                      ],
                    ),
                  ),
                if (showAdditionalFields) // Show additional fields when Female is selected
                  Visibility(
                    visible: selectedAnimalType == 'Mammal',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: globals.heightMediaQuery * 16,
                        ),
                        Text(
                          "Breeding Stage",
                          style:
                              AppFonts.headline2(color: AppColors.grayscale90),
                        ),
                        SizedBox(
                          height: globals.heightMediaQuery * 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: globals.heightMediaQuery * 12,
                            bottom: globals.heightMediaQuery * 12,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              ref
                                  .read(selectedBreedingStageProvider.notifier)
                                  .update((state) => 'Ready For Breeding');
                              setState(() {
                                selectedBreedingStage = 'Ready For Breeding';
                              });
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Ready For Breeding',
                                    style: AppFonts.body2(
                                        color: AppColors.grayscale90),
                                  ),
                                ),
                                Container(
                                  width: globals.widthMediaQuery * 24,
                                  height: globals.widthMediaQuery * 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: ref.read(
                                                  selectedBreedingStageProvider) ==
                                              'Ready For Breeding'
                                          ? AppColors.primary20
                                          : AppColors.grayscale30,
                                      width: ref.read(
                                                  selectedBreedingStageProvider) ==
                                              'Ready For Breeding'
                                          ? 6.0
                                          : 1.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: globals.heightMediaQuery * 12,
                            bottom: globals.heightMediaQuery * 12,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              ref
                                  .read(selectedBreedingStageProvider.notifier)
                                  .update((state) => 'Pregnant');
                              setState(() {
                                selectedBreedingStage = 'Pregnant';
                              });
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Pregnant',
                                    style: AppFonts.body2(
                                        color: AppColors.grayscale90),
                                  ),
                                ),
                                Container(
                                  width: globals.widthMediaQuery * 24,
                                  height: globals.widthMediaQuery * 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: ref.read(
                                                  selectedBreedingStageProvider) ==
                                              'Pregnant'
                                          ? AppColors.primary20
                                          : AppColors.grayscale30,
                                      width: ref.read(
                                                  selectedBreedingStageProvider) ==
                                              'Pregnant'
                                          ? 6.0
                                          : 1.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: globals.heightMediaQuery * 12,
                            bottom: globals.heightMediaQuery * 12,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              ref
                                  .read(selectedBreedingStageProvider.notifier)
                                  .update((state) => 'Lactating');
                              setState(() {
                                selectedBreedingStage = 'Lactating';
                              });
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Lactating',
                                    style: AppFonts.body2(
                                        color: AppColors.grayscale90),
                                  ),
                                ),
                                Container(
                                  width: globals.widthMediaQuery * 24,
                                  height: globals.widthMediaQuery * 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: ref.read(
                                                  selectedBreedingStageProvider) ==
                                              'Lactating'
                                          ? AppColors.primary20
                                          : AppColors.grayscale30,
                                      width: ref.read(
                                                  selectedBreedingStageProvider) ==
                                              'Lactating'
                                          ? 6.0
                                          : 1.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.019),
                        const Divider(),
                      ],
                    ),
                  ),
                SizedBox(height: globals.heightMediaQuery * 16),
                Text(
                  "Dates",
                  style: AppFonts.headline2(color: AppColors.grayscale90),
                ),
                SizedBox(height: globals.heightMediaQuery * 24),
                const PrimaryDateField(
                  hintText: 'DD.MM.YYYY',
                  labelText: 'Date of Birth',
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.029),
                _buildOviDateFields(),
                Row(
                  children: [
                    PrimaryTextButton(
                      onPressed: () {
                        _showDateSelectionSheet(context);
                      },
                      status: TextStatus.idle,
                      text: 'Add Date',
                    ),
                    const Icon(Icons.add_rounded,
                        color: AppColors.primary40, size: 20),
                  ],
                ),
                const Divider(
                  color: AppColors.grayscale20,
                ),
                SizedBox(height: globals.heightMediaQuery * 16),
                Text(
                  "Add Tag",
                  style: AppFonts.headline2(color: AppColors.grayscale90),
                ),
                SizedBox(height: globals.heightMediaQuery * 16),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: chips.map((chip) {
                    return CustomTag(
                      label: chip,
                      selected: true, // Since these are selected chips
                      onTap: () {
                        setState(() {
                          chips.remove(chip); // To deselect the chip
                        });
                      },
                    );
                  }).toList(),
                ),
                Row(
                  children: [
                    PrimaryTextButton(
                      onPressed: () {
                        _animalTagsModalSheet();
                      },
                      status: TextStatus.idle,
                      text: 'Add Tags',
                    ),
                    const Icon(Icons.add_rounded,
                        color: AppColors.primary40, size: 20),
                  ],
                ),
                const Divider(
                  color: AppColors.grayscale20,
                ),
                SizedBox(height: globals.heightMediaQuery * 16),
                Text(
                  "Custom Fields",
                  style: AppFonts.headline2(color: AppColors.grayscale90),
                ),
                Text(
                  "Add Custom Fields If Needed",
                  style: AppFonts.body2(color: AppColors.grayscale60),
                ),
                SizedBox(height: globals.heightMediaQuery * 16),
                Column(
                  children: customFields,
                ),
                Row(
                  children: [
                    PrimaryTextButton(
                      onPressed: () {
                        _showOviFieldNameModal(context);
                      },
                      status: TextStatus.idle,
                      text: 'Add Custom Fields',
                    ),
                    SizedBox(width: globals.widthMediaQuery * 8),
                    const Icon(Icons.add_rounded,
                        color: AppColors.primary40, size: 20),
                  ],
                ),
                const Divider(
                  color: AppColors.grayscale20,
                ),
                SizedBox(height: globals.heightMediaQuery * 16),
                Text(
                  'Additional Notes',
                  style: AppFonts.headline2(color: AppColors.grayscale90),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ParagraphTextField(
                  hintText: 'Add Any Additional Notes if Needed',
                  maxLines: 8,
                  onChanged: (value) {
                    ref
                        .read(additionalnotesProvider.notifier)
                        .update((state) => value);
                  },
                ),
                SizedBox(height: globals.heightMediaQuery * 16),
                SizedBox(
                  height: 270,
                  width: double.infinity,
                  child: Focus(
                    onFocusChange:
                        (hasFocus) {}, // Dummy onFocusChange callback
                    child: const FileUploaderField(),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserListOfAnimals(
                    shouldAddAnimal: true,
                    breedingEvents: widget.breedingEvents,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 36, 86, 38),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOviDateFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ref
          .read(selectedOviDatesProvider.notifier)
          .state
          .keys
          .map((dateType) {
        final selectedDate =
            ref.read(selectedOviDatesProvider.notifier).state[dateType];
        if (selectedDate != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateType,
                style: AppFonts.caption2(
                  color: AppColors.grayscale90,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.grayscale00,
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(
                          color: AppColors.primary30,
                          width: 1.0,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _showOviDatePicker(context, dateType);
                        },
                        child: TextFormField(
                          enabled: false,
                          style: AppFonts.body2(color: AppColors.grayscale90),
                          decoration: InputDecoration(
                            hintText: 'DD:MM:YYYY',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                width: 0.2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _showOviDatePicker(context, dateType);
                              },
                              child: const Icon(
                                Icons.calendar_today_outlined,
                                color: Color.fromARGB(255, 36, 86, 38),
                              ),
                            ),
                          ),
                          readOnly: true,
                          controller: TextEditingController(
                            text: DateFormat('dd-MM-yyyy').format(selectedDate),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        ref.read(selectedOviDatesProvider)[dateType] = null;
                      });
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          );
        } else {
          return Container(); // Return an empty container if selectedDate is null
        }
      }).toList(),
    );
  }
}
