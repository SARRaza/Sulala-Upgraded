// ignore_for_file: non_constant_identifier_names

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
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../../widgets/inputs/text_fields/primary_text_field.dart';

class EditSurgeriesRecords extends ConsumerStatefulWidget {
  final OviVariables OviDetails;
  final List<BreedingEventVariables> breedingEvents;
  final SurgeryDetails? selectedSurgery;

  const EditSurgeriesRecords(
      {super.key,
      required this.breedingEvents,
      this.selectedSurgery,
      required this.OviDetails});
  @override
  ConsumerState<EditSurgeriesRecords> createState() =>
      _EditSurgeriesRecordsState();
}

class _EditSurgeriesRecordsState extends ConsumerState<EditSurgeriesRecords> {
  TextEditingController surgeryNameController = TextEditingController();
  DateTime? firstDoseDate;
  DateTime? secondDoseDate;
  List<SurgeryDetails> surgeryDetails = [];

  @override
  void initState() {
    super.initState();

    if (widget.selectedSurgery != null) {
      // Initialize text controller and date variables with selected vaccine details
      surgeryNameController.text = widget.selectedSurgery!.surgeryName;
      firstDoseDate = widget.selectedSurgery!.firstDoseDate;
      secondDoseDate = widget.selectedSurgery!.secondDoseDate;
    }
  }

  void updateVaccineDetailsList(SurgeryDetails updatedSurgery) {
    int index = surgeryDetails.indexWhere(
        (surgery) => surgery.surgeryName == updatedSurgery.surgeryName);

    // Replace the old vaccine with the updated one
    if (index != -1) {
      surgeryDetails[index] = updatedSurgery;
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
                  "Edit Surgeries Records",
                  style: AppFonts.title3(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: 16 * globals.heightMediaQuery,
                ),
                PrimaryTextField(
                  hintText: 'Surgery Name',
                  controller: surgeryNameController,
                  labelText: 'Surgery Name',
                ),
                SizedBox(height: 24 * globals.heightMediaQuery),
                PrimaryDateField(
                  hintText: DateFormat('yyyy-MM-dd').format(firstDoseDate!),
                  labelText: 'Date Of Surgery',
                  onChanged: (value) => setState(() => firstDoseDate = value),
                ),
                SizedBox(height: 24 * globals.heightMediaQuery),
                PrimaryDateField(
                  hintText: DateFormat('yyyy-MM-dd').format(secondDoseDate!),
                  labelText: 'Date Of Next Surgery',
                  onChanged: (value) => setState(() => secondDoseDate = value),
                ),
                SizedBox(height: 24 * globals.heightMediaQuery),
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Focus(
                    onFocusChange:
                        (hasFocus) {}, // Dummy onFocusChange callback
                    child: const FileUploaderField(),
                  ),
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
                      SurgeryDetails updatedSurgery =
                          widget.selectedSurgery!.copyWith(
                        surgeryName: surgeryNameController.text,
                        firstDoseDate: firstDoseDate,
                        secondDoseDate: secondDoseDate,
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
                        final List<SurgeryDetails> currentList = ref
                                .read(ovianimalsProvider)[animalIndex]
                                .surgeryDetails[widget.OviDetails.animalName] ??
                            [];

                        final List<SurgeryDetails> updatedList =
                            List<SurgeryDetails>.from(currentList);
                        final int indexToUpdate = updatedList.indexWhere(
                            (surgery) => surgery == widget.selectedSurgery);

                        if (indexToUpdate != -1) {
                          updatedList[indexToUpdate] = updatedSurgery;
                          ref
                                  .read(ovianimalsProvider)[animalIndex]
                                  .surgeryDetails[
                              widget.OviDetails.animalName] = updatedList;
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
