import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sulala_upgrade/src/widgets/dialogs/confirm_delete_dialog.dart';
import '../../data/classes/breeding_event_variables.dart';
import '../../data/classes/ovi_variables.dart';
import '../../data/classes/surgery_details.dart';
import '../../data/globals.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/navigate_button.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';

class EditSurgeriesRecords extends ConsumerStatefulWidget {
  final OviVariables oviDetails;
  final List<BreedingEventVariables> breedingEvents;
  final SurgeryDetails? selectedSurgery;

  const EditSurgeriesRecords(
      {super.key,
      required this.breedingEvents,
      this.selectedSurgery,
      required this.oviDetails});
  @override
  ConsumerState<EditSurgeriesRecords> createState() =>
      _EditSurgeriesRecordsState();
}

class _EditSurgeriesRecordsState extends ConsumerState<EditSurgeriesRecords> {
  final _surgeryNameController = TextEditingController();
  DateTime? firstSurgery;
  DateTime? secondSurgery;
  List<SurgeryDetails> surgeryDetails = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.selectedSurgery != null) {
      // Initialize text controller and date variables with selected vaccine details
      _surgeryNameController.text = widget.selectedSurgery!.surgeryName;
      firstSurgery = widget.selectedSurgery!.firstSurgery;
      secondSurgery = widget.selectedSurgery!.secondSurgery;
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
                right: 16 * SizeConfig.widthMultiplier(context),
                bottom: 52 * SizeConfig.heightMultiplier(context) + 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Edit Surgeries Records".tr,
                    style: AppFonts.title3(color: AppColors.grayscale90),
                  ),
                  SizedBox(
                    height: 16 * SizeConfig.heightMultiplier(context),
                  ),
                  PrimaryTextField(
                    hintText: 'Surgery Name'.tr,
                    controller: _surgeryNameController,
                    labelText: 'Surgery Name'.tr,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter some text'.tr
                        : null,
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  PrimaryDateField(
                    hintText: firstSurgery != null
                        ? DateFormat('yyyy-MM-dd').format(firstSurgery!)
                        : 'dd/MM/yyyy',
                    labelText: 'Date Of Surgery'.tr,
                    onChanged: (value) => setState(() => firstSurgery = value),
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  PrimaryDateField(
                    hintText: secondSurgery != null
                        ? DateFormat('yyyy-MM-dd').format(secondSurgery!)
                        : 'dd/MM/yyyy',
                    labelText: 'Date Of Next Surgery'.tr,
                    onChanged: (value) => setState(() => secondSurgery = value),
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  Focus(
                    onFocusChange:
                        (hasFocus) {}, // Dummy onFocusChange callback
                    child: const FileUploaderField(),
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
                          SurgeryDetails updatedSurgery =
                              widget.selectedSurgery!.copyWith(
                                  surgeryName: _surgeryNameController.text,
                                  firstSurgery: firstSurgery,
                                  secondSurgery: secondSurgery,
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
                            final List<SurgeryDetails> currentList = ref
                                        .read(oviAnimalsProvider)[animalIndex]
                                        .surgeryDetails[
                                    widget.oviDetails.animalName] ??
                                [];

                            final List<SurgeryDetails> updatedList =
                                List<SurgeryDetails>.from(currentList);
                            final int indexToUpdate = updatedList.indexWhere(
                                (surgery) => surgery == widget.selectedSurgery);

                            if (indexToUpdate != -1) {
                              updatedList[indexToUpdate] = updatedSurgery;
                              ref
                                      .read(oviAnimalsProvider)[animalIndex]
                                      .surgeryDetails[
                                  widget.oviDetails.animalName] = updatedList;
                            }
                          }

                          // Close the EditVaccination page
                          Navigator.pop(context);
                        }
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
                      onPressed: _deleteSurgery,
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

  void _deleteSurgery() {
    showDialog(
            context: context,
            builder: (context) => ConfirmDeleteDialog(
                content: "Are you sure you want to delete the surgery?".tr))
        .then((confirm) {
      if (confirm) {
        ref.read(oviAnimalsProvider.notifier).update((state) {
          final newState = List<OviVariables>.from(state);
          final animalIndex = newState
              .indexWhere((animal) => animal.id == widget.oviDetails.id);
          newState[animalIndex]
              .surgeryDetails[widget.oviDetails.animalName]!
              .removeWhere((surgery) =>
                  surgery.surgeryName == widget.selectedSurgery!.surgeryName);
          return newState;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The surgery has been deleted'.tr)));
        Navigator.pop(context);
      }
    });
  }
}
