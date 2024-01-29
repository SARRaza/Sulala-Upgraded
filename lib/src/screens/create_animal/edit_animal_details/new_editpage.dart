// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, unused_local_variable

import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import 'package:sulala_upgrade/src/widgets/animal_info_modal_sheets.dart/animal_tags_modal.dart';
import '../../../data/classes.dart';
import '../../../data/riverpod_globals.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../../widgets/controls_and_buttons/buttons/sar_buttonwidget.dart';
import '../../../widgets/controls_and_buttons/tags/custom_tags.dart';
import '../../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../../widgets/inputs/paragraph_text_fields/edit_paragraph_text_field.dart';
import '../../../widgets/inputs/text_fields/primary_text_field.dart';
import '../drow_up_animal_breed.dart';
import '../drow_up_animal_species.dart';
import '../sar_listofanimals.dart';

class EditAnimalGenInfo extends ConsumerStatefulWidget {
  final int animalId;
  final List<BreedingEventVariables> breedingEvents;

  const EditAnimalGenInfo(
      {super.key, required this.breedingEvents, required this.animalId});

  @override
  _EditAnimalGenInfoState createState() => _EditAnimalGenInfoState();
}

class _EditAnimalGenInfoState extends ConsumerState<EditAnimalGenInfo> {
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

  late OviVariables animalDetails;
  final Map<String, String> _animalImages = {
    'Mammal': 'assets/avatars/120px/Horse_avatar.png',
    'Oviparous': 'assets/avatars/120px/Duck.png',
  };
  bool showAdditionalFields = false;

  final _fieldNameController = TextEditingController();
  final _fieldContentController = TextEditingController();

  late TextEditingController _animalNameController;

  late TextEditingController _notesController;

  late List<File>? uploadedFiles;
  
  @override
  void initState() {
    animalDetails = ref.read(ovianimalsProvider).firstWhere((animal) => animal
        .id == widget.animalId);
    uploadedFiles = animalDetails.files;
    _animalNameController = TextEditingController(
        text: animalDetails.animalName);
    _animalNameController.addListener(() {
      animalDetails = animalDetails.copyWith(animalName: _animalNameController
          .text);
    });
    _notesController = TextEditingController(text: animalDetails.notes);
    _notesController.addListener(() {
      animalDetails = animalDetails.copyWith(notes: _notesController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              animalDetails.animalName,
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
                  backgroundImage: animalDetails.selectedOviImage,
                  child: animalDetails.selectedOviImage == null
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
                  controller: _animalNameController),
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
                      animalDetails.selectedAnimalType,
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
                  if (animalDetails.selectedAnimalType == 'Mammal') {
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
                      animalDetails.selectedAnimalSpecies,
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
                      animalDetails.selectedAnimalBreed,
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
                      animalDetails = animalDetails.copyWith(
                          selectedOviGender: 'Unknown');

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
                            color: animalDetails.selectedOviGender == 'Unknown'
                                ? AppColors.primary20
                                : AppColors.grayscale30,
                            width: animalDetails.selectedOviGender == 'Unknown'
                                ? 6.0 : 1.0,
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
                      animalDetails = animalDetails.copyWith(
                          selectedOviGender: 'Male');

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
                            color: animalDetails.selectedOviGender == 'Male'
                                ? AppColors.primary20
                                : AppColors.grayscale30,
                            width: animalDetails.selectedOviGender == 'Male'
                                ? 6.0 : 1.0,
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
                      animalDetails = animalDetails.copyWith(
                          selectedOviGender: 'Female');
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
                            color: animalDetails.selectedOviGender == 'Female'
                                ? AppColors.primary20
                                : AppColors.grayscale30,
                            width: animalDetails.selectedOviGender == 'Female'
                                ? 6.0 : 1.0,
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
                visible: animalDetails.selectedAnimalType == 'Oviparous' &&
                    animalDetails.selectedOviGender == "Female",
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
                        animalDetails = animalDetails.copyWith(
                            layingFrequency: value);
                      },
                      initialValue: animalDetails.layingFrequency,
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
                        animalDetails = animalDetails.copyWith(
                            eggsPerMonth: value);
                      },
                      initialValue: animalDetails.eggsPerMonth,
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
              if (animalDetails.selectedOviGender == "Female")
                Visibility(
                  visible: animalDetails.selectedAnimalType == 'Mammal' &&
                      animalDetails.selectedOviGender == "Female",
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
                            setState(() {
                              animalDetails = animalDetails.copyWith(
                                  selectedBreedingStage: 'Ready For Breeding');
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
                                    color: animalDetails.selectedBreedingStage
                                        == 'Ready For Breeding'
                                        ? AppColors.primary20
                                        : AppColors.grayscale30,
                                    width: animalDetails.selectedBreedingStage
                                        == 'Ready For Breeding'
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
                            setState(() {
                              animalDetails = animalDetails.copyWith(
                                  selectedBreedingStage: 'Pregnant');
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
                                    color: animalDetails.selectedBreedingStage
                                        == 'Pregnant'
                                        ? AppColors.primary20
                                        : AppColors.grayscale30,
                                    width: animalDetails.selectedBreedingStage
                                        == 'Pregnant'
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
                            setState(() {
                              animalDetails = animalDetails.copyWith(
                                  selectedBreedingStage: 'Lactating');
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
                                    color: animalDetails.selectedBreedingStage
                                        == 'Lactating'
                                        ? AppColors.primary20
                                        : AppColors.grayscale30,
                                    width: animalDetails.selectedBreedingStage
                                        == 'Lactating'
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
                              initialValue: animalDetails.dateOfBirth,),
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
                      _showDateSelectionSheet(context, animalDetails
                          .selectedAnimalType);
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
                children: animalDetails.selectedOviChips.map((chip) {
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
              Text(
                "Add Custom Fields If Needed",
                style: AppFonts.body2(color: AppColors.grayscale60),
              ),
              SizedBox(height: globals.heightMediaQuery * 16),
              Column(
                children: animalDetails.customFields == null ? []
                    : animalDetails.customFields!.keys.map((fieldName) => Column(
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
                            onPressed: () => _removeCustomField(fieldName)
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
                      controller: TextEditingController(text: animalDetails
                          .customFields![fieldName]),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),).toList(),
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
                notesController: _notesController,
              ),
              SizedBox(
                height: globals.heightMediaQuery * 16,
              ),
              FileUploaderField(
                uploadedFiles: uploadedFiles?.map((file) => file.path)
                    .toList(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {

            final oviAnimals = ref.read(ovianimalsProvider);
            final index = oviAnimals.indexWhere((animal) => animal.id == widget
                .animalId);
            animalDetails = animalDetails.copyWith(
              files: ref.read(uploadedFilesProvider).map((path) => File(path))
                  .toList()
            );
            if (index >= 0) {
              oviAnimals[index] = animalDetails;
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


  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      final selectedImage = FileImage(File(pickedFile.path));
      setState(() {
        animalDetails = animalDetails.copyWith(selectedOviImage: selectedImage);
      });
    }
  }

  void _showDatePicker(BuildContext context, String fieldName) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: animalDetails.selectedOviDates[fieldName] ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        animalDetails.selectedOviDates[fieldName] = pickedDate;
      });
    }
  }

  void _showDOBPicker(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      // ignore: unnecessary_null_comparison
      initialDate: animalDetails.dateOfBirth.isNotEmpty
          ? DateFormat('dd/MM/yyyy').parse(animalDetails.dateOfBirth)
          : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        animalDetails = animalDetails.copyWith(dateOfBirth: DateFormat('dd/MM/yyyy').format(pickedDate));
      });
    }
  }

  Column _buildDateFields() {
    final dateFields = <Widget>[];
    final selectedOviDates = animalDetails.selectedOviDates;

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
                        animalDetails.selectedOviDates[fieldName] = null;
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

// Set the initial value based on animalDetails.dateOfBirth

  void _deleteAvatar() {
    ref.read(selectedAnimalImageProvider.notifier).update((state) => null);
    setState(() {
      animalDetails = animalDetails.copyWith(selectedOviImage: null);
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
        animalDetails = animalDetails.copyWith(
            selectedAnimalSpecies: selectedSpeciesValue);
      });
    }
  }

  void _editAnimalBreed(String section, BuildContext context) async {
    List<String> filteredBreedList =
        List.from(morespeciesToBreedsMap[animalDetails.selectedAnimalSpecies] ??
            []);
    TextEditingController searchValue = TextEditingController();

    DrowupAnimalBreed drowupAnimalBreed = DrowupAnimalBreed(
      searchValue: searchValue,
      filteredBreedList: filteredBreedList,
      setState: setState,
      morespeciesToBreedsMap: morespeciesToBreedsMap,
      selectedAnimalSpecies: animalDetails.selectedAnimalSpecies,
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
        animalDetails = animalDetails.copyWith(
            selectedAnimalBreed: selectedBreedValue);
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
                  backgroundImage: AssetImage(_animalImages['Mammal']!),
                ),
                title: Text('Mammal',
                    style: AppFonts.body2(color: AppColors.grayscale90)),
                trailing: Container(
                  width: globals.widthMediaQuery * 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: animalDetails.selectedAnimalType == 'Mammal'
                          ? AppColors.primary20
                          : AppColors.grayscale30,
                      width: animalDetails.selectedAnimalType == 'Mammal' ? 6.0
                          : 1.0,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    ref
                        .read(selectedAnimalTypeProvider.notifier)
                        .update((state) => 'Mammal');
                    animalDetails = animalDetails.copyWith(
                        selectedAnimalType: 'Mammal');
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundImage: AssetImage(_animalImages['Oviparous']!),
                ),
                title: Text('Oviparous',
                    style: AppFonts.body2(color: AppColors.grayscale90)),
                trailing: Container(
                  width: globals.widthMediaQuery * 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: animalDetails.selectedAnimalType == 'Oviparous'
                          ? AppColors.primary20
                          : AppColors.grayscale30,
                      width: animalDetails.selectedAnimalType == 'Oviparous'
                          ? 6.0 : 1.0,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    ref
                        .read(selectedAnimalTypeProvider.notifier)
                        .update((state) => 'Oviparous');
                    animalDetails = animalDetails.copyWith(
                        selectedAnimalType: 'Oviparous');
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
      builder: (context) => AnimalTagsModal(selectedTags: animalDetails.selectedOviChips)
    );
    setState(() {
      animalDetails = animalDetails.copyWith(selectedOviChips: result);
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
                  controller: _fieldNameController),
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
                  controller: _fieldContentController,
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
                  setState(() {
                    if(animalDetails.customFields == null) {
                      animalDetails = animalDetails.copyWith(customFields: {});
                    }
                    animalDetails.customFields![_fieldNameController.text] = _fieldContentController.text;
                  });
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

  _removeCustomField(String fieldName) {
    setState(() {
      animalDetails.customFields?.remove(fieldName);
    });
  }
}
