// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../data/classes.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/navigate_button.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

class EditMedicalCheckUp extends ConsumerStatefulWidget {
  final OviVariables OviDetails;
  final List<BreedingEventVariables> breedingEvents;
  final MedicalCheckupDetails? selectedCheckup;

  const EditMedicalCheckUp(
      {super.key,
      required this.breedingEvents,
      this.selectedCheckup,
      required this.OviDetails});
  @override
  ConsumerState<EditMedicalCheckUp> createState() => _EditMedicalCheckUpState();
}

class _EditMedicalCheckUpState extends ConsumerState<EditMedicalCheckUp> {
  TextEditingController checkUpNameController = TextEditingController();
  DateTime? firstCheckUp;
  DateTime? secondCheckUp;
  List<MedicalCheckupDetails> checkupDetailsList = [];
  @override
  void initState() {
    super.initState();

    if (widget.selectedCheckup != null) {
      // Initialize text controller and date variables with selected vaccine details
      checkUpNameController.text = widget.selectedCheckup!.checkupName;
      firstCheckUp = widget.selectedCheckup!.firstCheckUp;
      secondCheckUp = widget.selectedCheckup!.secondCheckUp;
    }
  }

  void updateCheckUpDetailsList(MedicalCheckupDetails updatedCheckup) {
    int index = checkupDetailsList.indexWhere(
        (checkup) => checkup.checkupName == updatedCheckup.checkupName);

    // Replace the old vaccine with the updated one
    if (index != -1) {
      checkupDetailsList[index] = updatedCheckup;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: Container(
                padding: EdgeInsets.all(8 * globals.widthMediaQuery),
                decoration: const BoxDecoration(
                    color: AppColors.grayscale10, shape: BoxShape.circle),
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: 16 * globals.widthMediaQuery,
                right: 16 * globals.widthMediaQuery),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Edit Medical Checkup",
                  style: AppFonts.title3(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: 32 * globals.heightMediaQuery,
                ),
                PrimaryTextField(
                  hintText: 'Checkup Name',
                  controller: checkUpNameController,
                  labelText: 'Checkup Name',
                ),
                SizedBox(height: 24 * globals.heightMediaQuery),
                PrimaryDateField(
                  hintText: DateFormat('yyyy-MM-dd').format(firstCheckUp!),
                  labelText: 'Date Of Checkup',
                  onChanged: (value) => setState(() => firstCheckUp = value),
                ),
                SizedBox(height: 24 * globals.heightMediaQuery),
                PrimaryDateField(
                  hintText: DateFormat('yyyy-MM-dd').format(secondCheckUp!),
                  labelText: 'Date Of Next Checkup',
                  onChanged: (value) => setState(() => secondCheckUp = value),
                ),
                SizedBox(height: 24 * globals.heightMediaQuery),
                Focus(
                  onFocusChange:
                      (hasFocus) {}, // Dummy onFocusChange callback
                  child: FileUploaderField(uploadedFiles: widget
                      .selectedCheckup!.files!.map((file) => file.path)
                      .toList(),),
                ),
                SizedBox(
                  height: 16 * globals.heightMediaQuery,
                ),
                SizedBox(
                  height: 52 * globals.heightMediaQuery,
                  width: 343 * globals.widthMediaQuery,
                  child: PrimaryButton(
                    onPressed: () {
                      // Update details using copyWith method
                      MedicalCheckupDetails updatedCheckUp =
                          widget.selectedCheckup!.copyWith(
                        checkupName: checkUpNameController.text,
                        firstCheckUp: firstCheckUp,
                        secondCheckUp: secondCheckUp,
                            files: ref.read(uploadedFilesProvider).map((path) =>
                                File(path)).toList()
                      );

                      // Update the vaccineDetailsList for the selected animal
                      final animalIndex =
                          ref.read(ovianimalsProvider).indexWhere(
                                (animal) =>
                                    animal.animalName ==
                                    widget.OviDetails.animalName,
                              );

                      if (animalIndex != -1) {
                        // Replace the existing vaccine with the updated one
                        final List<MedicalCheckupDetails> currentList = ref
                                .read(ovianimalsProvider)[animalIndex]
                                .checkUpDetails[widget.OviDetails.animalName] ??
                            [];

                        final List<MedicalCheckupDetails> updatedList =
                            List<MedicalCheckupDetails>.from(currentList);
                        final int indexToUpdate = updatedList.indexWhere(
                            (checkup) => checkup == widget.selectedCheckup);

                        if (indexToUpdate != -1) {
                          ref.read(ovianimalsProvider.notifier).update((state) {
                            final checkupDetails = state[animalIndex]
                                .checkUpDetails;
                            checkupDetails[state[animalIndex].animalName]![indexToUpdate] = updatedCheckUp;
                            state[animalIndex] = state[animalIndex].copyWith(
                              checkUpDetails: checkupDetails
                            );
                            return state;
                          });
                          // updatedList[indexToUpdate] = updatedCheckUp;
                          // ref
                          //         .read(ovianimalsProvider)[animalIndex]
                          //         .checkUpDetails[
                          //     widget.OviDetails.animalName] = updatedList;
                        }
                      }

                      // Close the EditVaccination page
                      Navigator.pop(context);
                    },
                    text: 'Save',
                  ),
                ),
                SizedBox(
                  height: 8 * globals.heightMediaQuery,
                ),
                SizedBox(
                  height: 52 * globals.heightMediaQuery,
                  width: 343 * globals.widthMediaQuery,
                  child: NavigateButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Delete',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
