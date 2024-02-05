// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sulala_upgrade/src/widgets/dialogs/confirm_delete_dialog.dart';
import '../../data/classes/breeding_event_variables.dart';
import '../../data/classes/ovi_variables.dart';
import '../../data/classes/vaccine_details.dart';
import '../../data/globals.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/navigate_button.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

import '../../widgets/inputs/text_fields/primary_text_field.dart';

class EditVaccination extends ConsumerStatefulWidget {
  final OviVariables OviDetails;
  final List<BreedingEventVariables> breedingEvents;
  final VaccineDetails? selectedVaccine;

  const EditVaccination(
      {super.key,
      required this.breedingEvents,
      this.selectedVaccine,
      required this.OviDetails});

  @override
  ConsumerState<EditVaccination> createState() => _EditVaccinationState();
}

class _EditVaccinationState extends ConsumerState<EditVaccination> {
  TextEditingController vaccineNameController = TextEditingController();
  DateTime? firstDoseDate;
  DateTime? secondDoseDate;
  List<VaccineDetails> vaccineDetailsList = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.selectedVaccine != null) {
      // Initialize text controller and date variables with selected vaccine details
      vaccineNameController.text = widget.selectedVaccine!.vaccineName;
      firstDoseDate = widget.selectedVaccine!.firstDoseDate;
      secondDoseDate = widget.selectedVaccine!.secondDoseDate;
    }
  }

  void _updateVaccineDetailsList(VaccineDetails updatedVaccine) {
    int index = vaccineDetailsList.indexWhere(
        (vaccine) => vaccine.vaccineName == updatedVaccine.vaccineName);

    // Replace the old vaccine with the updated one
    if (index != -1) {
      vaccineDetailsList[index] = updatedVaccine;
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
                padding:
                    EdgeInsets.all(8 * SizeConfig.widthMultiplier(context)),
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
                left: 16 * SizeConfig.widthMultiplier(context),
                right: 16 * SizeConfig.widthMultiplier(context)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Edit Vaccination",
                    style: AppFonts.title3(color: AppColors.grayscale90),
                  ),
                  SizedBox(
                    height: 32 * SizeConfig.heightMultiplier(context),
                  ),
                  PrimaryTextField(
                    hintText: 'Vaccine Name',
                    controller: vaccineNameController,
                    labelText: 'Vaccine Name',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter some text'.tr
                        : null,
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  PrimaryDateField(
                    hintText: firstDoseDate != null
                        ? DateFormat('yyyy-MM-dd').format(firstDoseDate!)
                        : 'yyyy-MM-dd',
                    labelText: 'Date Of Vaccination',
                    onChanged: (value) => setState(() => firstDoseDate = value),
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  PrimaryDateField(
                    hintText: secondDoseDate != null
                        ? DateFormat('yyyy-MM-dd').format(secondDoseDate!)
                        : 'yyyy-MM-dd',
                    labelText: 'Date Of Next Vaccination',
                    onChanged: (value) =>
                        setState(() => secondDoseDate = value),
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  Focus(
                    onFocusChange:
                        (hasFocus) {}, // Dummy onFocusChange callback
                    child: FileUploaderField(
                        uploadedFiles: widget.selectedVaccine!.files != null
                            ? widget.selectedVaccine!.files!
                                .map((file) => file.path)
                                .toList()
                            : []),
                  ),
                  SizedBox(
                    height: 16 * SizeConfig.heightMultiplier(context),
                  ),
                  SizedBox(
                    height: 52 * SizeConfig.heightMultiplier(context),
                    width: 343 * SizeConfig.widthMultiplier(context),
                    child: PrimaryButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Update details using copyWith method
                          VaccineDetails updatedVaccine =
                              widget.selectedVaccine!.copyWith(
                                  vaccineName: vaccineNameController.text,
                                  firstDoseDate: firstDoseDate,
                                  secondDoseDate: secondDoseDate,
                                  files: ref
                                      .read(uploadedFilesProvider)
                                      .map((path) => File(path))
                                      .toList());

                          // Update the vaccineDetailsList for the selected animal
                          final animalIndex =
                              ref.read(ovianimalsProvider).indexWhere(
                                    (animal) =>
                                        animal.animalName ==
                                        widget.OviDetails.animalName,
                                  );

                          if (animalIndex != -1) {
                            // Replace the existing vaccine with the updated one
                            final List<VaccineDetails> currentList = ref
                                        .read(ovianimalsProvider)[animalIndex]
                                        .vaccineDetails[
                                    widget.OviDetails.animalName] ??
                                [];

                            final List<VaccineDetails> updatedList =
                                List<VaccineDetails>.from(currentList);
                            final int indexToUpdate = updatedList.indexWhere(
                                (vaccine) =>
                                    vaccine.vaccineName ==
                                    widget.selectedVaccine!.vaccineName);

                            if (indexToUpdate != -1) {
                              updatedList[indexToUpdate] = updatedVaccine;
                              ref
                                  .read(ovianimalsProvider.notifier)
                                  .update((state) {
                                final newState = List<OviVariables>.from(state);
                                final vaccineDetails =
                                    state[animalIndex].vaccineDetails;
                                vaccineDetails[state[animalIndex].animalName] =
                                    updatedList;
                                newState[animalIndex] = state[animalIndex]
                                    .copyWith(vaccineDetails: vaccineDetails);
                                return state;
                              });
                              // ref
                              //         .read(ovianimalsProvider)[animalIndex]
                              //         .vaccineDetails[
                              //     widget.OviDetails.animalName] = updatedList;
                            }
                          }

                          // Close the EditVaccination page
                          Navigator.pop(context);
                        }
                      },
                      text: 'Save',
                    ),
                  ),
                  SizedBox(
                    height: 8 * SizeConfig.heightMultiplier(context),
                  ),
                  SizedBox(
                    height: 52 * SizeConfig.heightMultiplier(context),
                    width: 343 * SizeConfig.widthMultiplier(context),
                    child: NavigateButton(
                      onPressed: deleteVaccination,
                      text: 'Delete',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void deleteVaccination() {
    showDialog(
            context: context,
            builder: (context) => ConfirmDeleteDialog(
                content: "Are you sure you want to delete the vaccination?".tr))
        .then((confirm) {
      if (confirm) {
        ref.read(ovianimalsProvider.notifier).update((state) {
          final newState = List<OviVariables>.from(state);
          final animalIndex = newState
              .indexWhere((animal) => animal.id == widget.OviDetails.id);
          newState[animalIndex]
              .vaccineDetails[widget.OviDetails.animalName]!
              .removeWhere((vaccination) =>
                  vaccination.vaccineName ==
                  widget.selectedVaccine!.vaccineName);
          return newState;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The vaccination has been deleted'.tr)));
        Navigator.pop(context);
      }
    });
  }
}
