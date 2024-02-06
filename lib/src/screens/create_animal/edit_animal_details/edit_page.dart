import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/widgets/animal_info_modal_sheets.dart/animal_tags_modal.dart';
import '../../../data/classes/breeding_event_variables.dart';
import '../../../data/classes/ovi_variables.dart';
import '../../../data/riverpod_globals.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../../widgets/controls_and_buttons/buttons/sar_button_widget.dart';
import '../../../widgets/controls_and_buttons/tags/custom_tags.dart';
import '../../../widgets/controls_and_buttons/text_buttons/primary_text_button.dart';
import '../../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../../widgets/inputs/paragraph_text_fields/edit_paragraph_text_field.dart';
import '../../../widgets/inputs/text_fields/primary_text_field.dart';
import '../draw_up_animal_breed.dart';
import '../draw_up_animal_species.dart';

class EditAnimalGenInfo extends ConsumerStatefulWidget {
  final int animalId;
  final List<BreedingEventVariables> breedingEvents;

  const EditAnimalGenInfo(
      {super.key, required this.breedingEvents, required this.animalId});

  @override
  ConsumerState<EditAnimalGenInfo> createState() => _EditAnimalGenInfoState();
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
  Map<String, List<String>> moreSpeciesToBreedsMap = {
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

  final Map<String, String> _animalImages = {
    'Mammal': 'assets/avatars/120px/Horse_avatar.png',
    'Oviparous': 'assets/avatars/120px/Duck.png',
  };
  bool showAdditionalFields = false;

  final _fieldNameController = TextEditingController();
  final _fieldContentController = TextEditingController();

  late final TextEditingController _animalNameController;
  late final TextEditingController _notesController;
  late final TextEditingController _birthDayController;
  late List<File>? uploadedFiles;
  late ImageProvider? selectedOviImage;
  late String selectedAnimalType;
  late String selectedAnimalSpecies;
  late String selectedAnimalBreed;
  late String selectedOviGender;
  late final TextEditingController _layingFrequencyController;
  late final TextEditingController _eggsNumberController;
  late String selectedBreedingStage;
  late List<String> selectedOviChips;
  late Map<String, String>? customFields;
  late Map<String, DateTime?> selectedOviDates;

  @override
  void initState() {
    super.initState();

    final animalProvider = ref.read(oviAnimalsProvider);
    final animalIndex =
        animalProvider.indexWhere((animal) => animal.id == widget.animalId);
    final animalDetails = animalProvider[animalIndex];

    // Initialize controllers with appropriate values
    _animalNameController =
        TextEditingController(text: animalDetails.animalName);
    _notesController = TextEditingController(text: animalDetails.notes);
    _birthDayController = TextEditingController();
    if (animalDetails.dateOfBirth != null) {
      _birthDayController.text =
          DateFormat('dd/MM/yyyy').format(animalDetails.dateOfBirth!);
    }
    _layingFrequencyController =
        TextEditingController(text: animalDetails.layingFrequency);
    _eggsNumberController =
        TextEditingController(text: animalDetails.eggsPerMonth);

    // Initialize other variables directly
    uploadedFiles = animalDetails.files;
    selectedOviImage = animalDetails.selectedOviImage;
    selectedAnimalType = animalDetails.selectedAnimalType;
    selectedAnimalSpecies = animalDetails.selectedAnimalSpecies;
    selectedAnimalBreed = animalDetails.selectedAnimalBreed;
    selectedOviGender = animalDetails.selectedOviGender;
    selectedBreedingStage = animalDetails.selectedBreedingStage;
    selectedOviChips = animalDetails.selectedOviChips;
    customFields = animalDetails.customFields;
    selectedOviDates = animalDetails.selectedOviDates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 130),
              child: Text(
                'editAnimal'.trParams({'name': _animalNameController.text}),
                style: AppFonts.headline3(color: AppColors.grayscale90),
                overflow: TextOverflow.ellipsis,
              ),
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
              left: SizeConfig.widthMultiplier(context) * 16,
              right: SizeConfig.widthMultiplier(context) * 16),
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
                    _showAnimalImagePicker(context);
                  },
                  child: Text(
                    'Change Photo'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 36, 86, 38),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.020),
              PrimaryTextField(
                  labelText: 'Name'.tr,
                  hintText: 'Enter Name'.tr,
                  controller: _animalNameController),
              SizedBox(height: MediaQuery.of(context).size.height * 0.029),
              GestureDetector(
                onTap: () {
                  _editAnimalType(context);
                },
                child: Row(
                  children: [
                    Text(
                      'Animal Type'.tr,
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    const Spacer(),
                    Text(
                      selectedAnimalType,
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier(context) * 8,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: AppColors.primary40,
                        size: SizeConfig.widthMultiplier(context) * 12.75),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
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
                      'Animal Species'.tr,
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    const Spacer(),
                    Text(
                      selectedAnimalSpecies,
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier(context) * 8,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: AppColors.primary40,
                        size: SizeConfig.widthMultiplier(context) * 12.75),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
              InkWell(
                onTap: () {
                  _editAnimalBreed('breeds', context);
                },
                child: Row(
                  children: [
                    Text(
                      'Animal Breed'.tr,
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    const Spacer(),
                    Text(
                      selectedAnimalBreed,
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier(context) * 8,
                    ),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: AppColors.primary40,
                        size: SizeConfig.widthMultiplier(context) * 12.75),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              const Divider(
                color: AppColors.grayscale20,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              Text(
                "Animal Sex".tr,
                style: AppFonts.headline2(color: AppColors.grayscale90),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.heightMultiplier(context) * 12,
                  bottom: SizeConfig.heightMultiplier(context) * 12,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOviGender = 'Unknown';

                      showAdditionalFields = false;
                    });
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Unknown'.tr,
                          style: AppFonts.body2(color: AppColors.grayscale90),
                        ),
                      ),
                      Container(
                        width: SizeConfig.widthMultiplier(context) * 24,
                        height: SizeConfig.widthMultiplier(context) * 24,
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
                    top: SizeConfig.heightMultiplier(context) * 12,
                    bottom: SizeConfig.heightMultiplier(context) * 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOviGender = 'Male';

                      showAdditionalFields = false;
                    });
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Male'.tr,
                          style: AppFonts.body2(color: AppColors.grayscale90),
                        ),
                      ),
                      Container(
                        width: SizeConfig.widthMultiplier(context) * 24,
                        height: SizeConfig.widthMultiplier(context) * 24,
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
                    top: SizeConfig.heightMultiplier(context) * 12,
                    bottom: SizeConfig.heightMultiplier(context) * 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOviGender = 'Female';
                    });
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Female'.tr,
                          style: AppFonts.body2(color: AppColors.grayscale90),
                        ),
                      ),
                      Container(
                        width: SizeConfig.widthMultiplier(context) * 24,
                        height: SizeConfig.widthMultiplier(context) * 24,
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
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              const Divider(
                color: AppColors.grayscale20,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              Visibility(
                visible: selectedAnimalType == 'Oviparous' &&
                    selectedOviGender == "Female",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Frequency Of Laying Eggs/Month'.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _layingFrequencyController,
                      decoration: InputDecoration(
                        hintText: 'Enter Frequency'.tr, // Add your hint text here
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
                    Text(
                      'Number Of Eggs/Month'.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _eggsNumberController,
                      decoration: InputDecoration(
                        hintText: 'Enter The Number'.tr, // Add your hint text here
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
                        height: SizeConfig.heightMultiplier(context) * 16,
                      ),
                      Text(
                        "Breeding Stage".tr,
                        style: AppFonts.headline2(color: AppColors.grayscale90),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier(context) * 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier(context) * 12,
                          bottom: SizeConfig.heightMultiplier(context) * 12,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedBreedingStage = 'Ready For Breeding';
                            });
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Ready For Breeding'.tr,
                                  style: AppFonts.body2(
                                      color: AppColors.grayscale90),
                                ),
                              ),
                              Container(
                                width: SizeConfig.widthMultiplier(context) * 24,
                                height:
                                    SizeConfig.widthMultiplier(context) * 24,
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
                          top: SizeConfig.heightMultiplier(context) * 12,
                          bottom: SizeConfig.heightMultiplier(context) * 12,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedBreedingStage = 'Pregnant';
                            });
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Pregnant'.tr,
                                  style: AppFonts.body2(
                                      color: AppColors.grayscale90),
                                ),
                              ),
                              Container(
                                width: SizeConfig.widthMultiplier(context) * 24,
                                height:
                                    SizeConfig.widthMultiplier(context) * 24,
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
                          top: SizeConfig.heightMultiplier(context) * 12,
                          bottom: SizeConfig.heightMultiplier(context) * 12,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedBreedingStage = 'Lactating';
                            });
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Lactating'.tr,
                                  style: AppFonts.body2(
                                      color: AppColors.grayscale90),
                                ),
                              ),
                              Container(
                                width: SizeConfig.widthMultiplier(context) * 24,
                                height:
                                    SizeConfig.widthMultiplier(context) * 24,
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
                "Dates".tr,
                style: AppFonts.headline2(color: AppColors.grayscale90),
              ),
              SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date Of Birth'.tr,
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
                              style:
                                  AppFonts.body2(color: AppColors.grayscale90),
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
                              controller: _birthDayController,
                            ),
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
                    text: 'Add Date'.tr,
                  ),
                  const Icon(Icons.add_rounded,
                      color: AppColors.primary40, size: 20),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              const Divider(
                color: AppColors.grayscale20,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              Text(
                "Add Tag".tr,
                style: AppFonts.headline2(color: AppColors.grayscale90),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: selectedOviChips.map((chip) {
                  return CustomTag(
                    label: chip,
                    selected: true, // Since these are selected chips
                    onTap: () {},
                  );
                }).toList(),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              InkWell(
                onTap: () {
                  _animalTagsModalSheet();
                },
                child: Text(
                  'Add Tags +'.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 36, 86, 38),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              const Divider(
                color: AppColors.grayscale20,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              Text(
                "Custom fields".tr,
                style: AppFonts.headline2(color: AppColors.grayscale90),
              ),
              Text(
                "Add Custom Fields If Needed".tr,
                style: AppFonts.body2(color: AppColors.grayscale60),
              ),
              SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
              Column(
                children: customFields == null
                    ? []
                    : customFields!.keys
                        .map(
                          (fieldName) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(fieldName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () =>
                                          _removeCustomField(fieldName)),
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
                                controller: TextEditingController(
                                    text: customFields![fieldName]),
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        )
                        .toList(),
              ),
              Row(
                children: [
                  PrimaryTextButton(
                    onPressed: () {
                      _showOviFieldNameModal(context);
                    },
                    status: TextStatus.idle,
                    text: 'Add Custom Fields'.tr,
                  ),
                  SizedBox(width: SizeConfig.widthMultiplier(context) * 8),
                  const Icon(Icons.add_rounded,
                      color: AppColors.primary40, size: 20),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              const Divider(
                color: AppColors.grayscale20,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              Text(
                "Additional Notes".tr,
                style: AppFonts.headline2(color: AppColors.grayscale90),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              EditParagraphTextField(
                hintText: 'Add Any Additional Notes if Needed'.tr,
                maxLines: 8,
                notesController: _notesController,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              FileUploaderField(
                uploadedFiles: uploadedFiles?.map((file) => file.path).toList(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            left: 16,
            top: 16,
            right: 16,
            bottom: 16 + MediaQuery.of(context).viewInsets.bottom),
        child: ElevatedButton(
          onPressed: _saveChanges,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 36, 86, 38),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Text(
            'Save Changes'.tr,
            style: const TextStyle(color: Colors.white),
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
        selectedOviImage = selectedImage;
      });
    }
  }

  void _showDatePicker(BuildContext context, String fieldName) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedOviDates[fieldName] ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        selectedOviDates[fieldName] = pickedDate;
      });
    }
  }

  void _showDOBPicker(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      // ignore: unnecessary_null_comparison
      initialDate: _birthDayController.text.isNotEmpty
          ? DateFormat('dd/MM/yyyy').parse(_birthDayController.text)
          : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      _birthDayController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  Column _buildDateFields() {
    final dateFields = <Widget>[];

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
                                : "Select Date : DD/MM/YYYY".tr,
                          ),
                        ),
                        // child: Text(fieldName),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedOviDates[fieldName] = null;
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
      selectedOviImage = null;
    });
  }

  void _showAnimalImagePicker(BuildContext context) {
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
                      'Camera'.tr,
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
                      'Gallery'.tr,
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
                      'Delete Photo'.tr,
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

    DrawUpAnimalSpecies drawUpAnimalSpecies = DrawUpAnimalSpecies(
      searchValue: searchValue,
      speciesList: filteredModalList,
      modalAnimalSpeciesList: speciesList,
    );

    final selectedSpeciesValue = await showModalBottomSheet<String>(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return drawUpAnimalSpecies;
      },
    );

    if (selectedSpeciesValue != null) {
      setState(() {
        selectedAnimalSpecies = selectedSpeciesValue;
      });
    }
  }

  void _editAnimalBreed(String section, BuildContext context) async {
    List<String> filteredBreedList =
        List.from(moreSpeciesToBreedsMap[selectedAnimalSpecies] ?? []);
    TextEditingController searchValue = TextEditingController();

    DrawUpAnimalBreed drawUpAnimalBreed = DrawUpAnimalBreed(
      searchValue: searchValue,
      breedList: filteredBreedList,
      moreSpeciesToBreedsMap: moreSpeciesToBreedsMap,
      selectedAnimalSpecies: selectedAnimalSpecies,
    );

    final selectedBreedValue = await showModalBottomSheet<String>(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return drawUpAnimalBreed;
      },
    );

    if (selectedBreedValue != null) {
      setState(() {
        selectedAnimalBreed = selectedBreedValue;
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
                'Animal Type'.tr,
                style: AppFonts.title3(color: AppColors.grayscale90),
              ),
              SizedBox(height: SizeConfig.heightMultiplier(context) * 32),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundImage: AssetImage(_animalImages['Mammal']!),
                ),
                title: Text('Mammal'.tr,
                    style: AppFonts.body2(color: AppColors.grayscale90)),
                trailing: Container(
                  width: SizeConfig.widthMultiplier(context) * 24,
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
                    selectedAnimalType = 'Mammal';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundImage: AssetImage(_animalImages['Oviparous']!),
                ),
                title: Text('Oviparous'.tr,
                    style: AppFonts.body2(color: AppColors.grayscale90)),
                trailing: Container(
                  width: SizeConfig.widthMultiplier(context) * 24,
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
        builder: (context) => AnimalTagsModal(selectedTags: selectedOviChips));
    setState(() {
      selectedOviChips = result;
    });
  }

  void _showOviFieldNameModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
              bottom: 16 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Custom Field'.tr,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              PrimaryTextField(
                  hintText: 'Enter Custom Field Name'.tr,
                  labelText: 'Enter Field Name'.tr,
                  controller: _fieldNameController),
              const SizedBox(
                height: 32,
              ),
              ButtonWidget(
                onPressed: () {
                  Navigator.pop(context);
                  _showOviFieldContentModal(context);
                },
                buttonText: 'Confirm'.tr,
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
                      child: Text('Cancel'.tr),
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
          padding: EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
              bottom: 16.0 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Text Area'.tr,
                style: const TextStyle(
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
                    labelText: 'Enter Field Content'.tr,
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
                    customFields ??= {};
                    customFields![_fieldNameController.text] =
                        _fieldContentController.text;
                  });
                  Navigator.pop(context);
                },
                buttonText: 'Confirm'.tr,
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
                      child: Text('Cancel'.tr),
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
    List<String> oviDateTypes = [
      'Date Of Hatching',
      'Date Of Death',
      'Date Of Sale',
    ];
    List<String> mammalDateTypes = [
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Add Date '.tr,
                style: const TextStyle(
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
                  itemCount: oviDateTypes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(oviDateTypes[index].tr),
                          dense: true,
                          minVerticalPadding: double.minPositive,
                          trailing: const Icon(Icons.arrow_right_alt_rounded),
                          onTap: () {
                            Navigator.pop(context);
                            _showDatePicker(context, oviDateTypes[index]);
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
                children: mammalDateTypes.map((dateType) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(dateType),
                        dense: true,
                        minVerticalPadding: double.minPositive,
                        trailing: const Icon(Icons.arrow_right_alt_rounded),
                        onTap: () {
                          Navigator.pop(context);
                          _showDatePicker(context, dateType);
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
      customFields?.remove(fieldName);
    });
  }

  void _saveChanges() {
    final animalProvider = ref.read(oviAnimalsProvider);
    final animalIndex =
        animalProvider.indexWhere((animal) => animal.id == widget.animalId);
    ref.read(oviAnimalsProvider.notifier).update((state) {
      final newState = List<OviVariables>.from(state);
      newState[animalIndex] = state[animalIndex].copyWith(
          animalName: _animalNameController.text,
          notes: _notesController.text,
          dateOfBirth: _birthDayController.text.isNotEmpty
              ? DateFormat('dd/MM/yyyy').parse(_birthDayController.text)
              : null,
          files: uploadedFiles,
          selectedOviImage: selectedOviImage,
          selectedAnimalType: selectedAnimalType,
          selectedAnimalSpecies: selectedAnimalSpecies,
          selectedAnimalBreed: selectedAnimalBreed,
          selectedOviGender: selectedOviGender,
          layingFrequency: _layingFrequencyController.text,
          eggsPerMonth: _eggsNumberController.text,
          selectedBreedingStage: selectedBreedingStage,
          selectedOviChips: selectedOviChips,
          customFields: customFields,
          selectedOviDates: selectedOviDates);
      return newState;
    });

    Navigator.pop(context);
  }
}
