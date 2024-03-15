import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:sulala_upgrade/src/data/globals.dart';

import '../../data/classes/ovi_variables.dart';
import '../../data/providers/animal_providers.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/animal_info_modal_sheets.dart/animal_tags_modal.dart';
import '../../widgets/controls_and_buttons/tags/custom_tags.dart';
import '../../widgets/pages/owned_animal/breeding_info.dart';
import '../../widgets/pages/owned_animal/general_info_animal_widget.dart';

import '../medical/mammals_medical.dart';

import '../reg_mode/image_view_page.dart';
import 'edit_animal_details/edit_page.dart';

class OwnedAnimalDetailsRegMode extends ConsumerStatefulWidget {
  final int animalId;

  const OwnedAnimalDetailsRegMode({Key? key, required this.animalId})
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
  double tabViewHeight = 300;
  final _generalTabKey = GlobalKey();
  final _breedingTabKey = GlobalKey();
  final _medicalTabKey = GlobalKey();

  int _selectedTabbar = 0;

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 48),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: Colors.transparent,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
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
                Container(
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
                            animalId: widget.animalId,
                            breedingEvents: const [],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: ref.watch(animalListProvider).when(
          error: (Object error, StackTrace stackTrace) =>
              Text(error.toString()),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
          data: (animals) {
            final oviDetails =
                animals.firstWhere((animal) => animal.id == widget.animalId);
            return SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/graphic/Animal_p.png"),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topLeft),
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 195 * SizeConfig.heightMultiplier(context)),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: MediaQuery.of(context).size.width,
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 195 * SizeConfig.heightMultiplier(context),
                        ),
                        decoration: const BoxDecoration(
                            color: AppColors.grayscale0,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32))),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 76 * SizeConfig.heightMultiplier(context)),
                              child: Text(
                                oviDetails.animalName,
                                style: AppFonts.title4(
                                    color: AppColors.grayscale90),
                              ),
                            ),
                            Text(
                              "ID #${oviDetails.id}",
                              style: AppFonts.body2(
                                  color: AppColors.grayscale70),
                            ),
                            SizedBox(
                              height:
                              SizeConfig.heightMultiplier(context) * 16,
                            ),
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children:
                              oviDetails.selectedOviChips.isEmpty
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
                                      _showAnimalTagsModalSheet(
                                          oviDetails),
                                );
                              }).toList(),
                            ),
                            if (oviDetails.selectedOviChips.length > 2)
                              TextButton(
                                  onPressed: () =>
                                      _showAnimalTagsModalSheet(
                                          oviDetails),
                                  child: Text(
                                    'See more'.tr,
                                    style: const TextStyle(
                                        color: AppColors.primary50),
                                  )),
                            SizedBox(
                              height:
                              SizeConfig.heightMultiplier(context) *
                                  32,
                            ),
                            _buildTabBar(),
                            SizedBox(
                              height:
                              SizeConfig.heightMultiplier(context) *
                                  24,
                            ),
                            _buildTabBarView(context, oviDetails)
                            // Builder(builder: (_) {
                            //   if (_selectedTabbar == 0) {
                            //     return IntrinsicHeight(
                            //       child: GeneralInfoAnimalWidget(
                            //         key: _generalTabKey,
                            //         onDateOfBirthPressed: () {},
                            //         onDateOfDeathPressed: () {
                            //           _updateDateField('Date Of Death', oviDetails);
                            //         },
                            //         onDateOfMatingPressed: () {
                            //           _updateDateField('Date Of Mating', oviDetails);
                            //         },
                            //         onDateOfSalePressed: () {
                            //           _updateDateField('Date Of Sale', oviDetails);
                            //         },
                            //         onDateOfWeaningPressed: () {
                            //           _updateDateField('Date Of Weaning', oviDetails);
                            //         },
                            //         onDateOfHatchingPressed: () {
                            //           _updateDateField('Date Of Hatching', oviDetails);
                            //         },
                            //         age: "3 years",
                            //         type: "Mammal",
                            //         sex: "Female",
                            //         oviDetails: oviDetails,
                            //         breed: '',
                            //         fieldName: '',
                            //         fieldContent: '',
                            //       ),
                            //     );
                            //   } else if (_selectedTabbar == 1) {
                            //     return IntrinsicHeight(
                            //       child: BreedingInfo(
                            //         key: _breedingTabKey,
                            //         oviDetails: oviDetails,
                            //       ),
                            //     );
                            //   } else {
                            //     return  IntrinsicHeight(
                            //       child: MammalsMedical(
                            //         key: _medicalTabKey,
                            //         animal: oviDetails,
                            //       ),
                            //     );
                            //   }
                            // }),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 135,
                        child: GestureDetector(
                          onTap: () => _viewImage(oviDetails.selectedOviImage!),
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
                      ),

                    ],
                  )),
            );
          }),
    );
  }

  Widget _buildTabBarView(BuildContext context, OviVariables oviDetails) {
    return AutoScaleTabBarView(
      controller: _tabController,
      children: [
        // Content for the 'General' tab
        IntrinsicHeight(
          child: GeneralInfoAnimalWidget(
            key: _generalTabKey,
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
        ),
    
        // Content for the 'Breeding' tab
        BreedingInfo(
          key: _breedingTabKey,
          oviDetails: oviDetails,
        ),
    
        // Content for the 'Medical' tab
        MammalsMedical(
          key: _medicalTabKey,
          animal: oviDetails,
        ),
      ],
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
        onTap: (index) {
          setState(() {
            _selectedTabbar = index;
          });
        },
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
        builder: (context) => ImageViewPage(imageProvider: selectedOviImage!)));
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
      ref
          .read(animalListProvider.notifier)
          .updateAnimal(oviDetails.copyWith(selectedOviChips: result));
    }
  }
}
