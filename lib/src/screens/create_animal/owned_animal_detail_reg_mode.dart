import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import 'package:sulala_upgrade/src/screens/reg_mode/image_view_page.dart';

import '../../data/classes.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/animal_info_modal_sheets.dart/animal_image_picker.dart';
import '../../widgets/animal_info_modal_sheets.dart/animal_tags_modal.dart';
import '../../widgets/controls_and_buttons/tags/custom_tags.dart';
import '../../widgets/pages/owned_animal/breeding_info.dart';
import '../../widgets/pages/owned_animal/general_info_animal_widget.dart';

import '../medical/mammals_medical.dart';

import 'edit_animal_details/new_editpage.dart';
import 'sar_listofanimals.dart';

class OwnedAnimalDetailsRegMode extends ConsumerStatefulWidget {
  final String imagePath;
  final String title;
  final String geninfo;
  // ignore: non_constant_identifier_names
  final OviVariables OviDetails;
  final List<BreedingEventVariables> breedingEvents;

  const OwnedAnimalDetailsRegMode(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.geninfo,
      // ignore: non_constant_identifier_names
      required this.OviDetails,
      required this.breedingEvents})
      : super(key: key);

  @override
  ConsumerState<OwnedAnimalDetailsRegMode> createState() =>
      _OwnedAnimalDetailsRegModeState();
}

class _OwnedAnimalDetailsRegModeState
    extends ConsumerState<OwnedAnimalDetailsRegMode>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool editMode = false;
  late OviVariables oviDetails;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    oviDetails = widget.OviDetails.copyWith();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: globals.widthMediaQuery * 375,
                child: Image.asset(
                  "assets/graphic/Animal_p.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: 8.0,
              left: 8.0,
              child: Container(
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
            Positioned(
              top: 8.0,
              right: 8.0,
              child: Container(
                width: globals.widthMediaQuery * 40,
                decoration: const BoxDecoration(
                    color: AppColors.grayscale10, shape: BoxShape.circle),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Image.asset(
                      'assets/icons/frame/24px/edit_icon_button.png'),
                  onPressed: () {
                    // Handle close button press
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditAnimalGenInfo(
                          animalId: oviDetails.id,
                          breedingEvents: widget.breedingEvents,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: globals.heightMediaQuery * 185,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      globals.heightMediaQuery * 32,
                    ),
                    topRight: Radius.circular(globals.widthMediaQuery * 32),
                  ),
                ),
                child: const SizedBox(), // Add your content here
              ),
            ),
            Center(
              child: FractionalTranslation(
                translation: Offset(0, globals.heightMediaQuery * 0.15),
                child: Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _viewImage,
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.16,
                          backgroundColor: Colors.grey[100],
                          backgroundImage: oviDetails.selectedOviImage,
                          child: oviDetails.selectedOviImage == null
                              ? const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 50,
                                  color: Colors.grey,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(
                        height: globals.heightMediaQuery * 16,
                      ),
                      if (editMode == true)
                        Row(
                          children: [
                            Text(
                              oviDetails.animalName,
                              style:
                                  AppFonts.title4(color: AppColors.grayscale90),
                            ),
                          ],
                        ),
                      Text(
                        oviDetails.animalName,
                        style: AppFonts.title4(color: AppColors.grayscale90),
                      ),
                      Text(
                        "ID #${oviDetails.id}",
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                      SizedBox(
                        height: globals.heightMediaQuery * 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: globals.widthMediaQuery * 16,
                            right: globals.widthMediaQuery * 16),
                        child: Column(
                          children: [
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: oviDetails.selectedOviChips.isEmpty
                                  ? [
                                      CustomTag(
                                        label: 'Add+'.tr,
                                        selected:
                                            true, // Since these are selected chips
                                        onTap: _showAnimalTagsModalSheet,
                                      )
                                    ]
                                  : oviDetails.selectedOviChips
                                      .take(2)
                                      .map((chip) {
                                      return CustomTag(
                                        label: chip,
                                        selected:
                                            true, // Since these are selected chips
                                        onTap: _showAnimalTagsModalSheet,
                                      );
                                    }).toList(),
                            ),
                            if (oviDetails.selectedOviChips.length > 2)
                              TextButton(
                                  onPressed: _showAnimalTagsModalSheet,
                                  child: const Text(
                                    'See more',
                                    style:
                                        TextStyle(color: AppColors.primary50),
                                  )),
                            SizedBox(
                              height: globals.heightMediaQuery * 32,
                            ),
                            Container(
                              height: globals.heightMediaQuery * 44,
                              decoration: BoxDecoration(
                                color: AppColors.grayscale10,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                indicator: BoxDecoration(
                                  color: AppColors.primary50,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                dividerColor: Colors.transparent,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorColor: Colors.transparent,
                                labelColor: AppColors.grayscale0,
                                unselectedLabelColor: AppColors.grayscale60,
                                labelStyle:
                                    AppFonts.body2(color: AppColors.grayscale0),
                                tabs: const [
                                  Tab(text: 'General'),
                                  Tab(text: 'Breeding'),
                                  Tab(text: 'Medical'),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: globals.heightMediaQuery * 24,
                            ),
                            SizedBox(
                              height: globals.heightMediaQuery * 325,
                              width: globals.widthMediaQuery * 341,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  // Content for the 'General' tab
                                  GeneralInfoAnimalWidget(
                                    onDateOfBirthPressed: () {},
                                    onDateOfDeathPressed: () {
                                      updateDateField('Date Of Death');
                                    },
                                    onDateOfMatingPressed: () {
                                      updateDateField('Date Of Mating');
                                    },
                                    onDateOfSalePressed: () {
                                      updateDateField('Date Of Sale');
                                    },
                                    onDateOfWeaningPressed: () {
                                      updateDateField('Date Of Weaning');
                                    },
                                    onDateOfHatchingPressed: () {
                                      updateDateField('Date Of Hatching');
                                    },
                                    age: "3 years",
                                    type: "Mammal",
                                    sex: "Female",
                                    OviDetails: oviDetails,
                                    breed: '',
                                    fieldName: '',
                                    fieldContent: '',
                                  ),

                                  // Content for the 'Breeding' tab
                                  BreedingInfo(
                                    OviDetails: oviDetails,
                                    breedingEvents: widget.breedingEvents,
                                  ),

                                  // Content for the 'Medical' tab
                                  MammalsMedical(
                                    OviDetails: oviDetails,
                                    pregnancyStatusUpdated: (status) {
                                      setState(() {
                                        oviDetails.pregnant = status;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateDateField(dateType) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: oviDetails.selectedOviDates[dateType] ?? DateTime.now(),
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
    if (pickedDate != null) {
      setState(() {
        oviDetails.selectedOviDates[dateType] = pickedDate;
      });
      ref.read(ovianimalsProvider.notifier).update((state) {
        final index = state
            .indexWhere((animal) => animal.animalName == oviDetails.animalName);
        state[index] = oviDetails;
        return state;
      });
    }

  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return AnimalImagePickerWidget(onImageSelected: (file) {
          setState(() {
            oviDetails.selectedOviImage = FileImage(file);
          });

          ref.read(ovianimalsProvider.notifier).update((state) {
            final index = state.indexWhere(
                (animal) => animal.animalName == oviDetails.animalName);
            state[index] = oviDetails;
            return state;
          });
        });
      },
    );
  }

  void _viewImage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ImageViewPage(imageProvider: oviDetails.selectedOviImage!)));
  }

  void _showAnimalTagsModalSheet() async {
    final result = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return AnimalTagsModal(selectedTags: oviDetails.selectedOviChips);
      },
    );

    if (result != null) {
      setState(() {
        oviDetails = oviDetails.copyWith(selectedOviChips: result);
        ref.read(ovianimalsProvider.notifier).update((state) {
          final animalIndex =
              state.indexWhere((animal) => animal.id == oviDetails.id);
          state[animalIndex] = oviDetails;
          return state;
        });
      });
    }
  }
}
