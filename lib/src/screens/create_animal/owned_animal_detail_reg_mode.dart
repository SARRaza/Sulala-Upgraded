import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import 'package:sulala_upgrade/src/screens/reg_mode/image_view_page.dart';

import '../../data/classes/ovi_variables.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/animal_info_modal_sheets.dart/animal_tags_modal.dart';
import '../../widgets/controls_and_buttons/tags/custom_tags.dart';
import '../../widgets/pages/owned_animal/breeding_info.dart';
import '../../widgets/pages/owned_animal/general_info_animal_widget.dart';

import '../medical/mammals_medical.dart';

import 'edit_animal_details/edit_page.dart';

class OwnedAnimalDetailsRegMode extends ConsumerStatefulWidget {
  final int animalId;

  const OwnedAnimalDetailsRegMode(
      {Key? key,
      required this.animalId})
      : super(key: key);

  @override
  ConsumerState<OwnedAnimalDetailsRegMode> createState() =>
      _OwnedAnimalDetailsRegModeState();
}

class _OwnedAnimalDetailsRegModeState
    extends ConsumerState<OwnedAnimalDetailsRegMode>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ref.watch(animalListProvider).when(
          data: (animals) {
            final oviDetails = animals.firstWhere((animal) => animal.id == widget
                .animalId);

            return Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: SizeConfig.widthMultiplier(context) * 375,
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
                        size: SizeConfig.widthMultiplier(context) * 24,
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
                    width: SizeConfig.widthMultiplier(context) * 40,
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
                              breedingEvents: const [],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: SizeConfig.heightMultiplier(context) * 185,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          SizeConfig.heightMultiplier(context) * 32,
                        ),
                        topRight: Radius.circular(
                            SizeConfig.widthMultiplier(context) * 32),
                      ),
                    ),
                    child: const SizedBox(), // Add your content here
                  ),
                ),
                Center(
                  child: FractionalTranslation(
                    translation:
                        Offset(0, SizeConfig.heightMultiplier(context) * 0.15),
                    child: Expanded(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => _viewImage(oviDetails.selectedOviImage),
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
                            height: SizeConfig.heightMultiplier(context) * 16,
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
                            height: SizeConfig.heightMultiplier(context) * 16,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.widthMultiplier(context) * 16,
                                right: SizeConfig.widthMultiplier(context) * 16),
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
                                            onTap: () =>
                                                _showAnimalTagsModalSheet(
                                                    oviDetails),
                                          )
                                        ]
                                      : oviDetails.selectedOviChips
                                          .take(2)
                                          .map((chip) {
                                          return CustomTag(
                                            label: chip,
                                            selected:
                                                true, // Since these are selected chips
                                            onTap: () =>
                                                _showAnimalTagsModalSheet(oviDetails),
                                          );
                                        }).toList(),
                                ),
                                if (oviDetails.selectedOviChips.length > 2)
                                  TextButton(
                                      onPressed: () =>
                                          _showAnimalTagsModalSheet(oviDetails),
                                      child: Text(
                                        'See more'.tr,
                                        style: const TextStyle(
                                            color: AppColors.primary50),
                                      )),
                                SizedBox(
                                  height: SizeConfig.heightMultiplier(context) * 32,
                                ),
                                _buildTabBar(),
                                SizedBox(
                                  height: SizeConfig.heightMultiplier(context) * 24,
                                ),
                                _buildTabBarView(context, oviDetails),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }, error: (Object error, StackTrace stackTrace) => Text(error.toString()),
            loading: () => const Center(child: CircularProgressIndicator(),)
        ),
      ),
    );
  }

  SizedBox _buildTabBarView(BuildContext context, OviVariables oviDetails) {
    return SizedBox(
      height: SizeConfig.heightMultiplier(context) * 325,
      width: SizeConfig.widthMultiplier(context) * 341,
      child: TabBarView(
        controller: _tabController,
        children: [
          // Content for the 'General' tab
          GeneralInfoAnimalWidget(
            onDateOfBirthPressed: () {},
            onDateOfDeathPressed: () {
              _updateDateField('Date Of Death', oviDetails);
            },
            onDateOfMatingPressed: () {
              _updateDateField('Date Of Mating', oviDetails);
            },
            onDateOfSalePressed: () {
              _updateDateField('Date Of Sale', oviDetails);
            },
            onDateOfWeaningPressed: () {
              _updateDateField('Date Of Weaning', oviDetails);
            },
            onDateOfHatchingPressed: () {
              _updateDateField('Date Of Hatching', oviDetails);
            },
            age: "3 years",
            type: "Mammal",
            sex: "Female",
            oviDetails: oviDetails,
            breed: '',
            fieldName: '',
            fieldContent: '',
          ),

          // Content for the 'Breeding' tab
          BreedingInfo(
            oviDetails: oviDetails,
            breedingEvents: const [],
          ),

          // Content for the 'Medical' tab
          MammalsMedical(
            OviDetails: oviDetails,
            pregnancyStatusUpdated: (status) {
              setState(() {
                oviDetails.copyWith(pregnant: status);
              });
            },
          ),
        ],
      ),
    );
  }

  Container _buildTabBar() {
    return Container(
      height: SizeConfig.heightMultiplier(context) * 44,
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
        labelStyle: AppFonts.body2(color: AppColors.grayscale0),
        tabs: [
          Tab(text: 'General'.tr),
          Tab(text: 'Breeding'.tr),
          Tab(text: 'Medical'.tr),
        ],
      ),
    );
  }

  Future<void> _updateDateField(dateType, oviDetails) async {
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
      oviDetails.selectedOviDates[dateType] = pickedDate;
      ref.read(animalListProvider.notifier).updateAnimal(oviDetails);
    }
  }

  void _viewImage(selectedOviImage) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ImageViewPage(imageProvider: selectedOviImage!)));
  }

  void _showAnimalTagsModalSheet(OviVariables oviDetails) async {
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
      ref.read(animalListProvider.notifier).updateAnimal(oviDetails.copyWith(
        selectedOviChips: result
      ));
    }
  }
}
