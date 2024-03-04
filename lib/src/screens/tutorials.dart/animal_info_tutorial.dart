import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sulala_upgrade/src/data/classes/breeding_event_variables.dart';

import 'package:sulala_upgrade/src/data/globals.dart';

import '../../data/classes/ovi_variables.dart';
import '../../data/place_holders.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/tags/custom_tags.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_text_button.dart';
import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../widgets/inputs/paragraph_text_fields/medical_needs_paragraph.dart';
import '../../widgets/other/one_information_block.dart';
import '../../widgets/other/two_information_block.dart';
import '../../widgets/pages/main_widgets/navigation_bar_guest_mode.dart';
import '../../widgets/pages/owned_animal/breeding_info.dart';
import '../../widgets/pages/owned_animal/general_info_animal_widget.dart';

class AnimalInfoTutorialPage extends StatefulWidget {
  const AnimalInfoTutorialPage({Key? key}) : super(key: key);

  @override
  State<AnimalInfoTutorialPage> createState() => _AnimalInfoTutorialPageState();
}

class _AnimalInfoTutorialPageState extends State<AnimalInfoTutorialPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool editMode = false;
  late final OviVariables oviDetails;
  final GlobalKey _generalOverview = GlobalKey();
  final GlobalKey _clickBreeding = GlobalKey();
  final GlobalKey _clickMedical = GlobalKey();
  final GlobalKey _breedingOverview = GlobalKey();
  final GlobalKey _medicalOverview = GlobalKey();
  final GlobalKey _addMedicalNeeds = GlobalKey();
  final GlobalKey _editButton = GlobalKey();

  bool isMammalEditMode = false;

  final _medicalNeedsController = TextEditingController();
  BuildContext? showCaseContext;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(showCaseContext!).startShowCase([
        _generalOverview,
        _clickBreeding,
        _breedingOverview,
        _clickMedical,
        _medicalOverview,
        _addMedicalNeeds,
        _editButton,
      ]);
    });
    oviDetails = OviVariables(
        id: 25811,
        selectedFilters: [],
        animalName: 'Whispering Willow',
        selectedOviSire: null,
        selectedOviDam: null,
        dateOfBirth: DateTime.now().subtract(const Duration(days: 200)),
        dateOfSonar: null,
        expDlvDate: null,
        incubationDate: null,
        selectedOviGender: 'Female',
        keptInOval: '',
        notes: '',
        selectedOviDates: {},
        selectedAnimalBreed: "Quarter Horse",
        selectedAnimalSpecies: "Horse",
        selectedAnimalType: "Mammal",
        selectedOviChips: ["Adopted", "Donated"],
        selectedOviImage: AssetImage(speciesImages['Horse']!),
        layingFrequency: '',
        eggsPerMonth: '',
        selectedBreedingStage: 'Ready For Breeding',
        shouldAddAnimal: false,
        medicalNeeds: null,
        breedingEventNumber: '',
        breedSire: '',
        breedDam: '',
        breedChildren: [],
        breedingDate: null,
        breedDeliveryDate: null,
        breedingNotes: '',
        shouldAddEvent: false,
        dateOfLayingEggs: null);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) {
          showCaseContext = context;
          return SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(
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
                        child: Showcase(
                          disableBarrierInteraction: true,
                          disableDefaultTargetGestures: true,
                          actions: _buildShowcaseActions(),
                          tooltipBackgroundColor: Colors.transparent,
                          descTextStyle: AppFonts.headline1(
                              color: AppColors.grayscale00),
                          key: _editButton,
                          targetBorderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                          description: 'Add & Edit Information To Your Animal'.tr,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Image.asset(
                                'assets/icons/frame/24px/edit_icon_button.png'),
                            onPressed: () {},
                          ),
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
                                onTap: () {},
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
                                      style: AppFonts.title4(
                                          color: AppColors.grayscale90),
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
                                                onTap: () {},
                                              )
                                            ]
                                          : oviDetails.selectedOviChips
                                              .take(2)
                                              .map((chip) {
                                              return CustomTag(
                                                label: chip,
                                                selected:
                                                    true, // Since these are selected chips
                                                onTap: () {},
                                              );
                                            }).toList(),
                                    ),
                                    if (oviDetails.selectedOviChips.length > 2)
                                      TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'See more'.tr,
                                            style: const TextStyle(
                                                color: AppColors.primary50),
                                          )),
                                    SizedBox(
                                      height:
                                          SizeConfig.heightMultiplier(context) * 32,
                                    ),
                                    _buildTabBar(),
                                    SizedBox(
                                      height:
                                          SizeConfig.heightMultiplier(context) * 24,
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
                ),
            ),
          );
        }
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
          Showcase(
            disableBarrierInteraction: true,
            disableDefaultTargetGestures: true,
            actions: _buildShowcaseActions(),
            tooltipBackgroundColor: Colors.transparent,
            descTextStyle: AppFonts.headline1(
                color: AppColors.grayscale00),
            key: _generalOverview,
            targetBorderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
            description:
                'Here You Can Find All The General Info About The Animals'.tr,
            child: GeneralInfoAnimalWidget(
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
          Showcase(
            disableBarrierInteraction: true,
            disableDefaultTargetGestures: true,
            actions: _buildShowcaseActions(),
            tooltipBackgroundColor: Colors.transparent,
            descTextStyle: AppFonts.headline1(
                color: AppColors.grayscale00),
            key: _breedingOverview,
            targetBorderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
            description:
                'Here You Can Find All The Breeding Details Of The Animals'.tr,
            child: BreedingInfo(
              oviDetails: oviDetails,
            ),
          ),

          // Content for the 'Medical' tab
          _buildMammalsMedical(),
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
          Showcase(
              disableBarrierInteraction: true,
              //disableDefaultTargetGestures: true,
              actions: _buildShowcaseActions(
                  onNextClicked: () => _tabController.animateTo(1)),
              tooltipBackgroundColor: Colors.transparent,
              descTextStyle: AppFonts.headline1(
                  color: AppColors.grayscale00),
              key: _clickBreeding,
              targetBorderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              description: 'Click Here'.tr,
              disposeOnTap: false,
              onTargetClick: () {
                _tabController.animateTo(1);
                ShowCaseWidget.of(showCaseContext!).next();
              },
              child: Tab(text: 'Breeding'.tr)),
          Showcase(
              disableBarrierInteraction: true,
              //disableDefaultTargetGestures: true,
              actions: _buildShowcaseActions(
                onNextClicked: () => _tabController.animateTo(2)
              ),
              tooltipBackgroundColor: Colors.transparent,
              descTextStyle: AppFonts.headline1(
                  color: AppColors.grayscale00),
              key: _clickMedical,
              targetBorderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              description: 'Click Here'.tr,
              disposeOnTap: false,
              onTargetClick: () {
                _tabController.animateTo(2);
                ShowCaseWidget.of(showCaseContext!).next();
              },
              child: Tab(text: 'Medical'.tr)),
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
    }
  }


  Widget _buildMammalsMedical() {
    final animal = oviDetails;
    final now = DateTime.now();
    final nextVaccinationDate = now.add(const Duration(days: 2));
    final lastCheckupDate = now.subtract(const Duration(days: 5));
    final nextCheckupDate = now.add(const Duration(days: 8));

    final lastEvent = BreedingEventVariables(
        eventNumber: '2',
        partner: null,
        children: [],
        breedingDate: now.subtract(const Duration(days: 11)),
        notes: '',
        shouldAddEvent: false);
    final deliveryDate = now.add(const Duration(days: 2));

    return Showcase(
      disableBarrierInteraction: true,
      disableDefaultTargetGestures: true,
      actions: _buildShowcaseActions(),
      tooltipBackgroundColor: Colors.transparent,
      descTextStyle: AppFonts.headline1(
          color: AppColors.grayscale00),
      key: _medicalOverview,
      targetBorderRadius: const BorderRadius.all(
        Radius.circular(50),
      ),
      description:
      'Here You Can Find All The Medical Details Of The Animals'
          .tr,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.widthMultiplier(context) * 343,
              child: OneInformationBlock(
                  head1: DateFormat('dd.MM.yyyy').format(nextVaccinationDate),
                  subtitle1: 'Next Vaccination'.tr),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 8,
            ),
            SizedBox(
              width: 343 * SizeConfig.widthMultiplier(context),
              child: TwoInformationBlock(
                head1: DateFormat('dd.MM.yyyy').format(lastCheckupDate),
                head2: DateFormat('dd.MM.yyyy').format(nextCheckupDate),
                subtitle1: "Last Check-up Date".tr,
                subtitle2: "Next Check-up Date".tr,
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Medical Needs'.tr,
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                isMammalEditMode
                    ? PrimaryTextButton(
                        status: TextStatus.idle,
                        text: 'Save'.tr,
                        onPressed: () async {
                          setState(() {
                            isMammalEditMode = false;
                          });
                        })
                    : Showcase(
                      disableBarrierInteraction: true,
                      disableDefaultTargetGestures: true,
                      actions: _buildShowcaseActions(),
                      tooltipBackgroundColor: Colors.transparent,
                      descTextStyle: AppFonts.headline1(
                      color: AppColors.grayscale00),
                        key: _addMedicalNeeds,
                        targetBorderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                        description:
                            'Add Medical Recommendations To The Custom Field'.tr,
                        child: IconButton(
                          icon: Image.asset(
                            'assets/icons/frame/24px/24_Edit.png',
                          ),
                          onPressed: () {
                            // Enter edit mode
                            setState(() {
                              isMammalEditMode = true;
                            });
                          },
                        ),
                      ),
              ],
            ),
            isMammalEditMode
                ? Column(
                    children: [
                      SizedBox(
                        child: MedicalNeedsParagraphTextField(
                          maxLines: 6,
                          hintText:
                              'Be sure to include joint support medicine, antibiotics, anti-inflammatory medication, and topical antiseptics when packing your first-aid kit for your horses. If you have the essentials, you can keep your four-legged friends in the best condition possible.',
                          controller: _medicalNeedsController,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier(context) * 8,
                      ),
                      FileUploaderField(
                        onFileUploaded: (file) {
                          final files = animal.files ?? [];
                          files.add(file);
                        },
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      animal.medicalNeeds?.isNotEmpty != null
                          ? Text(
                              animal.medicalNeeds!,
                              // 'Be sure to include joint support medicine, antibiotics, anti-inflammatory medication, and topical antiseptics when packing your first-aid kit for your horses. If you have the essentials, you can keep your four-legged friends in the best condition possible.',
                              style: AppFonts.body2(color: AppColors.grayscale70),
                            )
                          : Text(
                              'Be sure to include joint support medicine, antibiotics, anti-inflammatory medication, and topical antiseptics when packing your first-aid kit for your horses. If you have the essentials, you can keep your four-legged friends in the best condition possible.',
                              style: AppFonts.body2(color: AppColors.grayscale70),
                            ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier(context) * 22,
                      ),
                      if (animal.files != null)
                        Column(
                          children: animal.files!
                              .map((file) => GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.file_copy_outlined,
                                          color: AppColors.primary30,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            file.path.split('/').last,
                                            style: AppFonts.body1(
                                                color: AppColors.grayscale90),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                    ],
                  ),
            SizedBox(
              height: 16 * SizeConfig.heightMultiplier(context),
            ),
            Visibility(
              visible: animal.selectedOviGender == 'Female' &&
                  animal.selectedAnimalType == 'Mammal',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pregnancy Check',
                    style: AppFonts.title5(color: AppColors.grayscale90),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.only(right: 0, left: 0),
                    leading: Text(
                      'Count of Pregnancies',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    trailing: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${animal.pregnanciesCount ?? 0}',
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                          const Icon(Icons.chevron_right_rounded,
                              color: AppColors.primary40),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.only(right: 0, left: 0),
                    leading: Text(
                      'Pregnancy status'.tr,
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          animal.pregnant == true
                              ? 'Pregnant'.tr
                              : 'Not Pregnant'.tr,
                          style: AppFonts.body2(color: AppColors.grayscale90),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: AppColors.primary40),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.only(right: 0, left: 0),
                    leading: Text(
                      'Date of Mating',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          lastEvent.breedingDate != null
                              ? DateFormat('dd.MM.yyyy')
                                  .format(lastEvent.breedingDate!)
                              : 'N/A',
                          style: AppFonts.body2(color: AppColors.grayscale90),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: AppColors.primary40),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.only(right: 0, left: 0),
                    leading: Text(
                      'Date of sonar',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        animal.dateOfSonar != null
                            ? Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(animal.dateOfSonar!),
                                style:
                                    AppFonts.body2(color: AppColors.grayscale90),
                              )
                            : Text(
                                'ADD',
                                style:
                                    AppFonts.body2(color: AppColors.grayscale90),
                              ),
                        const Icon(Icons.chevron_right_rounded,
                            color: AppColors.primary40),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.only(right: 0, left: 0),
                    leading: Text(
                      'Exp. Delivery Date',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy').format(deliveryDate),
                          style: AppFonts.body2(color: AppColors.grayscale90),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: AppColors.primary40),
                      ],
                    ),
                  ),
                  SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                ],
              ),
            ),
            Visibility(
              visible: animal.selectedOviGender == 'Female' &&
                  animal.selectedAnimalType == 'Oviparous',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hatching Information',
                    style: AppFonts.title5(color: AppColors.grayscale90),
                  ),
                  ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.only(right: 0, left: 0),
                    leading: Text(
                      'Date Of Laying Eggs',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        lastEvent.layingEggsDate != null
                            ? Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(lastEvent.layingEggsDate!),
                                style:
                                    AppFonts.body2(color: AppColors.grayscale90),
                              )
                            : Text(
                                'ADD',
                                style:
                                    AppFonts.body2(color: AppColors.grayscale90),
                              ),
                        const Icon(Icons.chevron_right_rounded,
                            color: AppColors.primary40),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.only(right: 0, left: 0),
                    leading: Text(
                      'Number Of Eggs',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        lastEvent.eggsNumber != null
                            ? Text(
                                '${lastEvent.eggsNumber}',
                                style:
                                    AppFonts.body2(color: AppColors.grayscale90),
                              )
                            : Text(
                                'ADD',
                                style:
                                    AppFonts.body2(color: AppColors.grayscale90),
                              ),
                        const Icon(Icons.chevron_right_rounded,
                            color: AppColors.primary40),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.only(right: 0, left: 0),
                    leading: Text(
                      'Have You Kept Eggs In Oval?'.tr,
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        animal.keptInOval.isNotEmpty
                            ? Text(
                                animal.keptInOval == 'No' ? 'No'.tr : 'Yes'.tr,
                                style:
                                    AppFonts.body2(color: AppColors.grayscale90),
                              )
                            : Text(
                                'ADD',
                                style:
                                    AppFonts.body2(color: AppColors.grayscale90),
                              ),
                        const Icon(Icons.chevron_right_rounded,
                            color: AppColors.primary40),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: animal.keptInOval != 'No',
                    child: ListTile(
                      onTap: () {},
                      contentPadding: const EdgeInsets.only(right: 0, left: 0),
                      leading: Text(
                        'Incubation Date',
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          lastEvent.incubationDate != null
                              ? Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(lastEvent.incubationDate!),
                                  style: AppFonts.body2(
                                      color: AppColors.grayscale90),
                                )
                              : Text(
                                  'ADD',
                                  style: AppFonts.body2(
                                      color: AppColors.grayscale90),
                                ),
                          const Icon(Icons.chevron_right_rounded,
                              color: AppColors.primary40),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Vaccination',
                  style: AppFonts.title5(color: AppColors.grayscale90),
                )
              ],
            ),
            SizedBox(
              height: 14 * SizeConfig.heightMultiplier(context),
            ),
            Row(
              children: [
                PrimaryTextButton(
                  onPressed: () {},
                  text: 'Add Vaccination',
                  status: TextStatus.idle,
                ),
                SizedBox(
                  width: 8 * SizeConfig.widthMultiplier(context),
                ),
                Icon(
                  Icons.add,
                  color: AppColors.primary40,
                  size: 16 * SizeConfig.widthMultiplier(context),
                ),
              ],
            ),
            SizedBox(
              height: 16 * SizeConfig.heightMultiplier(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Medical Checkup',
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                // PrimaryTextButton(
                //   onPressed: () {},
                //   status: TextStatus.idle,
                //   text: 'View More',
                // ),
              ],
            ),
            SizedBox(
              height: 14 * SizeConfig.heightMultiplier(context),
            ),
            Row(
              children: [
                PrimaryTextButton(
                  onPressed: () {},
                  text: 'Add Examination Results',
                  status: TextStatus.idle,
                ),
                SizedBox(
                  width: 8 * SizeConfig.widthMultiplier(context),
                ),
                Icon(
                  Icons.add,
                  color: AppColors.primary40,
                  size: 16 * SizeConfig.widthMultiplier(context),
                ),
              ],
            ),
            SizedBox(
              height: 16 * SizeConfig.heightMultiplier(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Surgeries Records',
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
              ],
            ),
            SizedBox(
              height: 14 * SizeConfig.heightMultiplier(context),
            ),
            Row(
              children: [
                PrimaryTextButton(
                  onPressed: () {},
                  text: 'Add Surgeries Records',
                  status: TextStatus.idle,
                ),
                SizedBox(
                  width: 8 * SizeConfig.widthMultiplier(context),
                ),
                Icon(
                  Icons.add,
                  color: AppColors.primary40,
                  size: 16 * SizeConfig.widthMultiplier(context),
                ),
              ],
            ),
            SizedBox(
              height: 24 * SizeConfig.heightMultiplier(context),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildShowcaseActions({Function? onNextClicked}) {
    return [
      Positioned(
        top: 51,
        left: 16,
        child: SizedBox(
          width: 40,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {
              ShowCaseWidget.of(showCaseContext!).dismiss();

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NavigationBarGuestMode(),
                ),
              );
            },
            backgroundColor: Colors.white,
            elevation: 10,
            shape: const CircleBorder(),
            child: const SizedBox(
              width: 24,
              height: 24,
              child: Image(
                image: AssetImage('assets/icons/frame/24px/24_Close.png'),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        left: 16,
        bottom: 91,
        child: SizedBox(
          width: 40,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {
              if(onNextClicked != null) {
                onNextClicked();
              }
              ShowCaseWidget.of(showCaseContext!).next();
              if (ShowCaseWidget.of(showCaseContext!).activeWidgetId == null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NavigationBarGuestMode()));
              }
            },
            backgroundColor: Colors.white,
            elevation: 10,
            shape: const CircleBorder(),
            child: const SizedBox(
              width: 24,
              height: 24,
              child: Image(
                image: AssetImage('assets/icons/frame/24px/24_Arrow_right.png'),
              ),
            ),
          ),
        ),
      )
    ];
  }

}
