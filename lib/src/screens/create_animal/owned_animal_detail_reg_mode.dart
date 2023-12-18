import 'package:flutter/material.dart';

import 'package:sulala_upgrade/src/data/globals.dart' as globals;

import '../../data/classes.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/tags/custom_tags.dart';
import '../../widgets/pages/owned_animal/breeding_info.dart';
import '../../widgets/pages/owned_animal/general_info_animal_widget.dart';

import '../medical/mammals_medical.dart';

import 'edit_animal_details/new_editpage.dart';
import 'sar_listofanimals.dart';

class OwnedAnimalDetailsRegMode extends StatefulWidget {
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
  State<OwnedAnimalDetailsRegMode> createState() =>
      _OwnedAnimalDetailsRegModeState();
}

class _OwnedAnimalDetailsRegModeState extends State<OwnedAnimalDetailsRegMode>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
                          OviDetails: widget.OviDetails,
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
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.16,
                        backgroundColor: Colors.grey[100],
                        backgroundImage:
                            widget.OviDetails.selectedOviImage != null
                                ? FileImage(widget.OviDetails.selectedOviImage!)
                                : null,
                        child: widget.OviDetails.selectedOviImage == null
                            ? const Icon(
                                Icons.camera_alt_outlined,
                                size: 50,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      SizedBox(
                        height: globals.heightMediaQuery * 16,
                      ),
                      if (editMode == true)
                        Row(
                          children: [
                            Text(
                              widget.OviDetails.animalName,
                              style:
                                  AppFonts.title4(color: AppColors.grayscale90),
                            ),
                          ],
                        ),
                      Text(
                        widget.OviDetails.animalName,
                        style: AppFonts.title4(color: AppColors.grayscale90),
                      ),
                      Text(
                        "ID #${widget.OviDetails.animalName}",
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                      // Text(
                      //   'Father: ${widget.OviDetails.selectedOviSire.isNotEmpty ? widget.OviDetails.selectedOviSire.first.animalName : 'Unknown'}',
                      // ),
                      // Text(
                      //   'Mother: ${widget.OviDetails.selectedOviDam.isNotEmpty ? widget.OviDetails.selectedOviDam.first.animalName : 'Unknown'}',
                      // ),
                      // if (widget.OviDetails.selectedOviSire.isNotEmpty &&
                      //     widget.OviDetails.selectedOviSire.first.father !=
                      //         null)
                      //   Text(
                      //     'Paternal Grandfather: ${widget.OviDetails.selectedOviSire.first.father!.animalName}',
                      //   ),
                      // if (widget.OviDetails.selectedOviDam.isNotEmpty &&
                      //     widget.OviDetails.selectedOviDam.first.mother != null)
                      //   Text(
                      //     'Patenral Grandmother: ${widget.OviDetails.selectedOviSire.first.mother!.animalName}',
                      //   ),
                      // if (widget.OviDetails.selectedOviSire.isNotEmpty &&
                      //     widget.OviDetails.selectedOviSire.first.father !=
                      //         null)
                      //   Text(
                      //     'Maternal Grandfather: ${widget.OviDetails.selectedOviDam.first.father!.animalName}',
                      //   ),
                      // if (widget.OviDetails.selectedOviDam.isNotEmpty &&
                      //     widget.OviDetails.selectedOviDam.first.mother != null)
                      //   Text(
                      //     'Maternal Grandmother: ${widget.OviDetails.selectedOviDam.first.mother!.animalName}',
                      //   ),
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
                              children: widget.OviDetails.selectedOviChips
                                  .map((chip) {
                                return CustomTag(
                                  label: chip,
                                  selected:
                                      true, // Since these are selected chips
                                  onTap: () {},
                                );
                              }).toList(),
                            ),
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
                                    onDateOfDeathPressed: () {},
                                    onDateOfMatingPressed: () {},
                                    onDateOfSalePressed: () {},
                                    onDateOfWeaningPressed: () {},
                                    age: "3 years",
                                    type: "Mammal",
                                    sex: "Female",
                                    OviDetails: widget.OviDetails,
                                    breed: '',
                                    fieldName: '',
                                    fieldContent: '',
                                  ),

                                  // Content for the 'Breeding' tab
                                  BreedingInfo(
                                    OviDetails: widget.OviDetails,
                                    breedingEvents: widget.breedingEvents,
                                  ),

                                  // Content for the 'Medical' tab
                                  MammalsMedical(
                                    OviDetails: widget.OviDetails,
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
}
