import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sulala_upgrade/src/data/classes/breeding_event_variables.dart';

import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/widgets/other/tutorial_overlay.dart';

import '../../data/classes/ovi_variables.dart';
import '../../data/place_holders.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/tags/custom_tags.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_text_button.dart';
import '../../widgets/lists/table_list/table_text_button.dart';
import '../../widgets/other/one_information_block.dart';
import '../../widgets/other/three_information_block.dart';
import '../../widgets/other/two_information_block.dart';
import '../../widgets/pages/main_widgets/navigation_bar_guest_mode.dart';
import '../../widgets/pages/owned_animal/breeding_info.dart';
import '../../widgets/styled_dismissible.dart';

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
  final GlobalKey _editInfo = GlobalKey();
  final GlobalKey _addInfo = GlobalKey();
  final GlobalKey _medicalNeeds = GlobalKey();
  final GlobalKey _monitorPregnancy = GlobalKey();
  final GlobalKey _pregnancyCheck = GlobalKey();

  bool isMammalEditMode = false;

  final _sizedBoxKey = GlobalKey();
  late TutorialController _tutorialController;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tutorialController =
        TutorialController(beforeStepChanged: (currentStepIndex) {
      if (currentStepIndex == 0) {
        _tabController.animateTo(2);
        return false;
      }
      return true;
    });
    oviDetails = OviVariables(
        id: 25811,
        selectedFilters: [],
        animalName: 'Shirley',
        selectedOviSire: null,
        selectedOviDam: null,
        dateOfBirth: null,
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
    return Stack(
      children: [
        Scaffold(
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
                        key: _editInfo,
                        padding: EdgeInsets.zero,
                        icon: Image.asset(
                            'assets/icons/frame/24px/edit_icon_button.png'),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
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
                      margin: EdgeInsets.only(
                          top: 195 * SizeConfig.heightMultiplier(context)),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      width: MediaQuery.of(context).size.width,
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height -
                            195 * SizeConfig.heightMultiplier(context),
                      ),
                      decoration: const BoxDecoration(
                          color: AppColors.grayscale0,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32))),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: 76 * SizeConfig.heightMultiplier(context)),
                            child: Text(
                              oviDetails.animalName,
                              style:
                                  AppFonts.title4(color: AppColors.grayscale90),
                            ),
                          ),
                          Text(
                            "ID #${oviDetails.id}",
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier(context) * 16,
                          ),
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
                                        onTap: () {})
                                  ]
                                : oviDetails.selectedOviChips
                                    .take(2)
                                    .map((chip) {
                                    return CustomTag(
                                        label: chip,
                                        selected:
                                            true, // Since these are selected chips
                                        onTap: () {});
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
                            height: SizeConfig.heightMultiplier(context) * 32,
                          ),
                          _buildTabBar(),
                          SizedBox(
                            height: SizeConfig.heightMultiplier(context) * 24,
                          ),
                          _buildTabBarView(context, oviDetails)
                        ],
                      ),
                    ),
                    Positioned(
                      top: 135,
                      child: GestureDetector(
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
                    ),
                  ],
                )),
          ),
        ),
        TutorialOverlay(
          controller: _tutorialController,
          steps: [
            [_editInfo, _addInfo],
            [_medicalNeeds, _monitorPregnancy]
          ],
          hints: const [
            'Add and edit information about your animal',
            'Add medical recommendations to the custom field, attach files, plan medical checkups and monitor animal pregnancy'
          ],
          onFinished: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NavigationBarGuestMode())),
          closeButtonPositionLeft: 16,
          nextButtonPositionLeft: 16,
        )
      ],
    );
  }

  Widget _buildTabBarView(BuildContext context, OviVariables oviDetails) {
    return AutoScaleTabBarView(
      controller: _tabController,
      children: [
        // Content for the 'General' tab
        IntrinsicHeight(child: _buildGeneralInfoAnimal()),

        // Content for the 'Breeding' tab
        BreedingInfo(
          oviDetails: oviDetails,
        ),

        // Content for the 'Medical' tab
        MammalsMedicalTutorial(
          animal: oviDetails,
          sizedBoxKey: _sizedBoxKey,
          medicalNeeds: _medicalNeeds,
          pregnancyCheck: _pregnancyCheck,
          monitorPregnancy: _monitorPregnancy,
          postFrameCallback: (duration) async {
            Future.delayed(const Duration(milliseconds: 300), () async {
              await Scrollable.ensureVisible(_sizedBoxKey.currentContext!);
              _tutorialController.stepIndex = 1;
            });
          },
        )
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
          Tab(text: 'Medical'.tr)
        ],
      ),
    );
  }

  Widget _buildGeneralInfoAnimal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: SizeConfig.widthMultiplier(context) * 343,
          child: ThreeInformationBlock(
            head1: oviDetails.selectedAnimalType,
            head2: oviDetails.selectedAnimalSpecies,
            head3: oviDetails.selectedOviGender.isNotEmpty
                ? oviDetails.selectedOviGender
                : 'Not Selected'.tr,
          ),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier(context) * 24,
        ),
        Text(
          "General Information".tr,
          style: AppFonts.title5(color: AppColors.grayscale90),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableTextButton(
                onPressed: () {},
                textButton: oviDetails.age > 0
                    ? oviDetails.age.toString()
                    : "No info".tr,
                textHead: "Age".tr,
              ),
              Visibility(
                visible: oviDetails.dateOfBirth != null,
                child: TableTextButton(
                  onPressed: () {},
                  textButton: oviDetails.dateOfBirth != null
                      ? DateFormat('dd/MM/yyyy').format(oviDetails.dateOfBirth!)
                      : "No info".tr,
                  textHead: "Date of Birth".tr,
                ),
              ),
              TableTextButton(
                onPressed: () {},
                textButton: oviDetails.selectedAnimalBreed,
                textHead: "Breed".tr,
              ),
              Visibility(
                  visible: oviDetails.selectedOviGender == 'Female' &&
                      oviDetails.selectedAnimalType == 'Mammal',
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Date of Weaning".tr,
                            style: AppFonts.body2(
                              color: AppColors.grayscale70,
                            ),
                          ),
                          const Spacer(),
                          PrimaryTextButton(
                            key: _addInfo,
                            status: TextStatus.idle,
                            position: TextButtonPosition.right,
                            onPressed: () {},
                            text: "Add".tr,
                          ),
                        ],
                      ),
                    ],
                  )),
              Visibility(
                visible: oviDetails.selectedOviGender == 'Female' &&
                    oviDetails.selectedAnimalType == 'Oviparous',
                child: TableTextButton(
                  onPressed: () {},
                  textButton: oviDetails.selectedOviDates
                              .containsKey('Date Of Hatching') &&
                          oviDetails.selectedOviDates['Date Of Hatching'] !=
                              null
                      ? DateFormat('dd/MM/yyyy').format(
                          oviDetails.selectedOviDates['Date Of Hatching']!,
                        )
                      : 'Add'.tr,
                  textHead: "Date of Hatching".tr,
                ),
              ),
              TableTextButton(
                onPressed: () {},
                textButton: oviDetails.selectedOviDates
                            .containsKey('Date Of Mating') &&
                        oviDetails.selectedOviDates['Date Of Mating'] != null
                    ? DateFormat('dd/MM/yyyy').format(
                        oviDetails.selectedOviDates['Date Of Mating']!,
                      )
                    : 'Add'.tr,
                textHead: "Date of Mating".tr,
              ),
              TableTextButton(
                onPressed: () {},
                textButton:
                    oviDetails.selectedOviDates.containsKey('Date Of Death') &&
                            oviDetails.selectedOviDates['Date Of Death'] != null
                        ? DateFormat('dd/MM/yyyy').format(
                            oviDetails.selectedOviDates['Date Of Death']!,
                          )
                        : 'Add'.tr,
                textHead: "Date of Death".tr,
              ),
              TableTextButton(
                onPressed: () {},
                textButton:
                    oviDetails.selectedOviDates.containsKey('Date Of Sale') &&
                            oviDetails.selectedOviDates['Date Of Sale'] != null
                        ? DateFormat('dd/MM/yyyy').format(
                            oviDetails.selectedOviDates['Date Of Sale']!,
                          )
                        : 'Add'.tr,
                textHead: "Date of Sale".tr,
              ),
              Visibility(
                visible: oviDetails.customFields != null,
                child: Column(
                  children: oviDetails.customFields?.keys
                          .map((fieldName) => TableTextButton(
                              onPressed: () {},
                              textButton: oviDetails.customFields![fieldName]!,
                              textHead: fieldName))
                          .toList() ??
                      [],
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 24,
              ),
              if (oviDetails.notes.isNotEmpty)
                Column(
                  children: [
                    Text(
                      "Additional Notes".tr,
                      style: AppFonts.title5(color: AppColors.grayscale90),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier(context) * 14,
                    ),
                    Text(
                      oviDetails.notes,
                      style: AppFonts.body1(color: AppColors.grayscale90),
                    ),
                  ],
                ),
              if (oviDetails.files?.isNotEmpty == true)
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: oviDetails.files?.length,
                  itemBuilder: (context, index) {
                    final filePath = oviDetails.files![index].path;

                    return StyledDismissible(
                      onDismissed: (direction) {},
                      child: GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.file_copy_outlined,
                                color: AppColors.primary30,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  filePath.split('/').last,
                                  style: AppFonts.body1(
                                      color: AppColors.grayscale90),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              const SizedBox(
                height: 111,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MammalsMedicalTutorial extends StatefulWidget {
  final OviVariables animal;
  final GlobalKey sizedBoxKey;
  final GlobalKey medicalNeeds;
  final GlobalKey pregnancyCheck;
  final GlobalKey monitorPregnancy;
  final void Function(Duration) postFrameCallback;

  const MammalsMedicalTutorial(
      {super.key,
      required this.animal,
      required this.sizedBoxKey,
      required this.medicalNeeds,
      required this.pregnancyCheck,
      required this.monitorPregnancy,
      required this.postFrameCallback});

  @override
  State<MammalsMedicalTutorial> createState() => _MammalsMedicalTutorialState();
}

class _MammalsMedicalTutorialState extends State<MammalsMedicalTutorial> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(widget.postFrameCallback);
  }

  @override
  Widget build(BuildContext context) {
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

    return Column(
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
          key: widget.sizedBoxKey,
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
            IconButton(
              key: widget.medicalNeeds,
              icon: Image.asset(
                'assets/icons/frame/24px/24_Edit.png',
              ),
              onPressed: () {},
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.animal.medicalNeeds?.isNotEmpty == true
                ? Text(
                    widget.animal.medicalNeeds!,
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  )
                : Text(
                    'Be sure to include joint support medicine, antibiotics, anti-inflammatory medication, and topical antiseptics when packing your first-aid kit for your horses. If you have the essentials, you can keep your four-legged friends in the best condition possible.',
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  ),
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 22,
            ),
            if (widget.animal.files != null)
              Column(
                children: widget.animal.files!
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
          visible: widget.animal.selectedOviGender == 'Female' &&
              widget.animal.selectedAnimalType == 'Mammal',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pregnancy Check',
                key: widget.pregnancyCheck,
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
                        '${widget.animal.pregnanciesCount ?? 0}',
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
                      widget.animal.pregnant == true
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
                    widget.animal.dateOfSonar != null
                        ? Text(
                            DateFormat('dd/MM/yyyy')
                                .format(widget.animal.dateOfSonar!),
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          )
                        : Text(
                            'Add'.tr,
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
                  'Exp. Delivery Date',
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
                trailing: Row(
                  key: widget.monitorPregnancy,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add'.tr,
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
          visible: widget.animal.selectedOviGender == 'Female' &&
              widget.animal.selectedAnimalType == 'Oviparous',
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
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          )
                        : Text(
                            'Add',
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
                  'Number Of Eggs',
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    lastEvent.eggsNumber != null
                        ? Text(
                            '${lastEvent.eggsNumber}',
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          )
                        : Text(
                            'ADD',
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
                  'Have You Kept Eggs In Oval?'.tr,
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.animal.keptInOval.isNotEmpty
                        ? Text(
                            widget.animal.keptInOval == 'No'
                                ? 'No'.tr
                                : 'Yes'.tr,
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          )
                        : Text(
                            'ADD',
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                    const Icon(Icons.chevron_right_rounded,
                        color: AppColors.primary40),
                  ],
                ),
              ),
              Visibility(
                visible: widget.animal.keptInOval != 'No',
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
              onPressed: () async {},
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
          ],
        ),
        SizedBox(
          height: 14 * SizeConfig.heightMultiplier(context),
        ),
        Row(
          children: [
            PrimaryTextButton(
              onPressed: () {},
              text: 'Add Examination Results'.tr,
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
              'Surgeries Records'.tr,
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
    );
  }
}
