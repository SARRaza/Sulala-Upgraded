import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/classes/medical_checkup_details.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/data/providers/medical_checkup_providers.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';

class AddMedicalCheckUp extends ConsumerStatefulWidget {
  final int animalId;
  const AddMedicalCheckUp({super.key, required this.animalId});

  @override
  ConsumerState<AddMedicalCheckUp> createState() => _AddMedicalCheckUpState();
}

class _AddMedicalCheckUpState extends ConsumerState<AddMedicalCheckUp> {
  final _checkupNameController = TextEditingController();
  DateTime? firstCheckup;
  DateTime? secondCheckup;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _checkupNameController.dispose();
    super.dispose();
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
                    "Add Medical Checkup".tr,
                    style: AppFonts.title3(color: AppColors.grayscale90),
                  ),
                  SizedBox(
                    height: 32 * SizeConfig.heightMultiplier(context),
                  ),
                  PrimaryTextField(
                    hintText: 'Checkup Name'.tr,
                    controller: _checkupNameController,
                    labelText: 'Checkup Name'.tr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text'.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  PrimaryDateField(
                    hintText: 'Date Of Checkup'.tr,
                    labelText: 'Date Of Checkup'.tr,
                    onChanged: (value) => setState(() => firstCheckup = value),
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  PrimaryDateField(
                    hintText: 'Date Of Next Checkup'.tr,
                    labelText: 'Date Of Next Checkup'.tr,
                    onChanged: (value) => setState(() => secondCheckup = value),
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  Focus(
                    onFocusChange:
                        (hasFocus) {}, // Dummy onFocusChange callback
                    child: const FileUploaderField(),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          height: 52 * SizeConfig.heightMultiplier(context),
          width: 343 * SizeConfig.widthMultiplier(context),
          child: PrimaryButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _saveDataAndNavigateBack();
              }
            },
            text: 'Save'.tr,
          ),
        ),
      ),
    );
  }

  void _saveDataAndNavigateBack() {
    ref.read(medicalCheckupListProvider(widget.animalId).notifier).addCheckup(
        MedicalCheckupDetails(
            animalId: widget.animalId,
            checkupName: _checkupNameController.text,
            firstCheckUp: firstCheckup,
            secondCheckUp: secondCheckup,
            files: ref
                .read(uploadedFilesProvider)
                .map((path) => File(path))
                .toList()));
    Navigator.pop(context);
  }
}
