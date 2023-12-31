// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../data/classes.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/sar_buttonwidget.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../widgets/inputs/paragraph_text_fields/medical_needs_paragraph.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import '../../widgets/other/one_information_block.dart';
import '../../widgets/other/two_information_block.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import 'add_medical_checkup.dart';
import 'add_surgeries.dart';
import 'add_vaccination.dart';
import 'edit_medical_checkup.dart';
import 'edit_surgeries.dart';
import 'edit_vaccination.dart';

import 'pregnant_status_drawup.dart';

class MammalsMedical extends ConsumerStatefulWidget {
  final OviVariables OviDetails;
  final Function pregnancyStatusUpdated;
  const MammalsMedical({super.key, required this.OviDetails,
    required this.pregnancyStatusUpdated});

  @override
  ConsumerState<MammalsMedical> createState() => _MammalsMedicalState();
}

bool _isMammalEditMode = false;
bool? newMammalpregnantStatus;
String newmammalmatingdate = 'ADD';
String newmammalsonardate = 'ADD';
String newmammalexpdeliverydate = 'ADD';
DateTime? selectedmammalmatingDate;
DateTime? selectedmammalsonarDate;
DateTime? selectedmammalexpdeliveryDate;
List<String> mammalvaccineNames = ["Vaccine 1", "Vaccine 2", "Vaccine 3"];
List<String> mammalcheckUpNames = ["Check Up 1", "Check Up 2", "Check Up 3"];
List<String> mammalsurgeryNames = ["Surgery 1", "Surgery 2", "Surgery 3"];
List<VaccineDetails> mammalvaccineDetailsList = [];
List<MedicalCheckupDetails> mammalmedicalCheckupDetailsList = [];
List<SurgeryDetails> mammalsurgeryDetailsList = [];

class _MammalsMedicalState extends ConsumerState<MammalsMedical> {
  final TextEditingController medicalNeedsController = TextEditingController();
  final TextEditingController dateOfSonarController = TextEditingController();
  final TextEditingController dateOfLayingEggsController =
      TextEditingController();
  final TextEditingController numOfEggsController = TextEditingController();
  final TextEditingController expDlvDateController = TextEditingController();
  final TextEditingController incubationDateController =
      TextEditingController();
  late String keptInOval = widget.OviDetails.keptInOval;
  @override
  void initState() {
    super.initState();
    medicalNeedsController.text = widget.OviDetails.medicalNeeds;
    dateOfSonarController.text = widget.OviDetails.dateOfSonar;
    keptInOval = widget.OviDetails.keptInOval;
    expDlvDateController.text = widget.OviDetails.expDlvDate;
    dateOfLayingEggsController.text = widget.OviDetails.dateOfLayingEggs;
    numOfEggsController.text = widget.OviDetails.numOfEggs;
    incubationDateController.text = widget.OviDetails.incubationDate;
  }

  void _showexpdeliveryDatePickerModalSheet() async {
    final DateTime? expdeliveryDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
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

    if (expdeliveryDate != null &&
        expdeliveryDate != selectedmammalexpdeliveryDate) {
      setState(() {
        selectedmammalexpdeliveryDate = expdeliveryDate;
        expDlvDateController.text = DateFormat.yMMMd().format(expdeliveryDate);
        final updatedOviDetails = widget.OviDetails.copyWith(
          expDlvDate: expDlvDateController.text,
        );

        final oviAnimals = ref.read(ovianimalsProvider);
        final index = oviAnimals.indexOf(widget.OviDetails);
        if (index >= 0) {
          oviAnimals[index] = updatedOviDetails;
        }
      });
    }
  }

  void _dateOfSonarDatePickerModalSheet() async {
    final DateTime? dateOfSonar = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
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

    if (dateOfSonar != null) {
      setState(() {
        selectedmammalexpdeliveryDate = dateOfSonar;
        dateOfSonarController.text = DateFormat.yMMMd().format(dateOfSonar);
        final updatedOviDetails = widget.OviDetails.copyWith(
          dateOfSonar: dateOfSonarController.text,
        );

        final oviAnimals = ref.read(ovianimalsProvider);
        final index = oviAnimals.indexOf(widget.OviDetails);
        if (index >= 0) {
          oviAnimals[index] = updatedOviDetails;
        }
      });
    }
  }

  void _dateOfLayingEggsPickerModalSheet() async {
    final DateTime? dateOfLayingEggs = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
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

    if (dateOfLayingEggs != null &&
        dateOfLayingEggs != selectedmammalexpdeliveryDate) {
      setState(() {
        selectedmammalexpdeliveryDate = dateOfLayingEggs;
        dateOfLayingEggsController.text =
            DateFormat.yMMMd().format(dateOfLayingEggs);
        final updatedOviDetails = widget.OviDetails.copyWith(
          dateOfLayingEggs: dateOfLayingEggsController.text,
        );

        final oviAnimals = ref.read(ovianimalsProvider);
        final index = oviAnimals.indexOf(widget.OviDetails);
        if (index >= 0) {
          oviAnimals[index] = updatedOviDetails;
        }
      });
    }
  }

  void _incubationDatePickerModalSheet() async {
    final DateTime? incubationDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
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

    if (incubationDate != null &&
        incubationDate != selectedmammalexpdeliveryDate) {
      setState(() {
        selectedmammalexpdeliveryDate = incubationDate;
        incubationDateController.text =
            DateFormat.yMMMd().format(incubationDate);
        final updatedOviDetails = widget.OviDetails.copyWith(
          incubationDate: incubationDateController.text,
        );

        final oviAnimals = ref.read(ovianimalsProvider);
        final index = oviAnimals.indexOf(widget.OviDetails);
        if (index >= 0) {
          oviAnimals[index] = updatedOviDetails;
        }
      });
    }
  }

  void _showNumOfEggsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Number Of Eggs',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                PrimaryTextField(
                    hintText: 'Enter Number Of Eggs',
                    labelText: 'Enter Number Of Eggs',
                    controller: numOfEggsController),
                SizedBox(height: globals.heightMediaQuery * 130),
                ButtonWidget(
                  onPressed: () {
                    Navigator.pop(context);
                    final updatedOviDetails = widget.OviDetails.copyWith(
                        numOfEggs: numOfEggsController.text);

                    final oviAnimals = ref.read(ovianimalsProvider);
                    final index = oviAnimals.indexOf(widget.OviDetails);
                    if (index >= 0) {
                      oviAnimals[index] = updatedOviDetails;
                    }
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
          ),
        );
      },
    );
  }

  void _showKeptInOvalSelection(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.29,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Have You Kept In Oval?',
                  style: AppFonts.title3(color: AppColors.grayscale90),
                ),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: globals.heightMediaQuery * 12,
                      bottom: globals.heightMediaQuery * 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        keptInOval = 'Yes, Kept In Oval';
                        final updatedOviDetails = widget.OviDetails.copyWith(
                          keptInOval: keptInOval,
                        );

                        final oviAnimals = ref.read(ovianimalsProvider);
                        final index = oviAnimals.indexOf(widget.OviDetails);
                        if (index >= 0) {
                          oviAnimals[index] = updatedOviDetails;
                        }

                        Navigator.pop(context);
                      });
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Yes, Kept In Oval',
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                        ),
                        Container(
                          width: globals.widthMediaQuery * 24,
                          height: globals.widthMediaQuery * 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: keptInOval == 'Yes, Kept In Oval'
                                  ? AppColors.primary20
                                  : AppColors.grayscale30,
                              width:
                                  keptInOval == 'Yes, Kept In Oval' ? 6.0 : 1.0,
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
                        keptInOval = 'No';
                        final updatedOviDetails = widget.OviDetails.copyWith(
                          keptInOval: keptInOval,
                        );

                        final oviAnimals = ref.read(ovianimalsProvider);
                        final index = oviAnimals.indexOf(widget.OviDetails);
                        if (index >= 0) {
                          oviAnimals[index] = updatedOviDetails;
                        }

                        Navigator.pop(context);
                      });
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'No',
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                        ),
                        Container(
                          width: globals.widthMediaQuery * 24,
                          height: globals.widthMediaQuery * 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: keptInOval == 'No'
                                  ? AppColors.primary20
                                  : AppColors.grayscale30,
                              width: keptInOval == 'No' ? 6.0 : 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 55 * globals.heightMediaQuery,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPregnantStatusSelection(BuildContext context) {
    showModalBottomSheet<bool>(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return PregnantStatusWidget(
          mammalpregnantStatuses: widget.OviDetails.pregnant,
          newMammalpregnantStatus: newMammalpregnantStatus,
        );
      },
    ).then((newStatus) {
      widget.pregnancyStatusUpdated(newStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    final animalIndex = ref.read(ovianimalsProvider).indexWhere(
        (animal) => animal.animalName == widget.OviDetails.animalName);

    if (animalIndex == -1) {
      // Animal not found, you can show an error message or handle it accordingly
      return const Center(
        child: Text('Animal not found.'),
      );
    }

    final vaccineDetailsList = ref
            .read(ovianimalsProvider)[animalIndex]
            .vaccineDetails[widget.OviDetails.animalName] ??
        [];
    final medicalCheckUpList = ref
            .read(ovianimalsProvider)[animalIndex]
            .checkUpDetails[widget.OviDetails.animalName] ??
        [];
    final surgeryDetailsList = ref
            .read(ovianimalsProvider)[animalIndex]
            .surgeryDetails[widget.OviDetails.animalName] ??
        [];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: globals.widthMediaQuery * 343,
            child: const OneInformationBlock(
                head1: '29.02.2023', subtitle1: 'Next Vaccination'),
          ),
          SizedBox(
            height: globals.heightMediaQuery * 8,
          ),
          SizedBox(
            width: 343 * globals.widthMediaQuery,
            child: const TwoInformationBlock(
              head1: '12.02.2023',
              head2: '12.02.2023',
              subtitle1: "Last Check-up Date",
              subtitle2: 'Next Check-up Date',
            ),
          ),
          SizedBox(
            height: globals.heightMediaQuery * 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Medical Needs',
                style: AppFonts.title5(color: AppColors.grayscale90),
              ),
              _isMammalEditMode
                  ? PrimaryTextButton(
                      status: TextStatus.idle,
                      text: 'Save',
                      onPressed: () {
                        setState(() {
                          final updatedOviDetails = widget.OviDetails.copyWith(
                            medicalNeeds: medicalNeedsController.text,
                          );

                          final oviAnimals = ref.read(ovianimalsProvider);
                          final index = oviAnimals.indexOf(widget.OviDetails);
                          if (index >= 0) {
                            oviAnimals[index] = updatedOviDetails;
                          }

                          _isMammalEditMode = false;
                        });
                      })
                  : IconButton(
                      icon: Image.asset(
                        'assets/icons/frame/24px/24_Edit.png',
                      ),
                      onPressed: () {
                        // Enter edit mode
                        setState(() {
                          _isMammalEditMode = true;
                        });
                      },
                    ),
            ],
          ),
          _isMammalEditMode
              ? Column(
                  children: [
                    SizedBox(
                      height: globals.heightMediaQuery * 144,
                      child: MedicalNeedsParagraphTextField(
                        maxLines: 6,
                        hintText:
                            'Be sure to include joint support medicine, antibiotics, anti-inflammatory medication, and topical antiseptics when packing your first-aid kit for your horses. If you have the essentials, you can keep your four-legged friends in the best condition possible.',
                        controller: medicalNeedsController,
                      ),
                    ),
                    SizedBox(
                      height: globals.heightMediaQuery * 8,
                    ),
                    SizedBox(
                      height: globals.heightMediaQuery * 190,
                      child: const FileUploaderField(),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.OviDetails.medicalNeeds.isNotEmpty
                        ? Text(
                            widget.OviDetails.medicalNeeds,
                            // 'Be sure to include joint support medicine, antibiotics, anti-inflammatory medication, and topical antiseptics when packing your first-aid kit for your horses. If you have the essentials, you can keep your four-legged friends in the best condition possible.',
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          )
                        : Text(
                            'Be sure to include joint support medicine, antibiotics, anti-inflammatory medication, and topical antiseptics when packing your first-aid kit for your horses. If you have the essentials, you can keep your four-legged friends in the best condition possible.',
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                    SizedBox(
                      height: globals.heightMediaQuery * 22,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.file_copy_outlined,
                          color: AppColors.primary30,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'fileName',
                            style: AppFonts.body1(color: AppColors.grayscale90),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
          SizedBox(
            height: 16 * globals.heightMediaQuery,
          ),
          Visibility(
            visible: widget.OviDetails.selectedOviGender == 'Female' &&
                widget.OviDetails.selectedAnimalType == 'Mammal',
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '1',
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                      const Icon(Icons.chevron_right_rounded,
                          color: AppColors.primary40),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    _showPregnantStatusSelection(context);
                  },
                  contentPadding: const EdgeInsets.only(right: 0, left: 0),
                  leading: Text(
                    'Pregnancy status',
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.OviDetails.pregnant == true ? 'Pregnant'.tr : 'Not Pregnant'.tr,
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                      const Icon(Icons.chevron_right_rounded,
                          color: AppColors.primary40),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    _showexpdeliveryDatePickerModalSheet();
                  },
                  contentPadding: const EdgeInsets.only(right: 0, left: 0),
                  leading: Text(
                    'Date of Mating',
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '29.05.2023',
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                      const Icon(Icons.chevron_right_rounded,
                          color: AppColors.primary40),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    _dateOfSonarDatePickerModalSheet();
                  },
                  contentPadding: const EdgeInsets.only(right: 0, left: 0),
                  leading: Text(
                    'Date of sonar',
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      dateOfSonarController.text.isNotEmpty
                          ? Text(
                              dateOfSonarController.text,
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
                  onTap: () {
                    _showexpdeliveryDatePickerModalSheet();
                  },
                  contentPadding: const EdgeInsets.only(right: 0, left: 0),
                  leading: Text(
                    'Exp. Delivery Date',
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      expDlvDateController.text.isNotEmpty
                          ? Text(
                              expDlvDateController.text,
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
                SizedBox(height: 16 * globals.heightMediaQuery),
              ],
            ),
          ),
          Visibility(
            visible: widget.OviDetails.selectedOviGender == 'Female' &&
                widget.OviDetails.selectedAnimalType == 'Oviparous',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hatching Information',
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                ListTile(
                  onTap: () {
                    _dateOfLayingEggsPickerModalSheet();
                  },
                  contentPadding: const EdgeInsets.only(right: 0, left: 0),
                  leading: Text(
                    'Date Of Laying Eggs',
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      dateOfLayingEggsController.text.isNotEmpty
                          ? Text(
                              dateOfLayingEggsController.text,
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
                  onTap: () {
                    _showNumOfEggsModal(context);
                  },
                  contentPadding: const EdgeInsets.only(right: 0, left: 0),
                  leading: Text(
                    'Number Of Eggs',
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      numOfEggsController.text.isNotEmpty
                          ? Text(
                              numOfEggsController.text,
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
                  onTap: () {
                    _showKeptInOvalSelection(context);
                  },
                  contentPadding: const EdgeInsets.only(right: 0, left: 0),
                  leading: Text(
                    'Have You Kept Eggs In Oval?',
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      keptInOval.isNotEmpty
                          ? Text(
                              keptInOval,
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
                  onTap: () {
                    _incubationDatePickerModalSheet();
                  },
                  contentPadding: const EdgeInsets.only(right: 0, left: 0),
                  leading: Text(
                    'Incubation Date',
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      incubationDateController.text.isNotEmpty
                          ? Text(
                              incubationDateController.text,
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
                SizedBox(height: 16 * globals.heightMediaQuery),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vaccination',
                style: AppFonts.title5(color: AppColors.grayscale90),
              ),
              PrimaryTextButton(
                onPressed: () {},
                status: TextStatus.idle,
                text: 'View More',
              ),
            ],
          ),
          SizedBox(
            height: 14 * globals.heightMediaQuery,
          ),
          vaccineDetailsList.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: vaccineDetailsList.length,
                  shrinkWrap:
                      true, // This allows the ListView to take only necessary space
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        vaccineDetailsList[index].vaccineName,
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      ),
                      trailing: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.file_copy_outlined,
                            color: AppColors.primary40,
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.primary40,
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditVaccination(
                              OviDetails: widget.OviDetails,
                              breedingEvents: const [],
                              selectedVaccine: vaccineDetailsList[index],
                            ),
                          ),
                        );
                      },
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('yyyy-MM-dd').format(
                                vaccineDetailsList[index].firstDoseDate!),
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd').format(
                                vaccineDetailsList[index].secondDoseDate!),
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: 2,
                  shrinkWrap:
                      true, // This allows the ListView to take only necessary space
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.fromLTRB(
                          0,
                          10 * globals.heightMediaQuery,
                          0,
                          10 * globals.heightMediaQuery),
                      leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vaccine 1",
                              style: AppFonts.headline3(
                                  color: AppColors.grayscale90),
                            ),
                            Text(
                              '15.01.2022',
                              style:
                                  AppFonts.body2(color: AppColors.grayscale70),
                            ),
                          ]),
                      trailing: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.file_copy_outlined,
                            color: AppColors.primary40,
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.primary40,
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditVaccination(
                              breedingEvents: const [],
                              OviDetails: widget.OviDetails,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
          Row(
            children: [
              PrimaryTextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddVaccination(
                        onSave: (vaccineName, firstDoseDate, secondDoseDate) {
                          setState(() {
                            final oviVariables = ref.read(ovianimalsProvider);
                            final animalIndex = ref
                                .read(ovianimalsProvider)
                                .indexWhere((animal) =>
                                    animal.animalName ==
                                    widget.OviDetails.animalName);
                            // Get the current vaccineDetails map for the specific animal
                            final animalVaccineDetails =
                                oviVariables[animalIndex].vaccineDetails;

                            // Update the vaccineDetails map for that animal with the new vaccine details
                            ref.read(ovianimalsProvider)[animalIndex] =
                                oviVariables[animalIndex].copyWith(
                              vaccineDetails: {
                                ...animalVaccineDetails,
                                widget.OviDetails.animalName: [
                                  ...animalVaccineDetails[
                                          widget.OviDetails.animalName] ??
                                      [],
                                  VaccineDetails(
                                    vaccineName: vaccineName,
                                    firstDoseDate: firstDoseDate,
                                    secondDoseDate: secondDoseDate,
                                  ),
                                ],
                              },
                            );

                            // Add the vaccine details to the vaccineDetailsListProvider if needed
                            ref.read(vaccineDetailsListProvider).add(
                                  VaccineDetails(
                                    vaccineName: vaccineName,
                                    firstDoseDate: firstDoseDate,
                                    secondDoseDate: secondDoseDate,
                                  ),
                                );
                          });
                        },
                      ),
                    ),
                  );
                },
                text: 'Add Vaccination',
                status: TextStatus.idle,
              ),
              SizedBox(
                width: 8 * globals.widthMediaQuery,
              ),
              Icon(
                Icons.add,
                color: AppColors.primary40,
                size: 16 * globals.widthMediaQuery,
              ),
            ],
          ),
          SizedBox(
            height: 16 * globals.heightMediaQuery,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Medical Checkup',
                style: AppFonts.title5(color: AppColors.grayscale90),
              ),
              PrimaryTextButton(
                onPressed: () {},
                status: TextStatus.idle,
                text: 'View More',
              ),
            ],
          ),
          SizedBox(
            height: 14 * globals.heightMediaQuery,
          ),
          medicalCheckUpList.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: medicalCheckUpList.length,
                  shrinkWrap:
                      true, // This allows the ListView to take only necessary space
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        medicalCheckUpList[index].checkupName,
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      ),
                      trailing: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.file_copy_outlined,
                            color: AppColors.primary40,
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.primary40,
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditMedicalCheckUp(
                              OviDetails: widget.OviDetails,
                              breedingEvents: const [],
                              selectedCheckup: medicalCheckUpList[index],
                            ),
                          ),
                        );
                      },
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('yyyy-MM-dd').format(
                                medicalCheckUpList[index].firstCheckUp!),
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd').format(
                                medicalCheckUpList[index].secondCheckUp!),
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: 3,
                  shrinkWrap:
                      true, // This allows the ListView to take only necessary space
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.fromLTRB(
                          0,
                          10 * globals.heightMediaQuery,
                          0,
                          10 * globals.heightMediaQuery),
                      leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Check-Up 1",
                              style: AppFonts.headline3(
                                  color: AppColors.grayscale90),
                            ),
                            Text(
                              '15.01.2022',
                              style:
                                  AppFonts.body2(color: AppColors.grayscale70),
                            ),
                          ]),
                      trailing: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.file_copy_outlined,
                            color: AppColors.primary40,
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.primary40,
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditMedicalCheckUp(
                              OviDetails: widget.OviDetails,
                              breedingEvents: const [],
                              selectedCheckup: medicalCheckUpList[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
          Row(
            children: [
              PrimaryTextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMedicalCheckUp(
                        onSave: (checkUpName, firstCheckUp, secondCheckUp) {
                          setState(() {
                            final oviVariables = ref.read(ovianimalsProvider);
                            final animalIndex = ref
                                .read(ovianimalsProvider)
                                .indexWhere((animal) =>
                                    animal.animalName ==
                                    widget.OviDetails.animalName);
                            // Get the current vaccineDetails map for the specific animal
                            final animalCheckUpDetails =
                                oviVariables[animalIndex].checkUpDetails;

                            // Update the vaccineDetails map for that animal with the new vaccine details
                            ref.read(ovianimalsProvider)[animalIndex] =
                                oviVariables[animalIndex].copyWith(
                              checkUpDetails: {
                                ...animalCheckUpDetails,
                                widget.OviDetails.animalName: [
                                  ...animalCheckUpDetails[
                                          widget.OviDetails.animalName] ??
                                      [],
                                  MedicalCheckupDetails(
                                    checkupName: checkUpName,
                                    firstCheckUp: firstCheckUp,
                                    secondCheckUp: secondCheckUp,
                                  ),
                                ],
                              },
                            );

                            // Add the vaccine details to the vaccineDetailsListProvider if needed
                            ref.read(medicalCheckupDetailsProvider).add(
                                  MedicalCheckupDetails(
                                    checkupName: checkUpName,
                                    firstCheckUp: firstCheckUp,
                                    secondCheckUp: secondCheckUp,
                                  ),
                                );
                          });
                        },
                      ),
                    ),
                  );
                },
                text: 'Add Examination Results',
                status: TextStatus.idle,
              ),
              SizedBox(
                width: 8 * globals.widthMediaQuery,
              ),
              Icon(
                Icons.add,
                color: AppColors.primary40,
                size: 16 * globals.widthMediaQuery,
              ),
            ],
          ),
          SizedBox(
            height: 16 * globals.heightMediaQuery,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Surgeries Records',
                style: AppFonts.title5(color: AppColors.grayscale90),
              ),
              PrimaryTextButton(
                onPressed: () {},
                status: TextStatus.idle,
                text: 'View More',
              ),
            ],
          ),
          SizedBox(
            height: 14 * globals.heightMediaQuery,
          ),
          surgeryDetailsList.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: surgeryDetailsList.length,
                  shrinkWrap:
                      true, // This allows the ListView to take only necessary space
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        surgeryDetailsList[index].surgeryName,
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      ),
                      trailing: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.file_copy_outlined,
                            color: AppColors.primary40,
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.primary40,
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditSurgeriesRecords(
                              breedingEvents: const [],
                              OviDetails: widget.OviDetails,
                              selectedSurgery: surgeryDetailsList[index],
                            ),
                          ),
                        );
                      },
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('yyyy-MM-dd').format(
                                surgeryDetailsList[index].firstSurgery!),
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd').format(
                                surgeryDetailsList[index].secondSurgery!),
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: 3,
                  shrinkWrap:
                      true, // This allows the ListView to take only necessary space
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.fromLTRB(
                          0,
                          10 * globals.heightMediaQuery,
                          0,
                          10 * globals.heightMediaQuery),
                      leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Surgeries 1",
                              style: AppFonts.headline3(
                                  color: AppColors.grayscale90),
                            ),
                            Text(
                              '15.01.2022',
                              style:
                                  AppFonts.body2(color: AppColors.grayscale70),
                            ),
                          ]),
                      trailing: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.file_copy_outlined,
                            color: AppColors.primary40,
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.primary40,
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditSurgeriesRecords(
                              breedingEvents: const [],
                              OviDetails: widget.OviDetails,
                              selectedSurgery: surgeryDetailsList[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
          Row(
            children: [
              PrimaryTextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddSurgeriesRecords(
                        onSave: (surgeryName, firstSurgery, secondSurgery) {
                          setState(() {
                            final oviVariables = ref.read(ovianimalsProvider);
                            final animalIndex = ref
                                .read(ovianimalsProvider)
                                .indexWhere((animal) =>
                                    animal.animalName ==
                                    widget.OviDetails.animalName);
                            // Get the current vaccineDetails map for the specific animal
                            final animalSurgeryDetails =
                                oviVariables[animalIndex].surgeryDetails;

                            // Update the vaccineDetails map for that animal with the new vaccine details
                            ref.read(ovianimalsProvider)[animalIndex] =
                                oviVariables[animalIndex].copyWith(
                              surgeryDetails: {
                                ...animalSurgeryDetails,
                                widget.OviDetails.animalName: [
                                  ...animalSurgeryDetails[
                                          widget.OviDetails.animalName] ??
                                      [],
                                  SurgeryDetails(
                                    surgeryName: surgeryName,
                                    firstSurgery: firstSurgery,
                                    secondSurgery: secondSurgery,
                                  ),
                                ],
                              },
                            );

                            // Add the vaccine details to the vaccineDetailsListProvider if needed
                            ref.read(surgeryDetailsProvider).add(
                                  SurgeryDetails(
                                    surgeryName: surgeryName,
                                    firstSurgery: firstSurgery,
                                    secondSurgery: secondSurgery,
                                  ),
                                );
                          });
                        },
                      ),
                    ),
                  );
                },
                text: 'Add Surgeries Records',
                status: TextStatus.idle,
              ),
              SizedBox(
                width: 8 * globals.widthMediaQuery,
              ),
              Icon(
                Icons.add,
                color: AppColors.primary40,
                size: 16 * globals.widthMediaQuery,
              ),
            ],
          ),
          SizedBox(
            height: 24 * globals.heightMediaQuery,
          ),
        ],
      ),
    );
  }
}
