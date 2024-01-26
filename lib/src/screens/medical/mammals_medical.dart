// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sulala_upgrade/src/screens/pdf/file_view_page.dart';
import 'package:sulala_upgrade/src/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:sulala_upgrade/src/widgets/inputs/draw_ups/draw_up_widget.dart';
import 'package:sulala_upgrade/src/widgets/inputs/text_fields/primary_text_field.dart';
import '../../data/classes.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/animal_info_modal_sheets.dart/eggs_number_modal.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../widgets/inputs/paragraph_text_fields/medical_needs_paragraph.dart';
import '../../widgets/other/one_information_block.dart';
import '../../widgets/other/two_information_block.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../pdf/pdf_view_page.dart';
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
  const MammalsMedical(
      {super.key,
      required this.OviDetails,
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
  late final TextEditingController medicalNeedsController;
  late final TextEditingController dateOfSonarController;
  late final TextEditingController dateOfLayingEggsController;
  late final TextEditingController numOfEggsController;
  late final TextEditingController expDlvDateController;
  late final TextEditingController incubationDateController;
  late final TextEditingController pregnanciesCountController;
  late String keptInOval;

  late int animalIndex;

  BreedingEventVariables? lastBreedingEvent;

  late OviVariables animalDetails;

  List<File>? files;

  late List<SurgeryDetails> surgeryDetailsList;
  DateTime? nextVaccinationDate;
  DateTime? lastCheckupDate;
  DateTime? nextCheckupDate;
  DateTime? matingDate;

  late List<VaccineDetails> vaccineDetailsList;

  late List<MedicalCheckupDetails> medicalCheckUpList;

  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    animalIndex = ref.read(ovianimalsProvider).indexWhere(
            (animal) => animal.animalName == widget.OviDetails.animalName);

    animalDetails = ref.watch(ovianimalsProvider)[animalIndex];


    files = animalDetails.files;
    vaccineDetailsList = ref
        .read(ovianimalsProvider)[animalIndex]
        .vaccineDetails[widget.OviDetails.animalName] ??
        [];
    medicalCheckUpList = ref
        .read(ovianimalsProvider)[animalIndex]
        .checkUpDetails[widget.OviDetails.animalName] ??
        [];
    surgeryDetailsList = ref
        .read(ovianimalsProvider)[animalIndex]
        .surgeryDetails[widget.OviDetails.animalName] ??
        [];
    final now = DateTime.now();
    final futureVaccinations = vaccineDetailsList
        .where((details) =>
    (details.firstDoseDate != null &&
        details.firstDoseDate!.isAfter(now)) ||
        (details.secondDoseDate != null &&
            details.secondDoseDate!.isAfter(now)))
        .toList();

    for (var vaccination in futureVaccinations) {
      if (vaccination.firstDoseDate != null &&
          vaccination.firstDoseDate!.isAfter(now) &&
          (nextVaccinationDate == null ||
              vaccination.firstDoseDate!.isBefore(nextVaccinationDate!))) {
        nextVaccinationDate = vaccination.firstDoseDate;
      }
      if (vaccination.secondDoseDate != null &&
          vaccination.secondDoseDate!.isAfter(now) &&
          (nextVaccinationDate == null ||
              vaccination.secondDoseDate!.isBefore(nextVaccinationDate!))) {
        nextVaccinationDate = vaccination.secondDoseDate;
      }
    }

    final pastMedicalCheckups = medicalCheckUpList
        .where((checkup) =>
    (checkup.firstCheckUp != null &&
        checkup.firstCheckUp!.isBefore(now)) ||
        (checkup.secondCheckUp != null &&
            checkup.secondCheckUp!.isBefore(now)))
        .toList();

    for (var checkup in pastMedicalCheckups) {
      if (checkup.firstCheckUp != null &&
          checkup.firstCheckUp!.isBefore(now) &&
          (lastCheckupDate == null ||
              checkup.firstCheckUp!.isBefore(lastCheckupDate!))) {
        lastCheckupDate = checkup.firstCheckUp;
      }
      if (checkup.secondCheckUp != null &&
          checkup.secondCheckUp!.isBefore(now) &&
          (lastCheckupDate == null ||
              checkup.secondCheckUp!.isBefore(lastCheckupDate!))) {
        lastCheckupDate = checkup.secondCheckUp;
      }
    }
    final futureMedicalCheckups = medicalCheckUpList
        .where((checkup) =>
    (checkup.firstCheckUp != null &&
        checkup.firstCheckUp!.isAfter(now)) ||
        (checkup.secondCheckUp != null &&
            checkup.secondCheckUp!.isAfter(now)))
        .toList();

    for (var checkup in futureMedicalCheckups) {
      if (checkup.firstCheckUp != null &&
          checkup.firstCheckUp!.isAfter(now) &&
          (nextCheckupDate == null ||
              checkup.firstCheckUp!.isBefore(nextCheckupDate!))) {
        nextCheckupDate = checkup.firstCheckUp;
      }
      if (checkup.secondCheckUp != null &&
          checkup.secondCheckUp!.isAfter(now) &&
          (nextCheckupDate == null ||
              checkup.secondCheckUp!.isBefore(nextCheckupDate!))) {
        nextCheckupDate = checkup.secondCheckUp;
      }
    }

    final breedingEvents = animalDetails.breedingEvents[animalDetails
        .animalName];
    lastBreedingEvent = breedingEvents!.isNotEmpty ? breedingEvents.last : null;
    if(lastBreedingEvent != null) {
      final breedingDateSegments = lastBreedingEvent!.breedingDate.split('/');
      final breedingDate = breedingDateSegments.length == 3
          ? DateTime(
          int.parse(breedingDateSegments[2]),
          int.parse(breedingDateSegments[1]),
          int.parse(breedingDateSegments[0]))
          : null;
      if (breedingDate != null &&
          (matingDate == null || breedingDate.isAfter(matingDate!))) {
        matingDate = breedingDate;
      }
    }


    if (!initialized) {
      keptInOval = widget.OviDetails.keptInOval;
      medicalNeedsController =
          TextEditingController(text: widget.OviDetails.medicalNeeds);
      dateOfSonarController =
          TextEditingController(text: widget.OviDetails.dateOfSonar);

      DateTime? expectedDeliveryDate;
      final isPregnant = animalDetails.pregnant ?? false;
      if (widget.OviDetails.selectedOviGender == 'Female' &&
          widget.OviDetails.selectedAnimalType == 'Mammal' &&
          lastBreedingEvent != null) {
        // final gestationPeriod =
        //     gestationPeriods[animalDetails.selectedAnimalSpecies];
        // expectedDeliveryDate =
        //     calculateExpectedDeliveryDate(matingDate!, gestationPeriod!);

        expDlvDateController =
            TextEditingController(text: lastBreedingEvent!.deliveryDate);
      } else {
        expDlvDateController = TextEditingController();
      }
      if (animalDetails.selectedOviGender == 'Female' &&
          animalDetails.selectedAnimalType == 'Oviparous' &&
          lastBreedingEvent != null) {
        dateOfLayingEggsController = TextEditingController(
            text: lastBreedingEvent!.layingEggsDate ?? '');
        numOfEggsController = TextEditingController(
            text: (lastBreedingEvent!.eggsNumber ?? 0).toString());
        incubationDateController = TextEditingController(
            text: lastBreedingEvent!.incubationDate ?? '');
      } else {
        dateOfLayingEggsController = TextEditingController();
        numOfEggsController = TextEditingController();
        incubationDateController = TextEditingController();
      }
      pregnanciesCountController =
          TextEditingController(text: '${animalDetails.pregnanciesCount ?? 0}');

      initialized = true;
    }

    if (animalIndex == -1) {
      // Animal not found, you can show an error message or handle it accordingly
      return const Center(
        child: Text('Animal not found.'),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: globals.widthMediaQuery * 343,
            child: OneInformationBlock(
                head1: nextVaccinationDate != null
                    ? DateFormat('dd.MM.yyyy').format(nextVaccinationDate!)
                    : 'N/A',
                subtitle1: 'Next Vaccination'),
          ),
          SizedBox(
            height: globals.heightMediaQuery * 8,
          ),
          SizedBox(
            width: 343 * globals.widthMediaQuery,
            child: TwoInformationBlock(
              head1: lastCheckupDate != null
                  ? DateFormat('dd.MM.yyyy').format(lastCheckupDate!)
                  : 'N/A',
              head2: nextCheckupDate != null
                  ? DateFormat('dd.MM.yyyy').format(nextCheckupDate!)
                  : 'N/A',
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
                        ref
                            .read(ovianimalsProvider.notifier)
                            .update((state) {
                          state[index] = updatedOviDetails;
                          return state;
                        });
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
                height: globals.heightMediaQuery * 210,
                child: FileUploaderField(
                  onFileUploaded: (file) {
                    ref.read(ovianimalsProvider.notifier).update((state) {
                      final files = state[animalIndex].files ?? [];
                      files.add(file);
                      state[animalIndex] =
                          state[animalIndex].copyWith(files: files);

                      return state;
                    });
                  },
                ),
              ),
            ],
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ref
                  .read(ovianimalsProvider)[animalIndex]
                  .medicalNeeds
                  .isNotEmpty
                  ? Text(
                ref
                    .read(ovianimalsProvider)[animalIndex]
                    .medicalNeeds,
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
              if (files != null)
                Column(
                  children: files!
                      .map((file) => GestureDetector(
                    onTap: () => showFile(file),
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
                  trailing: GestureDetector(
                    onTap: () => showPregnanciesCountModal(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${animalDetails.pregnanciesCount ?? 0}',
                          style: AppFonts.body2(color: AppColors.grayscale90),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: AppColors.primary40),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    _showPregnantStatusSelection(
                        context, animalDetails.pregnant ?? false);
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
                        widget.OviDetails.pregnant == true
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
                        matingDate != null
                            ? DateFormat('dd.MM.yyyy').format(matingDate!)
                            : 'N/A',
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
                        keptInOval == 'No' ? 'No'.tr : 'Yes'.tr,
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
                  visible: keptInOval != 'No',
                  child: ListTile(
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
          if (vaccineDetailsList.isNotEmpty)
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vaccineDetailsList.length,
              shrinkWrap:
              true, // This allows the ListView to take only necessary space
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart, // Enable swipe from right to left
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red, // Background color for delete action
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  confirmDismiss: _confirmDeletion,
                  onDismissed: (direction) {
                    setState(() {
                      vaccineDetailsList.removeAt(index);
                      ref.read(ovianimalsProvider.notifier).update((state) {
                        state[animalIndex] = state[animalIndex].copyWith(
                          vaccineDetails: {
                            state[animalIndex].animalName: vaccineDetailsList}
                        );
                        return state;
                      });
                    });
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      vaccineDetailsList[index].vaccineName,
                      style: AppFonts.headline3(color: AppColors.grayscale90),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (vaccineDetailsList[index].files != null &&
                            vaccineDetailsList[index].files!.isNotEmpty)
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FileViewPage(
                                          files:
                                          vaccineDetailsList[index].files!)));
                            },
                            icon: const Icon(
                              Icons.file_copy_outlined,
                              color: AppColors.primary40,
                            ),
                          ),
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          child: const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.primary40,
                          ),
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
                    subtitle: vaccineDetailsList[index].firstDoseDate != null ||
                        vaccineDetailsList[index].secondDoseDate != null ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vaccineDetailsList[index].firstDoseDate != null
                              ? DateFormat('yyyy-MM-dd').format(
                              vaccineDetailsList[index].firstDoseDate!)
                              : '',
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                        Text(
                          vaccineDetailsList[index].secondDoseDate != null
                              ? DateFormat('yyyy-MM-dd').format(
                              vaccineDetailsList[index].secondDoseDate!)
                              : '',
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                      ],
                    ) : null,
                  ),
                );
              },
            ),
          Row(
            children: [
              PrimaryTextButton(
                onPressed: () async {
                  await Navigator.push(
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
                                          files: ref
                                              .read(uploadedFilesProvider)
                                              .map((path) => File(path))
                                              .toList()),
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
                  setState(() {});
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
          if (medicalCheckUpList.isNotEmpty)
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: medicalCheckUpList.length,
              shrinkWrap:
              true, // This allows the ListView to take only necessary space
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart, // Enable swipe from right to left
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red, // Background color for delete action
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  confirmDismiss: _confirmDeletion,
                  onDismissed: (direction) {
                    setState(() {
                      medicalCheckUpList.removeAt(index);
                      ref.read(ovianimalsProvider.notifier).update((state) {
                        state[animalIndex] = state[animalIndex].copyWith(
                          checkUpDetails: {
                            state[animalIndex].animalName: medicalCheckUpList}
                        );
                        return state;
                      });
                    });
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      medicalCheckUpList[index].checkupName,
                      style: AppFonts.headline3(color: AppColors.grayscale90),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (medicalCheckUpList[index].files != null &&
                            medicalCheckUpList[index].files!.isNotEmpty)
                          IconButton(
                            onPressed: () =>
                                showFiles(medicalCheckUpList[index].files!),
                            icon: const Icon(
                              Icons.file_copy_outlined,
                              color: AppColors.primary40,
                            ),
                          ),
                        const SizedBox(
                          width: 8,
                        ),
                        IconButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditMedicalCheckUp(
                                OviDetails: widget.OviDetails,
                                breedingEvents: const [],
                                selectedCheckup: medicalCheckUpList[index],
                              ),
                            ),
                          ),
                          icon: const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.primary40,
                          ),
                        ),
                      ],
                    ),
                    subtitle: medicalCheckUpList[index].firstCheckUp != null ||
                        medicalCheckUpList[index].secondCheckUp != null ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medicalCheckUpList[index].firstCheckUp != null
                              ? DateFormat('yyyy-MM-dd')
                              .format(medicalCheckUpList[index].firstCheckUp!)
                              : '',
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                        Text(
                          medicalCheckUpList[index].secondCheckUp != null
                              ? DateFormat('yyyy-MM-dd').format(
                              medicalCheckUpList[index].secondCheckUp!)
                              : '',
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                      ],
                    ) : null,
                  ),
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
                            ref
                                .read(ovianimalsProvider.notifier)
                                .update((state) {
                              state[animalIndex] =
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
                                            files: ref
                                                .read(uploadedFilesProvider)
                                                .map((path) => File(path))
                                                .toList()),
                                      ],
                                    },
                                  );

                              return state;
                            });

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
          if (surgeryDetailsList.isNotEmpty)
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: surgeryDetailsList.length,
              shrinkWrap:
              true, // This allows the ListView to take only necessary space
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart, // Enable swipe from right to left
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red, // Background color for delete action
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  confirmDismiss: _confirmDeletion,
                  onDismissed: (direction) {
                    setState(() {
                      surgeryDetailsList.removeAt(index);
                      ref.read(ovianimalsProvider.notifier).update((state) {
                        state[animalIndex] = state[animalIndex].copyWith(
                          surgeryDetails: {
                            state[animalIndex].animalName: surgeryDetailsList
                          }
                        );
                        return state;
                      });
                    });
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      surgeryDetailsList[index].surgeryName,
                      style: AppFonts.headline3(color: AppColors.grayscale90),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (surgeryDetailsList[index].files != null &&
                            surgeryDetailsList[index].files!.isNotEmpty)
                          IconButton(
                            onPressed: () =>
                                showFiles(surgeryDetailsList[index].files!),
                            icon: const Icon(
                              Icons.file_copy_outlined,
                              color: AppColors.primary40,
                            ),
                          ),
                        const SizedBox(
                          width: 8,
                        ),
                        IconButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditSurgeriesRecords(
                                  breedingEvents: const [],
                                  OviDetails: widget.OviDetails,
                                  selectedSurgery: surgeryDetailsList[index],
                                ),
                              ),
                            );
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.primary40,
                          ),
                        ),
                      ],
                    ),
                    subtitle: surgeryDetailsList[index].firstSurgery != null ||
                        surgeryDetailsList[index].secondSurgery != null ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('yyyy-MM-dd').format(
                              surgeryDetailsList[index].firstSurgery ??
                                  DateTime.now()),
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd').format(
                              surgeryDetailsList[index].secondSurgery ??
                                  DateTime.now()),
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                      ],
                    ) : null,
                  ),
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
                                          files: ref
                                              .read(uploadedFilesProvider)
                                              .map((path) => File(path))
                                              .toList()),
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

    setState(() {
      if (dateOfLayingEggs != null) {
        dateOfLayingEggsController.text =
            DateFormat('dd/MM/yyyy').format(dateOfLayingEggs);
      } else {
        dateOfLayingEggsController.text = '';
      }
    });

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

    if (dateOfLayingEggs != null && lastBreedingEvent != null) {
      final breedingEvents =
          animalDetails.breedingEvents[animalDetails.animalName];
      final eventIndex = breedingEvents!.indexWhere(
          (event) => event.eventNumber == lastBreedingEvent!.eventNumber);
      ref.read(ovianimalsProvider.notifier).update((state) {
        final events =
            state[animalIndex].breedingEvents[animalDetails.animalName];
        events![eventIndex] = events[eventIndex].copyWith(
            layingEggsDate: DateFormat('dd/MM/yyyy').format(dateOfLayingEggs));
        state[animalIndex] = state[animalIndex]
            .copyWith(breedingEvents: {animalDetails.animalName: events});
        return state;
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

  Future<void> _showNumOfEggsModal(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (BuildContext context) {
        return EggsNumberModal(
          controller: numOfEggsController,
        );
      },
    );

    if (lastBreedingEvent != null) {
      final breedingEvents =
          animalDetails.breedingEvents[animalDetails.animalName];
      final eventIndex = breedingEvents!.indexWhere(
          (event) => event.eventNumber == lastBreedingEvent!.eventNumber);
      ref.read(ovianimalsProvider.notifier).update((state) {
        final events =
            state[animalIndex].breedingEvents[animalDetails.animalName];
        final eggsNumber = numOfEggsController.text.isNum
            ? int.parse(numOfEggsController.text)
            : 0;
        events![eventIndex] =
            events[eventIndex].copyWith(eggsNumber: eggsNumber);
        state[animalIndex] = state[animalIndex]
            .copyWith(breedingEvents: {animalDetails.animalName: events});
        return state;
      });
    }
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
        );
      },
    );
  }

  void _showPregnantStatusSelection(
      BuildContext context, bool currentPregnantStatus) {
    showModalBottomSheet<bool>(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return PregnantStatusWidget(
          mammalpregnantStatuses: currentPregnantStatus,
        );
      },
    ).then((newStatus) {
      if (currentPregnantStatus == false && newStatus == true) {
        ref.read(ovianimalsProvider.notifier).update((state) {
          state[animalIndex] = state[animalIndex].copyWith(
              pregnant: true,
              pregnanciesCount: (state[animalIndex].pregnanciesCount ?? 0) + 1);
          return state;
        });
      } else {
        ref.read(ovianimalsProvider.notifier).update((state) {
          state[animalIndex] = state[animalIndex].copyWith(
            pregnant: newStatus,
          );
          return state;
        });
      }
      widget.pregnancyStatusUpdated(newStatus);
    });
  }



  Future<void> showFile(File file) async {
    final fileName = file.path.split('/').last;
    if (mounted) {
      if (fileName.endsWith('.pdf')) {
        // Open PDF
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PDFViewPage(file: file)),
        );
      } else {
        // Open Image in a new screen or dialog
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Image.file(file),
          ),
        );
      }
    }
  }

  DateTime calculateExpectedDeliveryDate(
      DateTime matingDate, int gestationPeriod) {
    return matingDate.add(Duration(days: gestationPeriod));
  }

  showFiles(List<File> files) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FileViewPage(files: files)));
  }

  Future<void> showPregnanciesCountModal() async {
    final newCount = await showModalBottomSheet(
        showDragHandle: true,
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            child: DrowupWidget(
              heightFactor: 0.45,
              heading: 'Pregnancies count',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      PrimaryTextField(
                          keyboardType: TextInputType.number,
                          hintText: 'Enter pregnancies count',
                          controller: pregnanciesCountController),
                      SizedBox(
                        height: 55 * globals.heightMediaQuery,
                      ),
                      SizedBox(
                        width: 343 * globals.widthMediaQuery,
                        height: 52 * globals.heightMediaQuery,
                        child: PrimaryButton(
                            text: 'Confirm',
                            onPressed: () {
                              Navigator.pop(context,
                                  int.parse(pregnanciesCountController.text));
                            }),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
    if (newCount != null) {
      setState(() {
        ref.read(ovianimalsProvider.notifier).update((state) {
          state[animalIndex] =
              state[animalIndex].copyWith(pregnanciesCount: newCount);
          return state;
        });
      });
    }
  }

  Future<bool?> _confirmDeletion(DismissDirection direction) {
    return showDialog(context: context, builder: (context) =>
        ConfirmDeleteDialog(
            content: 'Are you sure to delete the details, files etc.?'.tr));
  }
}
