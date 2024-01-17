// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, unused_local_variable

import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../../../data/classes.dart';
import '../../../data/riverpod_globals.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../../widgets/controls_and_buttons/buttons/sar_buttonwidget.dart';
import '../../../widgets/controls_and_buttons/tags/custom_tags.dart';
import '../../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../../widgets/inputs/paragraph_text_fields/edit_paragraph_text_field.dart';
import '../../../widgets/inputs/text_fields/primary_text_field.dart';
import '../drow_up_animal_breed.dart';
import '../drow_up_animal_species.dart';
import '../sar_listofanimals.dart';

class EditAnimalGenInfo extends ConsumerStatefulWidget {
  final OviVariables OviDetails;
  final List<BreedingEventVariables> breedingEvents;

  const EditAnimalGenInfo(
      {super.key, required this.breedingEvents, required this.OviDetails});

  @override
  _EditAnimalGenInfoState createState() => _EditAnimalGenInfoState();
}

class _EditAnimalGenInfoState extends ConsumerState<EditAnimalGenInfo> {
  late String selectedAnimalType = widget.OviDetails.selectedAnimalType;
  late String selectedOviGender = widget.OviDetails.selectedOviGender;
  late String selectedBreedingStage = widget.OviDetails.selectedBreedingStage;

  final TextEditingController animalNameController = TextEditingController();

  final TextEditingController medicalNeedsController = TextEditingController();
  final TextEditingController animalTypeController = TextEditingController();
  final TextEditingController animalSpeciesController = TextEditingController();
  final TextEditingController animalBreedController = TextEditingController();
  final TextEditingController layingFrequencyController =
      TextEditingController();
  final TextEditingController animalSireController = TextEditingController();
  final TextEditingController animalDamController = TextEditingController();
  final TextEditingController eggsPerMonthController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController fieldNameController = TextEditingController();
  final TextEditingController fieldContentController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  // final TextEditingController selectedOviGenderController =
  //     TextEditingController();
  final TextEditingController selectedAnimalBreedController =
      TextEditingController();
  final TextEditingController selectedAnimalSpeciesController =
      TextEditingController();
  final TextEditingController selectedAnimalTypeController =
      TextEditingController();
  final TextEditingController selectedBreedingStageController =
      TextEditingController();
  late ImageProvider? selectedOviImage = widget.OviDetails.selectedOviImage;
  Map<String, DateTime?> selectedOviDates = {}; // Add date fields here
  Map<String, String> animalImages = {
    'Mammal': 'assets/avatars/120px/Horse_avatar.png',
    'Oviparous': 'assets/avatars/120px/Duck.png',
  };
  late String selectedAnimalSpecies = widget.OviDetails.selectedAnimalSpecies;
  late String selectedAnimalBreeds = widget.OviDetails.selectedAnimalBreed;
  bool showAdditionalFields = false;
  @override
  void initState() {
    super.initState();

    // Initialize text controllers with widget values
    medicalNeedsController.text = widget.OviDetails.medicalNeeds;
    animalNameController.text = widget.OviDetails.animalName;
    medicalNeedsController.text = widget.OviDetails.medicalNeeds;
    // animalSireController.text = widget.OviDetails.selectedOviSire;
    // animalDamController.text = widget.OviDetails.selectedOviDam;
    selectedAnimalType = widget.OviDetails.selectedAnimalType;
    selectedAnimalSpecies = widget.OviDetails.selectedAnimalSpecies;
    selectedAnimalBreeds = widget.OviDetails.selectedAnimalBreed;
    layingFrequencyController.text = widget.OviDetails.layingFrequency;
    eggsPerMonthController.text = widget.OviDetails.eggsPerMonth;
    dateOfBirthController.text = widget.OviDetails.dateOfBirth;
    fieldNameController.text = widget.OviDetails.fieldName;
    fieldContentController.text = widget.OviDetails.fieldContent;
    notesController.text = widget.OviDetails.notes;
    selectedOviGender = widget.OviDetails.selectedOviGender;
    selectedAnimalBreedController.text = widget.OviDetails.selectedAnimalBreed;
    selectedAnimalSpeciesController.text =
        widget.OviDetails.selectedAnimalSpecies;
    selectedAnimalTypeController.text = widget.OviDetails.selectedAnimalType;
    selectedOviDates = widget.OviDetails.selectedOviDates;
    selectedBreedingStageController.text =
        widget.OviDetails.selectedBreedingStage;
    selectedOviImage = widget.OviDetails.selectedOviImage;
    selectedBreedingStage = widget.OviDetails.selectedBreedingStage;
  }

  List<String> modalMammalSpeciesList = [
    'Monkey',
    'Bear',
    'Tiger',
    'Giraffe',
    'Kangaroo',
    'Horse',
    'Zebra',
    'Panda',
  ];
  List<String> modalOviSpeciesList = [
    'Crocodile',
    'Eagle',
    'Frog',
    'Fish',
    'Penguin',
    'Alligator',
    'Salmon',
    'Gecko',
  ];
  Map<String, List<String>> morespeciesToBreedsMap = {
    'Dog': ['suhail', 'German Shepherd', 'Golden Retriever'],
    'Cat': ['Siamese', 'Persian', 'Maine Coon'],
    'Elephant': ['African Elephant', 'Asian Elephant'],
    'Lion': ['African Lion', 'Asiatic Lion'],
    'Duck': ['Mallard', 'Pekin', 'Khaki Campbell'],
    'Chicken': ['Rhode Island Red', 'Leghorn', 'Plymouth Rock'],
    'Turtle': ['Red-eared Slider', 'Snapping Turtle', 'Painted Turtle'],
    'Snake': ['Python', 'Cobra', 'Anaconda'],
    'Monkey': ['Chimpanzee', 'Gorilla', 'Orangutan'],
    'Bear': ['Grizzly Bear', 'Polar Bear', 'Black Bear'],
    'Tiger': ['Bengal Tiger', 'Siberian Tiger', 'Indochinese Tiger'],
    'Giraffe': ['Masai Giraffe', 'Reticulated Giraffe'],
    'Kangaroo': ['Red Kangaroo', 'Eastern Grey Kangaroo'],
    'Horse': ['Thoroughbred', 'Quarter Horse', 'Arabian Horse'],
    'Zebra': ['Plains Zebra', 'Grevy\'s Zebra'],
    'Panda': ['Giant Panda', 'Red Panda'],
    'Crocodile': ['Nile Crocodile', 'Saltwater Crocodile', 'Gharial'],
    'Eagle': ['Bald Eagle', 'Golden Eagle', 'Harpy Eagle'],
    'Frog': ['Bullfrog', 'Tree Frog', 'Poison Dart Frog'],
    'Fish': ['Goldfish', 'Guppy', 'Betta'],
    'Penguin': ['Emperor Penguin', 'Adelie Penguin', 'King Penguin'],
    'Alligator': ['American Alligator', 'Chinese Alligator'],
    'Salmon': ['Atlantic Salmon', 'Chinook Salmon', 'Coho Salmon'],
    'Gecko': ['Leopard Gecko', 'Crested Gecko', 'Tokay Gecko'],
  };

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      final selectedImage = FileImage(File(pickedFile.path));
      setState(() {
        selectedOviImage = selectedImage;
      });
    }
  }

  void _showDatePicker(BuildContext context, String fieldName) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate:
          widget.OviDetails.selectedOviDates[fieldName] ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        widget.OviDetails.selectedOviDates[fieldName] = pickedDate;
      });
    }
  }

  void _showDOBPicker(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      // ignore: unnecessary_null_comparison
      initialDate: widget.OviDetails.dateOfBirth.isNotEmpty
          ? DateFormat('dd/MM/yyyy').parse(widget.OviDetails.dateOfBirth)
          : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        dateOfBirthController.text =
            DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  Column _buildDateFields() {
    final dateFields = <Widget>[];
    final selectedOviDates = widget.OviDetails.selectedOviDates;

    final dateFormatter =
        DateFormat('dd/MM/yyyy'); // Define your desired date format

    selectedOviDates.forEach(
      (fieldName, selectedDate) {
        dateFields.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fieldName,
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
                          _showDatePicker(context, fieldName);
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
                                _showDatePicker(context, fieldName);
                              },
                              child: const Icon(
                                Icons.calendar_today_outlined,
                                color: Color.fromARGB(255, 36, 86, 38),
                              ),
                            ),
                          ),
                          readOnly: true,
                          controller: TextEditingController(
                            text: selectedDate != null
                                ? dateFormatter.format(selectedDate)
                                : "Select Date : DD/MM/YYYY",
                          ),
                        ),
                        // child: Text(fieldName),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.OviDetails.selectedOviDates[fieldName] = null;
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
          ),
        );
      },
    );

    return Column(
      children: dateFields,
    );
  }

// Set the initial value based on widget.OviDetails.dateOfBirth

  void _deleteAvatar() {
    ref.read(selectedAnimalImageProvider.notifier).update((state) => null);
    setState(() {
      selectedOviImage = null;
    });
  }

  void _changeAnimalImagepicker(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Camera',
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.grayscale50,
                      size: 30,
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Gallery',
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.grayscale50,
                      size: 30,
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delete Photo',
                      style: AppFonts.body2(color: AppColors.error100),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.grayscale50,
                      size: 30,
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  _deleteAvatar(); // Call a function to delete the avatar
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _editAnimalSpecies(
      String section, BuildContext context, List<String> speciesList) async {
    List<String> filteredModalList = List.from(speciesList);
    TextEditingController searchValue = TextEditingController();

    DrowupAnimalSpecies drowupAnimalSpecies = DrowupAnimalSpecies(
      searchValue: searchValue,
      filteredModalList: filteredModalList,
      modalAnimalSpeciesList: speciesList,
      setState: setState,
    );

    drowupAnimalSpecies.resetSelection();

    final selectedSpeciesValue = await showModalBottomSheet<String>(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return drowupAnimalSpecies;
      },
    );

    if (selectedSpeciesValue != null) {
      setState(() {
        ref
            .read(selectedAnimalSpeciesProvider.notifier)
            .update((state) => selectedSpeciesValue);
        selectedAnimalSpecies = selectedSpeciesValue;
      });
    }
  }

  void _editAnimalBreed(String section, BuildContext context) async {
    List<String> filteredBreedList =
        List.from(morespeciesToBreedsMap[selectedAnimalSpecies] ?? []);
    TextEditingController searchValue = TextEditingController();

    DrowupAnimalBreed drowupAnimalBreed = DrowupAnimalBreed(
      searchValue: searchValue,
      filteredBreedList: filteredBreedList,
      setState: setState,
      morespeciesToBreedsMap: morespeciesToBreedsMap,
      selectedAnimalSpecies: selectedAnimalSpecies,
    );

    drowupAnimalBreed.resetSelection();

    final selectedBreedValue = await showModalBottomSheet<String>(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return drowupAnimalBreed;
      },
    );

    if (selectedBreedValue != null) {
      setState(() {
        ref
            .read(selectedAnimalSpeciesProvider.notifier)
            .update((state) => selectedBreedValue);
        selectedAnimalBreeds = selectedBreedValue;
      });
    }
  }

  void _editAnimalType(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Animal Type',
                style: AppFonts.title3(color: AppColors.grayscale90),
              ),
              SizedBox(height: globals.heightMediaQuery * 32),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundImage: AssetImage(animalImages['Mammal']!),
                ),
                title: Text('Mammal',
                    style: AppFonts.body2(color: AppColors.grayscale90)),
                trailing: Container(
                  width: globals.widthMediaQuery * 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selectedAnimalType == 'Mammal'
                          ? AppColors.primary20
                          : AppColors.grayscale30,
                      width: selectedAnimalType == 'Mammal' ? 6.0 : 1.0,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    ref
                        .read(selectedAnimalTypeProvider.notifier)
                        .update((state) => 'Mammal');
                    selectedAnimalType = 'Mammal';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundImage: AssetImage(animalImages['Oviparous']!),
                ),
                title: Text('Oviparous',
                    style: AppFonts.body2(color: AppColors.grayscale90)),
                trailing: Container(
                  width: globals.widthMediaQuery * 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selectedAnimalType == 'Oviparous'
                          ? AppColors.primary20
                          : AppColors.grayscale30,
                      width: selectedAnimalType == 'Oviparous' ? 6.0 : 1.0,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    ref
                        .read(selectedAnimalTypeProvider.notifier)
                        .update((state) => 'Oviparous');
                    selectedAnimalType = 'Oviparous';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _animalTagsModalSheet() async {
    final result = await showModalBottomSheet(
      context: context,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Current State',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Current State',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
                      const Text(
                        'Medical State',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
                      const Text(
                        'Other',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 40.0),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle the button press here
                                Navigator.of(context).pop(ref.read(
                                    selectedOviChipsProvider)); // Close the modal
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                    255, 36, 86, 38), // Button color
                                foregroundColor: Colors.white, // Text color
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: const Text('Save'), // Button text
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
    setState(() {

    });

// Inside _animalTagsModalSheet:
    if (result != null) {}
  }

  void _showOviFieldNameModal(BuildContext context) {
    // TextEditingController fieldname = TextEditingController();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0,
              bottom: 16 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  controller: fieldNameController),
              //SizedBox(height: globals.heightMediaQuery * 130),
              const SizedBox(height: 32,),
              ButtonWidget(
                onPressed: () {
                  Navigator.pop(context);
                  _showOviFieldContentModal(context);
                },
                buttonText: 'Confirm',
              ),
              const SizedBox(
                height: 8,
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
        );
      },
    );
  }

  void _showOviFieldContentModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0,
              bottom: 16.0 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
              SizedBox(
                height: 116,
                child: TextField(
                  maxLines: 5,
                  controller: fieldContentController,
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
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              ButtonWidget(
                onPressed: () {
                  Navigator.pop(context);
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final chips = ref.watch(selectedOviChipsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Edit ',
              style: AppFonts.headline3(color: AppColors.grayscale90),
            ),
            Text(
              animalNameController.text,
              style: AppFonts.headline3(color: AppColors.grayscale90),
            ),
          ],
        ),
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              color: AppColors.grayscale10,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.width * 0.1,
              decoration: BoxDecoration(
                color: AppColors.grayscale10,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.close_rounded, color: Colors.black),
            ),
            onPressed: () {
              // Handle close button press
              Navigator.pop(context);
            },
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
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey[100],
                  backgroundImage: selectedOviImage,
                  child: selectedOviImage == null
                      ? const Icon(
                          Icons.camera_alt_outlined,
                          size: 50,
                          color: Colors.grey,
                        )
                      : null,
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    _changeAnimalImagepicker(context);
                  },
                  child: const Text(
                    'Change Photo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 36, 86, 38),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.020),
              PrimaryTextField(
                  labelText: 'Name',
                  hintText: 'Enter Name',
                  controller: animalNameController),
              SizedBox(height: MediaQuery.of(context).size.height * 0.029),
              GestureDetector(
                onTap: () {
                  _editAnimalType(context);
                },
                child: Row(
                  children: [
                    Text(
                      'Animal Type',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    const Spacer(),
                    Text(
                      selectedAnimalType,
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                    SizedBox(
                      width: globals.widthMediaQuery * 8,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: AppColors.primary40,
                        size: globals.widthMediaQuery * 12.75),
                  ],
                ),
              ),
              SizedBox(height: globals.heightMediaQuery * 24),
              GestureDetector(
                onTap: () {
                  if (selectedAnimalType == 'Mammal') {
                    _editAnimalSpecies(
                        'species', context, modalMammalSpeciesList);
                  } else {
                    _editAnimalSpecies('species', context, modalOviSpeciesList);
                  }
                },
                child: Row(
                  children: [
                    Text(
                      'Animal Species',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    const Spacer(),
                    Text(
                      selectedAnimalSpecies,
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                    SizedBox(
                      width: globals.widthMediaQuery * 8,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: AppColors.primary40,
                        size: globals.widthMediaQuery * 12.75),
                  ],
                ),
              ),
              SizedBox(height: globals.heightMediaQuery * 24),
              InkWell(
                onTap: () {
                  _editAnimalBreed('breeds', context);
                },
                child: Row(
                  children: [
                    Text(
                      'Animal Breed',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    const Spacer(),
                    Text(
                      selectedAnimalBreeds,
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                    SizedBox(
                      width: globals.widthMediaQuery * 8,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: AppColors.primary40,
                        size: globals.widthMediaQuery * 12.75),
                  ],
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
                      selectedOviGender = 'Unknown';

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
                            color: selectedOviGender == 'Unknown'
                                ? AppColors.primary20
                                : AppColors.grayscale30,
                            width: selectedOviGender == 'Unknown' ? 6.0 : 1.0,
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
                      selectedOviGender = 'Male';

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
                            color: selectedOviGender == 'Male'
                                ? AppColors.primary20
                                : AppColors.grayscale30,
                            width: selectedOviGender == 'Male' ? 6.0 : 1.0,
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
                      selectedOviGender = 'Female';
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
                            color: selectedOviGender == 'Female'
                                ? AppColors.primary20
                                : AppColors.grayscale30,
                            width: selectedOviGender == 'Female' ? 6.0 : 1.0,
                          ),
                        ),
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
              Visibility(
                visible: selectedAnimalType == 'Oviparous' &&
                    selectedOviGender == "Female",
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
                      controller: layingFrequencyController,
                      decoration: InputDecoration(
                        hintText: 'Enter Frequency', // Add your hint text here
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                      ),
                      textInputAction:
                          TextInputAction.done, // Change the keyboard action
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
                      controller: eggsPerMonthController,
                      decoration: InputDecoration(
                        hintText: 'Enter The Number', // Add your hint text here
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                      ),
                      textInputAction:
                          TextInputAction.done, // Change the keyboard action
                    ),
                    const SizedBox(height: 15),
                    const Divider(),
                    // Your second additional text field widget here
                  ],
                ),
              ),
              if (selectedOviGender == "Female")
                Visibility(
                  visible: selectedAnimalType == 'Mammal' &&
                      selectedOviGender == "Female",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: globals.heightMediaQuery * 16,
                      ),
                      Text(
                        "Breeding Stage",
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
                                    color: selectedBreedingStage ==
                                            'Ready For Breeding'
                                        ? AppColors.primary20
                                        : AppColors.grayscale30,
                                    width: selectedBreedingStage ==
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
                                    color: selectedBreedingStage == 'Pregnant'
                                        ? AppColors.primary20
                                        : AppColors.grayscale30,
                                    width: selectedBreedingStage == 'Pregnant'
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
                                    color: selectedBreedingStage == 'Lactating'
                                        ? AppColors.primary20
                                        : AppColors.grayscale30,
                                    width: selectedBreedingStage == 'Lactating'
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
              Text(
                "Dates",
                style: AppFonts.headline2(color: AppColors.grayscale90),
              ),
              SizedBox(height: globals.heightMediaQuery * 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date Of Birth',
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
                              _showDOBPicker(context);
                            },
                            child: TextFormField(
                                enabled: false,
                                style: AppFonts.body2(
                                    color: AppColors.grayscale90),
                                decoration: InputDecoration(
                                  hintText: 'DD/MM/YYYY',
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
                                      _showDOBPicker(context);
                                    },
                                    child: const Icon(
                                      Icons.calendar_today_outlined,
                                      color: Color.fromARGB(255, 36, 86, 38),
                                    ),
                                  ),
                                ),
                                readOnly: true,
                                controller: dateOfBirthController),
                            // child: Text(fieldName),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              _buildDateFields(),
              Row(
                children: [
                  PrimaryTextButton(
                    onPressed: () {
                      _showDateSelectionSheet(context, selectedAnimalType);
                    },
                    status: TextStatus.idle,
                    text: 'Add Date',
                  ),
                  const Icon(Icons.add_rounded,
                      color: AppColors.primary40, size: 20),
                ],
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
                "Add Tag",
                style: AppFonts.headline2(color: AppColors.grayscale90),
              ),
              SizedBox(
                height: globals.heightMediaQuery * 16,
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: chips.map((chip) {
                  return CustomTag(
                    label: chip,
                    selected: true, // Since these are selected chips
                    onTap: () {},
                  );
                }).toList(),
              ),
              SizedBox(
                height: globals.heightMediaQuery * 16,
              ),
              InkWell(
                onTap: () {
                  _animalTagsModalSheet();
                },
                child: const Text(
                  'Add Tags +',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 36, 86, 38),
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
                "Custom fields",
                style: AppFonts.headline2(color: AppColors.grayscale90),
              ),
              SizedBox(
                height: globals.heightMediaQuery * 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fieldNameController.text,
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
                              color: AppColors.grayscale20,
                              width: 1.0,
                            ),
                          ),
                          child: TextFormField(
                              // enabled: false,
                              style:
                                  AppFonts.body2(color: AppColors.grayscale90),
                              decoration: InputDecoration(
                                hintText: 'Enter Field Content',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 16.0),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _showOviFieldNameModal(context);
                                  },
                                  child: Image.asset(
                                      'assets/icons/frame/24px/edit_icon_button.png'),
                                ),
                              ),
                              readOnly: true,
                              controller: fieldContentController),
                        ),
                      ),
                    ],
                  ),
                ],
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
                "Additional Notes",
                style: AppFonts.headline2(color: AppColors.grayscale90),
              ),
              SizedBox(
                height: globals.heightMediaQuery * 16,
              ),
              EditParagraphTextField(
                hintText: 'Add Any Additional Notes if Needed',
                maxLines: 8,
                notesController: notesController,
              ),
              SizedBox(
                height: globals.heightMediaQuery * 16,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            final updatedOviDetails = widget.OviDetails.copyWith(
              animalName: animalNameController.text,
              notes: notesController.text,
              selectedAnimalType: selectedAnimalType,
              selectedAnimalSpecies: selectedAnimalSpecies,
              selectedAnimalBreed: selectedAnimalBreeds,
              selectedOviGender: selectedOviGender,
              // selectedOviSire: animalSireController.text,
              // selectedOviDam: animalDamController.text,
              selectedBreedingStage: selectedBreedingStage,
              fieldName: fieldNameController.text,
              fieldContent: fieldContentController.text,
              layingFrequency: layingFrequencyController.text,
              eggsPerMonth: eggsPerMonthController.text,
              dateOfBirth: dateOfBirthController.text,

              selectedOviDates: selectedOviDates,
              selectedOviImage: selectedOviImage,
            );

            final oviAnimals = ref.read(ovianimalsProvider);
            final index = oviAnimals.indexOf(widget.OviDetails);
            if (index >= 0) {
              oviAnimals[index] = updatedOviDetails;
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserListOfAnimals(
                  shouldAddAnimal: false,
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
            'Save Changes',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _showDateSelectionSheet(BuildContext context, selectedAnimalType) async {
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                            _showDatePicker(context, OvidateTypes[index]);
                          },
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
              ),
            if (selectedAnimalType == "Mammal")
              Column(
                mainAxisSize: MainAxisSize.min,
                children: MammaldateTypes.map((dateType) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(dateType),
                        dense: true,
                        minVerticalPadding: double.minPositive,
                        trailing: const Icon(Icons.arrow_right_alt_rounded),
                        onTap: () {
                          Navigator.pop(context);
                          _showDatePicker(
                              context, dateType);
                        },
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              ),
          ],
        );
      },
    );
  }
}
