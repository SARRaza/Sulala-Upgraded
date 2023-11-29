// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../widgets/inputs/paragraph_text_fields/medical_needs_paragraph.dart';
import '../../widgets/other/one_information_block.dart';
import '../../widgets/other/two_information_block.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../create_animal/sar_listofanimals.dart';
import 'add_medical_checkup.dart';
import 'add_surgeries.dart';
import 'add_vaccination.dart';
import 'edit_medical_checkup.dart';
import 'edit_surgeries.dart';
import 'edit_vaccination.dart';
import 'is_pregnant_drawup.dart';
import 'pregnant_status_drawup.dart';

class MammalsMedical extends ConsumerStatefulWidget {
  final OviVariables OviDetails;
  const MammalsMedical({super.key, required this.OviDetails});

  @override
  ConsumerState<MammalsMedical> createState() => _MammalsMedicalState();
}

bool _isMammalEditMode = false;
bool _isFemale = true;
bool? newMammalpregnantStatus;
bool mammalpregnantStatuses = false;
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
  final TextEditingController expDlvDateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    medicalNeedsController.text = widget.OviDetails.medicalNeeds;
    dateOfSonarController.text = widget.OviDetails.dateOfSonar;
    expDlvDateController.text = widget.OviDetails.expDlvDate;
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

    if (dateOfSonar != null && dateOfSonar != selectedmammalexpdeliveryDate) {
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

  void _showPregnantStatusSelection(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return PregnantStatusWidget(
          mammalpregnantStatuses: mammalpregnantStatuses,
          newMammalpregnantStatus: newMammalpregnantStatus,
        );
      },
    ).then((_) {
      setState(() {
        newMammalpregnantStatus == mammalpregnantStatuses;
      });
    });
  }

  void _showIsPregnantSelection(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return IsPregnantWidget(
          mammalpregnantStatuses: mammalpregnantStatuses,
          newMammalpregnantStatus: newMammalpregnantStatus,
        );
      },
    ).then((_) {
      setState(() {
        newMammalpregnantStatus == mammalpregnantStatuses;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
            visible: _isFemale,
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
                        'Not Pregnant',
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
          ListView.builder(
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
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      ),
                      Text(
                        '15.01.2022',
                        style: AppFonts.body2(color: AppColors.grayscale70),
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
                      builder: (context) => const EditVaccination(),
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
                      builder: (context) => const AddVaccination(),
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
          ListView.builder(
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
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      ),
                      Text(
                        '15.01.2022',
                        style: AppFonts.body2(color: AppColors.grayscale70),
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
                      builder: (context) => const EditMedicalCheckUp(),
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
                      builder: (context) => const AddMedicalCheckUp(),
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
          ListView.builder(
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
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      ),
                      Text(
                        '15.01.2022',
                        style: AppFonts.body2(color: AppColors.grayscale70),
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
                      builder: (context) => const EditSurgeriesRecords(),
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
                      builder: (context) => const AddSurgeriesRecords(),
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

class VaccineDetails {
  final String mammalvaccineName;
  final DateTime? firstDoseDate;
  final DateTime? secondDoseDate;

  VaccineDetails({
    required this.mammalvaccineName,
    this.firstDoseDate,
    this.secondDoseDate,
  });
}

class MedicalCheckupDetails {
  final String mammalcheckupName;
  final DateTime? mammalcheckupDate;

  MedicalCheckupDetails({
    required this.mammalcheckupName,
    this.mammalcheckupDate,
  });
}

class SurgeryDetails {
  final String mammalsurgeryName;
  final DateTime? mammalsurgeryDate;

  SurgeryDetails({
    required this.mammalsurgeryName,
    this.mammalsurgeryDate,
  });
}
