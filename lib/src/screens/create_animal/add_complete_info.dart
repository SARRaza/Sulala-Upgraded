import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:intl/intl.dart';
import 'package:sulala_upgrade/src/widgets/animal_info_modal_sheets.dart/animal_image_picker.dart';

import '../../data/classes/breed_child_item.dart';
import '../../data/classes/main_animal_dam.dart';
import '../../data/classes/main_animal_sire.dart';
import '../../data/classes/ovi_variables.dart';
import '../../data/classes/reminder_item.dart';
import '../../data/place_holders.dart';
import '../../data/providers/animal_list_provider.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/animal_info_modal_sheets.dart/animal_children_modal.dart';
import '../../widgets/animal_info_modal_sheets.dart/animal_dam_modal.dart';
import '../../widgets/animal_info_modal_sheets.dart/animal_sire_modal.dart';
import '../../widgets/animal_info_modal_sheets.dart/animal_tags_modal.dart';
import '../../widgets/controls_and_buttons/buttons/sar_button_widget.dart';
import '../../widgets/controls_and_buttons/tags/custom_tags.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_text_button.dart';
import '../../widgets/controls_and_buttons/toggles/toggle_active.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';

import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../widgets/inputs/paragraph_text_fields/paragraph_text_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import '../../widgets/other/custom_field.dart';

class AddCompleteInfo extends ConsumerStatefulWidget {
  const AddCompleteInfo({super.key});

  @override
  ConsumerState<AddCompleteInfo> createState() => _CreateOviCumMammal();
}

class _CreateOviCumMammal extends ConsumerState<AddCompleteInfo> {
  final _nameController = TextEditingController();
  final _frequencyEggsController = TextEditingController();
  final _numberOfEggsController = TextEditingController();

  String selectedBreedingStage = '';
  List<ReminderItem> mastDoDates = [];
  List<MainAnimalSire> selectedSire = [];
  List<MainAnimalDam> selectedDam = [];

  Map<String, DateTime?> selectedMammalDates = {};
  List<String> selectedOviChips = [];
  List<Widget> customOviTextFields = [];
  Map<String, DateTime?> selectedOviDates = {};
  bool showAdditionalFields = false;
  // Initial text for the button
  String selectedOviGender = '';
  bool _addAnimalParents = false;
  bool _addOviChildren = false;
  final ScrollController _scrollController = ScrollController();

  late String selectedAnimalSpecies;
  final _customFieldNameFormKey = GlobalKey<FormState>();
  final _customFieldNameController = TextEditingController();
  final _customFieldContentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection !=
          ScrollDirection.idle) {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _frequencyEggsController.dispose();
    _numberOfEggsController.dispose();
    _scrollController.dispose();
    _customFieldNameController.dispose();
    _customFieldContentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedAnimalType = ref.watch(selectedAnimalTypeProvider);
    var selectedAnimalImage = ref.watch(selectedAnimalImageProvider);
    final animalDam = ref.watch(animalDamDetailsProvider);
    final animalSire = ref.watch(animalSireDetailsProvider);
    final animalChildren = ref.watch(breedingChildrenDetailsProvider);
    final chips = ref.watch(selectedOviChipsProvider);
    final customFields = ref.watch(customOviTextFieldsProvider);
    final oviAnimals = ref.watch(animalListProvider);
    selectedAnimalSpecies = ref.read(selectedAnimalSpeciesProvider);
    if (selectedAnimalImage == null &&
        speciesImages[selectedAnimalSpecies] != null) {
      selectedAnimalImage = AssetImage(speciesImages[selectedAnimalSpecies]!);
      Future.delayed(
          Duration.zero,
          () => ref
              .read(selectedAnimalImageProvider.notifier)
              .update((state) => selectedAnimalImage));
    }

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
                'Create '.tr,
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
            padding:
                EdgeInsets.only(left: SizeConfig.widthMultiplier(context) * 16),
            child: Container(
              width: SizeConfig.widthMultiplier(context) * 40,
              decoration: const BoxDecoration(
                  color: AppColors.grayscale10, shape: BoxShape.circle),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: SizeConfig.widthMultiplier(context) * 24,
                ),
                onPressed: () {
                  // Handle back button press
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  right: SizeConfig.widthMultiplier(context) * 16),
              child: Container(
                width: SizeConfig.widthMultiplier(context) * 40,
                decoration: const BoxDecoration(
                    color: AppColors.grayscale10, shape: BoxShape.circle),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                    size: SizeConfig.widthMultiplier(context) * 24,
                  ),
                  onPressed: () {
                    // Handle close button press
                    Navigator.pop(context, true);
                  },
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.widthMultiplier(context) * 16,
                right: SizeConfig.widthMultiplier(context) * 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 40),
                  Center(
                    child: GestureDetector(
                      child: CircleAvatar(
                          radius: SizeConfig.widthMultiplier(context) * 60,
                          backgroundColor: AppColors.grayscale10,
                          backgroundImage: selectedAnimalImage),
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        _showImagePicker(context);
                      },
                      child: Text(
                        'Add Photo'.tr,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primary40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
                  PrimaryTextField(
                    onChanged: (value) {
                      ref
                          .read(animalNameProvider.notifier)
                          .update((state) => value);
                    },
                    labelText: 'Name'.tr,
                    hintText: 'Enter Name'.tr,
                    controller: _nameController,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter some text please'.tr
                        : null,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 32),
                  Text(
                    "Family Tree".tr,
                    style: AppFonts.headline2(color: AppColors.grayscale90),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 8),
                  Text(
                    "Add Parents If They're In The System".tr,
                    style: AppFonts.body2(color: AppColors.grayscale60),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.heightMultiplier(context) * 8,
                        bottom: SizeConfig.heightMultiplier(context) * 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Add Parents'.tr,
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
                      padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier(context) * 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Sire (Father)'.tr,
                                style: AppFonts.body2(
                                    color: AppColors.grayscale70),
                              ),
                              const Spacer(),
                              oviAnimals.when(
                                  data: (animals) {
                                    return animals.isNotEmpty
                                        ? PrimaryTextButton(
                                            onPressed: () {
                                              _showMainAnimalSireSelectionSheet(
                                                  context);
                                            },
                                            status: TextStatus.idle,
                                            text: animalSire != null
                                                ? animalSire.animalName
                                                : 'Add'.tr,
                                            position: TextButtonPosition.right,
                                          )
                                        : Text('No Animals'.tr);
                                  },
                                  error: (error, stackTrace) =>
                                      Text(error.toString()),
                                  loading: () =>
                                      const CircularProgressIndicator()),
                            ],
                          ),
                          SizedBox(
                              height:
                                  SizeConfig.heightMultiplier(context) * 16),
                          Row(
                            children: [
                              Text(
                                'Dam (Mother)'.tr,
                                style: AppFonts.body2(
                                    color: AppColors.grayscale70),
                              ),
                              const Spacer(),
                              oviAnimals.when(
                                  data: (animals) {
                                    return animals.isNotEmpty
                                        ? PrimaryTextButton(
                                            onPressed: () {
                                              _showMainAnimalDamSelectionSheet(
                                                  context);
                                            },
                                            status: TextStatus.idle,
                                            text: animalDam != null
                                                ? animalDam.animalName
                                                : 'Add'.tr,
                                            position: TextButtonPosition.right,
                                          )
                                        : Text('No Animals'.tr);
                                  },
                                  error: (error, stackTrace) =>
                                      Text(error.toString()),
                                  loading: () =>
                                      const CircularProgressIndicator()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 8),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.heightMultiplier(context) * 8,
                        bottom: SizeConfig.heightMultiplier(context) * 8),
                    child: Row(
                      children: [
                        Text(
                          'Add Children'.tr,
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
                        top: SizeConfig.heightMultiplier(context) * 16,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: animalChildren.length,
                            itemBuilder: (context, index) {
                              final BreedChildItem child =
                                  animalChildren[index];
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  radius:
                                      SizeConfig.widthMultiplier(context) * 24,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: child.selectedOviImage,
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
                                  style: AppFonts.headline4(
                                      color: AppColors.grayscale90),
                                ),
                                subtitle: Text(
                                  child.selectedOviGender,
                                  style: AppFonts.body2(
                                      color: AppColors.grayscale70),
                                ),
                                trailing: Text(
                                  'ID#${child.animalId}',
                                  style: AppFonts.body2(
                                      color: AppColors.grayscale70),
                                ),
                              );
                            },
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  _showMainAnimalChildrenSelectionSheet(
                                      context);
                                },
                                child: Text(
                                  "Add Children".tr,
                                  style: AppFonts.body1(
                                      color: AppColors.primary40),
                                ),
                              ),
                              const Icon(Icons.add, color: AppColors.primary40),
                            ],
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
                              'Unknown'.tr,
                              style:
                                  AppFonts.body2(color: AppColors.grayscale90),
                            ),
                          ),
                          Container(
                            width: SizeConfig.widthMultiplier(context) * 24,
                            height: SizeConfig.widthMultiplier(context) * 24,
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
                        top: SizeConfig.heightMultiplier(context) * 12,
                        bottom: SizeConfig.heightMultiplier(context) * 12),
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
                              'Male'.tr,
                              style:
                                  AppFonts.body2(color: AppColors.grayscale90),
                            ),
                          ),
                          Container(
                            width: SizeConfig.widthMultiplier(context) * 24,
                            height: SizeConfig.widthMultiplier(context) * 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ref.read(selectedOviGenderProvider) ==
                                        'Male'
                                    ? AppColors.primary20
                                    : AppColors.grayscale30,
                                width: ref.read(selectedOviGenderProvider) ==
                                        'Male'
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
                        bottom: SizeConfig.heightMultiplier(context) * 12),
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
                              'Female'.tr,
                              style:
                                  AppFonts.body2(color: AppColors.grayscale90),
                            ),
                          ),
                          Container(
                            width: SizeConfig.widthMultiplier(context) * 24,
                            height: SizeConfig.widthMultiplier(context) * 24,
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
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
                  const Divider(
                    color: AppColors.grayscale20,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
                  if (showAdditionalFields) // Show additional fields when Female is selected
                    Visibility(
                      visible: selectedAnimalType == 'Oviparous',
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
                            onChanged: (value) {
                              ref
                                  .read(layingFrequencyProvider.notifier)
                                  .update((state) => value);
                            },
                            controller: _frequencyEggsController,
                            decoration: InputDecoration(
                              hintText: 'Enter Frequency'
                                  .tr, // Add your hint text here
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
                          Text(
                            'Number Of Eggs/Month'.tr,
                            style: const TextStyle(
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
                            controller: _numberOfEggsController,
                            decoration: InputDecoration(
                              hintText: 'Enter The Number'
                                  .tr, // Add your hint text here
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
                            height: SizeConfig.heightMultiplier(context) * 16,
                          ),
                          Text(
                            "Breeding Stage".tr,
                            style: AppFonts.headline2(
                                color: AppColors.grayscale90),
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
                                ref
                                    .read(
                                        selectedBreedingStageProvider.notifier)
                                    .update((state) => 'Ready For Breeding');
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
                                    width: SizeConfig.widthMultiplier(context) *
                                        24,
                                    height:
                                        SizeConfig.widthMultiplier(context) *
                                            24,
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
                              top: SizeConfig.heightMultiplier(context) * 12,
                              bottom: SizeConfig.heightMultiplier(context) * 12,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                ref
                                    .read(
                                        selectedBreedingStageProvider.notifier)
                                    .update((state) => 'Pregnant');
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
                                    width: SizeConfig.widthMultiplier(context) *
                                        24,
                                    height:
                                        SizeConfig.widthMultiplier(context) *
                                            24,
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
                              top: SizeConfig.heightMultiplier(context) * 12,
                              bottom: SizeConfig.heightMultiplier(context) * 12,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                ref
                                    .read(
                                        selectedBreedingStageProvider.notifier)
                                    .update((state) => 'Lactating');
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
                                    width: SizeConfig.widthMultiplier(context) *
                                        24,
                                    height:
                                        SizeConfig.widthMultiplier(context) *
                                            24,
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
                              height:
                                  MediaQuery.of(context).size.height * 0.019),
                          const Divider(),
                        ],
                      ),
                    ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
                  Text(
                    "Dates".tr,
                    style: AppFonts.headline2(color: AppColors.grayscale90),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
                  PrimaryDateField(
                    hintText: 'dd/MM/yyyy',
                    labelText: 'Date of Birth'.tr,
                    onChanged: (value) => ref
                        .read(dateOfBirthProvider.notifier)
                        .update((state) => value),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.029),
                  _buildOviDateFields(),
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
                  const Divider(
                    color: AppColors.grayscale20,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
                  Text(
                    "Add Tag".tr,
                    style: AppFonts.headline2(color: AppColors.grayscale90),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
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
                          _showAnimalTagsModalSheet();
                        },
                        status: TextStatus.idle,
                        text: 'Add Tags'.tr,
                      ),
                      const Icon(Icons.add_rounded,
                          color: AppColors.primary40, size: 20),
                    ],
                  ),
                  const Divider(
                    color: AppColors.grayscale20,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
                  Text(
                    "Custom Fields".tr,
                    style: AppFonts.headline2(color: AppColors.grayscale90),
                  ),
                  Text(
                    "Add Custom Fields If Needed".tr,
                    style: AppFonts.body2(color: AppColors.grayscale60),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
                  Column(
                    children: customFields.keys
                        .map((fieldName) => CustomField(
                              fieldName: fieldName,
                              fieldContent: customFields[fieldName]!,
                              onDelete: () {
                                ref
                                    .read(customOviTextFieldsProvider.notifier)
                                    .update((state) =>
                                        Map.from(state)..remove(fieldName));
                              },
                            ))
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
                  const Divider(
                    color: AppColors.grayscale20,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
                  Text(
                    'Additional Notes'.tr,
                    style: AppFonts.headline2(color: AppColors.grayscale90),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ParagraphTextField(
                    hintText: 'Add Any Additional Notes if Needed'.tr,
                    maxLines: 8,
                    onChanged: (value) {
                      ref
                          .read(additionalNotesProvider.notifier)
                          .update((state) => value);
                    },
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
                  Focus(
                    onFocusChange:
                        (hasFocus) {}, // Dummy onFocusChange callback
                    child: const FileUploaderField(),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _addOviAnimal();
                Navigator.of(context).pop(true);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 36, 86, 38),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text(
              'Save'.tr,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return AnimalImagePickerWidget(onImageSelected: (file) {
          ref
              .read(selectedAnimalImageProvider.notifier)
              .update((state) => FileImage(file));
        });
      },
    );
  }

  void _showMainAnimalSireSelectionSheet(BuildContext context) async {
    final animalSire = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      showDragHandle: false,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimalSireModal(
          selectedAnimal: _getSelectedAnimal(),
          selectedFather: ref.read(animalSireDetailsProvider),
          selectedMother: ref.read(animalDamDetailsProvider),
          selectedChildren: ref.read(breedingChildrenDetailsProvider),
        );
      },
    );
    ref.read(animalSireDetailsProvider.notifier).update((state) => animalSire);
  }

  void _showMainAnimalDamSelectionSheet(BuildContext context) async {
    final animalDam = await showModalBottomSheet(
      context: context,
      showDragHandle: false,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimalDamModal(
            selectedAnimal: _getSelectedAnimal(),
            selectedFather: ref.read(animalSireDetailsProvider),
            selectedMother: ref.read(animalDamDetailsProvider),
            selectedChildren: ref.read(breedingChildrenDetailsProvider));
      },
    );
    ref.read(animalDamDetailsProvider.notifier).update((state) => animalDam);
  }

  void _showMainAnimalChildrenSelectionSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      showDragHandle: false,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimalChildrenModal(
          selectedAnimal: _getSelectedAnimal(),
          selectedFather: ref.read(animalSireDetailsProvider),
          selectedMother: ref.read(animalDamDetailsProvider),
          selectedChildren: ref.read(breedingChildrenDetailsProvider),
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
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                              _showOviDatePicker(context, oviDateTypes[index]);
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
                    itemCount: mammalDateTypes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(mammalDateTypes[index].tr),
                            dense: true,
                            minVerticalPadding: double.minPositive,
                            trailing: const Icon(Icons.arrow_right_alt_rounded),
                            onTap: () {
                              Navigator.pop(context);
                              _showOviDatePicker(
                                  context, mammalDateTypes[index]);
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
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: selectedOviDates[dateType] ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
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

  void _showAnimalTagsModalSheet() async {
    final result = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return AnimalTagsModal(
            selectedTags: ref.read(selectedOviChipsProvider));
      },
    );

    if (result != null) {
      setState(() {
        selectedOviChips = List<String>.from(result);
      });
    }
  }

  void _showOviFieldNameModal(BuildContext context) {
    _customFieldNameController.clear();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 16 + MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _customFieldNameFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text'.tr;
                      }
                      return null;
                    },
                    hintText: 'Enter Custom Field Name'.tr,
                    labelText: 'Enter Field Name'.tr,
                    onChanged: (value) {
                      ref
                          .read(fieldNameProvider.notifier)
                          .update((state) => value);
                    },
                    controller: _customFieldNameController),
                const SizedBox(height: 32),
                ButtonWidget(
                  onPressed: () {
                    if (_customFieldNameFormKey.currentState!.validate()) {
                      Navigator.pop(context);
                      _showOviFieldContentModal(context);
                    }
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
          ),
        );
      },
    );
  }

  void _showOviFieldContentModal(BuildContext context) {
    _customFieldContentController.clear();
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 16 + MediaQuery.of(context).viewInsets.bottom),
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
              TextField(
                maxLines: 5,
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
                onChanged: (value) {
                  ref
                      .read(fieldContentProvider.notifier)
                      .update((state) => value);
                },
                controller: _customFieldContentController,
              ),
              const SizedBox(
                height: 35,
              ),
              ButtonWidget(
                onPressed: () {
                  Navigator.pop(context);
                  _addNewOviTextField(context);
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

  void _addNewOviTextField(BuildContext context) {
    final fieldName = _customFieldNameController.text;
    final fieldContent = _customFieldContentController.text;

    ref
        .read(customOviTextFieldsProvider.notifier)
        .update((state) => {...state, fieldName: fieldContent});
  }

  Widget _buildOviDateFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ref
          .watch(selectedOviDatesProvider)
          //.state
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
                            hintText: 'dd/MM/yyyy',
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
                            text: DateFormat('dd/MM/yyyy').format(selectedDate),
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

  OviVariables _getSelectedAnimal() {
    final animalName = _nameController.text;
    return OviVariables(
      animalName: animalName,
      breedingEventNumber: '',
      medicalNeeds: ref.read(medicalNeedsProvider),
      shouldAddAnimal: ref.read(shouldAddAnimalProvider),
      selectedBreedingStage: ref.read(selectedBreedingStageProvider),
      layingFrequency: ref.read(layingFrequencyProvider),
      eggsPerMonth: ref.read(eggsPerMonthProvider),
      selectedOviSire: ref.read(animalSireDetailsProvider),
      selectedOviDam: ref.read(animalDamDetailsProvider),
      dateOfBirth: ref.read(dateOfBirthProvider),
      keptInOval: ref.read(keptInOvalProvider),
      dateOfLayingEggs: ref.read(dateOfLayingEggsProvider),
      dateOfSonar: ref.read(dateOfSonarProvider),
      expDlvDate: ref.read(expDeliveryDateProvider),
      incubationDate: ref.read(incubationDateProvider),
      customFields: ref.read(customOviTextFieldsProvider),
      notes: ref.read(additionalNotesProvider),
      selectedOviGender: ref.read(selectedOviGenderProvider),
      selectedOviDates: ref.read(selectedOviDatesProvider),
      selectedAnimalBreed: ref.read(selectedAnimalBreedsProvider),
      selectedAnimalSpecies: ref.read(selectedAnimalSpeciesProvider),
      selectedAnimalType: ref.read(selectedAnimalTypeProvider),
      selectedOviChips: ref.read(selectedOviChipsProvider),
      selectedOviImage: ref.read(selectedAnimalImageProvider),
      selectedFilters: ref.read(selectedFiltersProvider),
      breedSire: ref.read(breedingSireDetailsProvider) ?? '',
      breedDam: ref.read(breedingDamDetailsProvider) ?? '',
      breedPartner: ref.read(breedingPartnerProvider),
      breedChildren: ref.read(breedingChildrenDetailsProvider),
      breedingDate: ref.read(breedingDateProvider),
      breedDeliveryDate: ref.read(deliveryDateProvider),
      breedingNotes: ref.read(breedingNotesProvider),
      shouldAddEvent: ref.read(shouldAddEventProvider),
    );
  }

  void _addOviAnimal() {
    final oviDetails = OviVariables(
        animalName: ref.read(animalNameProvider),
        breedingEventNumber: '',
        medicalNeeds: ref.read(medicalNeedsProvider),
        shouldAddAnimal: ref.read(shouldAddAnimalProvider),
        selectedBreedingStage: ref.read(selectedBreedingStageProvider),
        layingFrequency: ref.read(layingFrequencyProvider),
        eggsPerMonth: ref.read(eggsPerMonthProvider),
        selectedOviSire: ref.read(animalSireDetailsProvider),
        selectedOviDam: ref.read(animalDamDetailsProvider),
        dateOfBirth: ref.read(dateOfBirthProvider),
        keptInOval: ref.read(keptInOvalProvider),
        dateOfLayingEggs: ref.read(dateOfLayingEggsProvider),
        dateOfSonar: ref.read(dateOfSonarProvider),
        expDlvDate: ref.read(expDeliveryDateProvider),
        incubationDate: ref.read(incubationDateProvider),
        customFields: ref.read(customOviTextFieldsProvider),
        notes: ref.read(additionalNotesProvider),
        selectedOviGender: ref.read(selectedOviGenderProvider),
        selectedOviDates: ref.read(selectedOviDatesProvider),
        selectedAnimalBreed: ref.read(selectedAnimalBreedsProvider),
        selectedAnimalSpecies: ref.read(selectedAnimalSpeciesProvider),
        selectedAnimalType: ref.read(selectedAnimalTypeProvider),
        selectedOviChips: ref.read(selectedOviChipsProvider),
        selectedOviImage: ref.read(selectedAnimalImageProvider),
        selectedFilters: ref.read(selectedFiltersProvider),
        breedSire: ref.read(breedingSireDetailsProvider) ?? '',
        breedDam: ref.read(breedingDamDetailsProvider) ?? '',
        breedPartner: ref.read(breedingPartnerProvider),
        breedChildren: ref.read(breedingChildrenDetailsProvider),
        breedingDate: ref.read(breedingDateProvider),
        breedDeliveryDate: ref.read(deliveryDateProvider),
        breedingNotes: ref.read(breedingNotesProvider),
        shouldAddEvent: ref.read(shouldAddEventProvider),
        files:
            ref.read(uploadedFilesProvider).map((path) => File(path)).toList());

    ref.read(animalListProvider.notifier).addAnimal(oviDetails);
  }
}
