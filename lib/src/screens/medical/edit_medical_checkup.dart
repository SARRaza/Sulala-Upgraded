import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sulala_upgrade/src/data/providers/medical_checkup_providers.dart';
import 'package:sulala_upgrade/src/widgets/dialogs/confirm_delete_dialog.dart';
import '../../data/classes/medical_checkup_details.dart';
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
  final int checkUpId;
  final int animalId;

  const EditMedicalCheckUp({super.key, required this.checkUpId, required this
      .animalId});
  @override
  ConsumerState<EditMedicalCheckUp> createState() => _EditMedicalCheckUpState();
}

class _EditMedicalCheckUpState extends ConsumerState<EditMedicalCheckUp> {
  TextEditingController? _checkUpNameController;
  TextEditingController? _firstCheckUpController;
  TextEditingController? _secondCheckUpController;
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
            child: ref.watch(medicalCheckupListProvider(widget.animalId)).when(
                error: (error, trace) => Text('Error: $error'),
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                data: (checkups) {
                  final selectedCheckup = checkups.firstWhereOrNull(
                      (checkup) => checkup.id == widget.checkUpId);
                  if (selectedCheckup == null) {
                    return Text('Checkup not found'.tr);
                  }
                  _checkUpNameController ??=
                      TextEditingController(text: selectedCheckup.checkupName);
                  _firstCheckUpController ??= TextEditingController(
                      text: selectedCheckup.firstCheckUp != null
                          ? DateFormat('dd/MM/yyyy')
                              .format(selectedCheckup.firstCheckUp!)
                          : '');
                  _secondCheckUpController ??= TextEditingController(
                      text: selectedCheckup.secondCheckUp != null
                          ? DateFormat('dd/MM/yyyy')
                              .format(selectedCheckup.secondCheckUp!)
                          : '');

                  return Form(
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
                          controller: _checkUpNameController!,
                          labelText: 'Checkup Name'.tr,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter some text'.tr
                              : null,
                        ),
                        SizedBox(
                            height: 24 * SizeConfig.heightMultiplier(context)),
                        PrimaryDateField(
                          controller: _firstCheckUpController!,
                          hintText: 'dd/MM/yyyy',
                          labelText: 'Date Of Checkup'.tr,
                        ),
                        SizedBox(
                            height: 24 * SizeConfig.heightMultiplier(context)),
                        PrimaryDateField(
                          controller: _secondCheckUpController!,
                          hintText: 'dd/MM/yyyy',
                          labelText: 'Date Of Next Checkup'.tr,
                        ),
                        SizedBox(
                            height: 24 * SizeConfig.heightMultiplier(context)),
                        Focus(
                          onFocusChange:
                              (hasFocus) {}, // Dummy onFocusChange callback
                          child: FileUploaderField(
                            uploadedFiles: selectedCheckup.files!
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
                                    selectedCheckup.copyWith(
                                        checkupName:
                                            _checkUpNameController!.text,
                                        firstCheckUp: DateFormat('dd/MM/yyyy').parse(_firstCheckUpController!.text),
                                        secondCheckUp: DateFormat('dd/MM/yyyy').parse(_secondCheckUpController!.text),
                                        files: ref
                                            .read(uploadedFilesProvider)
                                            .map((path) => File(path))
                                            .toList());
                                ref.read(medicalCheckupListProvider(widget
                                    .animalId).notifier).updateCheckup(
                                    updatedCheckUp);
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
                  );
                }),
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
        ref.read(medicalCheckupListProvider(widget.animalId).notifier).removeCheckup(
            widget.checkUpId);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("The checkup has been deleted".tr)));
        Navigator.pop(context);
      }
    });
  }
}
