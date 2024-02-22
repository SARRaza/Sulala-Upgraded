import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/providers/vaccination_list_provider.dart';
import 'package:sulala_upgrade/src/widgets/dialogs/confirm_delete_dialog.dart';
import '../../data/classes/vaccine_details.dart';
import '../../data/globals.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/navigate_button.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';

import '../../widgets/inputs/text_fields/primary_text_field.dart';

class EditVaccination extends ConsumerStatefulWidget {
  final int vaccinationId;
  final int animalId;

  const EditVaccination(
      {super.key, required this.vaccinationId, required this.animalId});

  @override
  ConsumerState<EditVaccination> createState() => _EditVaccinationState();
}

class _EditVaccinationState extends ConsumerState<EditVaccination> {
  TextEditingController? _vaccineNameController;
  DateTime? firstDoseDate;
  DateTime? secondDoseDate;
  List<VaccineDetails> vaccineDetailsList = [];
  final _formKey = GlobalKey<FormState>();

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
            child: ref.watch(vaccinationListProvider(widget.animalId)).when(
                error: (error, trace) => Text('Error $error'),
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                data: (vaccinations) {
                  final selectedVaccination = vaccinations.firstWhereOrNull(
                      (vaccination) => vaccination.id == widget.vaccinationId);
                  if (selectedVaccination == null) {
                    return Text('Vaccination not found'.tr);
                  }
                  _vaccineNameController ??= TextEditingController(
                      text: selectedVaccination.vaccineName);
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Edit Vaccination".tr,
                          style: AppFonts.title3(color: AppColors.grayscale90),
                        ),
                        SizedBox(
                          height: 32 * SizeConfig.heightMultiplier(context),
                        ),
                        PrimaryTextField(
                          hintText: 'Vaccine Name'.tr,
                          controller: _vaccineNameController!,
                          labelText: 'Vaccine Name'.tr,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter some text'.tr
                              : null,
                        ),
                        SizedBox(
                            height: 24 * SizeConfig.heightMultiplier(context)),
                        PrimaryDateField(
                          initialValue: selectedVaccination.firstDoseDate,
                          hintText: 'yyyy-MM-dd',
                          labelText: 'Date Of Vaccination'.tr,
                          onChanged: (value) =>
                              setState(() => firstDoseDate = value),
                        ),
                        SizedBox(
                            height: 24 * SizeConfig.heightMultiplier(context)),
                        PrimaryDateField(
                          initialValue: selectedVaccination.secondDoseDate,
                          hintText: 'yyyy-MM-dd',
                          labelText: 'Date Of Next Vaccination'.tr,
                          onChanged: (value) =>
                              setState(() => secondDoseDate = value),
                        ),
                        SizedBox(
                            height: 24 * SizeConfig.heightMultiplier(context)),
                        Focus(
                          onFocusChange:
                              (hasFocus) {}, // Dummy onFocusChange callback
                          child: FileUploaderField(
                              uploadedFiles: selectedVaccination.files != null
                                  ? selectedVaccination.files!
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
                                    selectedVaccination.copyWith(
                                        vaccineName:
                                            _vaccineNameController!.text,
                                        firstDoseDate: firstDoseDate,
                                        secondDoseDate: secondDoseDate,
                                        files: ref
                                            .read(uploadedFilesProvider)
                                            .map((path) => File(path))
                                            .toList());
                                ref
                                    .read(
                                        vaccinationListProvider(widget.animalId)
                                            .notifier)
                                    .updateVaccination(updatedVaccine);

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
                            onPressed: _deleteVaccination,
                            text: 'Delete'.tr,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  void _deleteVaccination() {
    showDialog(
            context: context,
            builder: (context) => ConfirmDeleteDialog(
                content: "Are you sure you want to delete the vaccination?".tr))
        .then((confirm) {
      if (confirm) {
        ref
            .read(vaccinationListProvider(widget.animalId).notifier)
            .removeVaccination(widget.vaccinationId);

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The vaccination has been deleted'.tr)));
        Navigator.pop(context);
      }
    });
  }
}
