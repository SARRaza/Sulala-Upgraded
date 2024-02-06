import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sulala_upgrade/src/widgets/dialogs/confirm_delete_dialog.dart';
import '../../data/classes/breeding_event_variables.dart';
import '../../data/classes/medical_checkup_details.dart';
import '../../data/classes/ovi_variables.dart';
import '../../data/globals.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/navigate_button.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';

class EditMedicalCheckUp extends ConsumerStatefulWidget {
  final OviVariables oviDetails;
  final List<BreedingEventVariables> breedingEvents;
  final MedicalCheckupDetails? selectedCheckup;

  const EditMedicalCheckUp(
      {super.key,
      required this.breedingEvents,
      this.selectedCheckup,
      required this.oviDetails});
  @override
  ConsumerState<EditMedicalCheckUp> createState() => _EditMedicalCheckUpState();
}

class _EditMedicalCheckUpState extends ConsumerState<EditMedicalCheckUp> {
  final _checkUpNameController = TextEditingController();
  DateTime? firstCheckUp;
  DateTime? secondCheckUp;
  List<MedicalCheckupDetails> checkupDetailsList = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.selectedCheckup != null) {
      // Initialize text controller and date variables with selected vaccine details
      _checkUpNameController.text = widget.selectedCheckup!.checkupName;
      firstCheckUp = widget.selectedCheckup!.firstCheckUp;
      secondCheckUp = widget.selectedCheckup!.secondCheckUp;
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
                    "Edit Medical Checkup".tr,
                    style: AppFonts.title3(color: AppColors.grayscale90),
                  ),
                  SizedBox(
                    height: 32 * SizeConfig.heightMultiplier(context),
                  ),
                  PrimaryTextField(
                    hintText: 'Checkup Name'.tr,
                    controller: _checkUpNameController,
                    labelText: 'Checkup Name'.tr,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter some text'.tr
                        : null,
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  PrimaryDateField(
                    hintText: firstCheckUp != null
                        ? DateFormat('yyyy-MM-dd').format(firstCheckUp!)
                        : 'dd/MM/yyyy',
                    labelText: 'Date Of Checkup'.tr,
                    onChanged: (value) => setState(() => firstCheckUp = value),
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  PrimaryDateField(
                    hintText: secondCheckUp != null
                        ? DateFormat('yyyy-MM-dd').format(secondCheckUp!)
                        : 'dd/MM/yyyy',
                    labelText: 'Date Of Next Checkup'.tr,
                    onChanged: (value) => setState(() => secondCheckUp = value),
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  Focus(
                    onFocusChange:
                        (hasFocus) {}, // Dummy onFocusChange callback
                    child: FileUploaderField(
                      uploadedFiles: widget.selectedCheckup!.files!
                          .map((file) => file.path)
                          .toList(),
                    ),
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
                          MedicalCheckupDetails updatedCheckUp =
                              widget.selectedCheckup!.copyWith(
                                  checkupName: _checkUpNameController.text,
                                  firstCheckUp: firstCheckUp,
                                  secondCheckUp: secondCheckUp,
                                  files: ref
                                      .read(uploadedFilesProvider)
                                      .map((path) => File(path))
                                      .toList());

                          // Update the vaccineDetailsList for the selected animal
                          final animalIndex =
                              ref.read(oviAnimalsProvider).indexWhere(
                                    (animal) =>
                                        animal.animalName ==
                                        widget.oviDetails.animalName,
                                  );

                          if (animalIndex != -1) {
                            // Replace the existing vaccine with the updated one
                            final List<MedicalCheckupDetails> currentList = ref
                                        .read(oviAnimalsProvider)[animalIndex]
                                        .checkUpDetails[
                                    widget.oviDetails.animalName] ??
                                [];

                            final List<MedicalCheckupDetails> updatedList =
                                List<MedicalCheckupDetails>.from(currentList);
                            final int indexToUpdate = updatedList.indexWhere(
                                (checkup) => checkup == widget.selectedCheckup);

                            if (indexToUpdate != -1) {
                              ref
                                  .read(oviAnimalsProvider.notifier)
                                  .update((state) {
                                final newState = List<OviVariables>.from(state);
                                final checkupDetails =
                                    state[animalIndex].checkUpDetails;
                                checkupDetails[state[animalIndex].animalName]![
                                    indexToUpdate] = updatedCheckUp;
                                newState[animalIndex] = state[animalIndex]
                                    .copyWith(checkUpDetails: checkupDetails);
                                return newState;
                              });
                            }
                          }

                          // Close the EditVaccination page
                          Navigator.pop(context);
                        }
                        // Update details using copyWith method
                      },
                      text: 'Save'.tr,
                    ),
                  ),
                  SizedBox(
                    height: 8 * SizeConfig.heightMultiplier(context),
                  ),
                  SizedBox(
                    height: 52 * SizeConfig.heightMultiplier(context),
                    width: 343 * SizeConfig.widthMultiplier(context),
                    child: NavigateButton(
                      onPressed: _deleteCheckup,
                      text: 'Delete'.tr,
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

  void _deleteCheckup() {
    showDialog(
            context: context,
            builder: (context) => ConfirmDeleteDialog(
                content: "Are you sure you want to delete the checkup".tr))
        .then((confirm) {
      if (confirm) {
        final animalIndex = ref.read(oviAnimalsProvider).indexWhere(
              (animal) => animal.animalName == widget.oviDetails.animalName,
            );

        ref.read(oviAnimalsProvider.notifier).update((state) {
          final newState = List<OviVariables>.from(state);
          newState[animalIndex]
              .checkUpDetails[widget.oviDetails.animalName]!
              .removeWhere((checkup) =>
                  checkup.checkupName == widget.selectedCheckup!.checkupName);

          return newState;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("The checkup has been deleted".tr)));
        Navigator.pop(context);
      }
    });
  }
}
