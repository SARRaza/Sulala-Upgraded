import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';

class AddVaccination extends StatefulWidget {
  final Function(String, DateTime?, DateTime?) onSave;

  const AddVaccination({super.key, required this.onSave});

  @override
  State<AddVaccination> createState() => _AddVaccinationState();
}

class _AddVaccinationState extends State<AddVaccination> {
  final _vaccineNameController = TextEditingController();
  DateTime? firstDoseDate;
  DateTime? secondDoseDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _vaccineNameController.dispose();
    super.dispose();
  }

  void _saveDataAndNavigateBack() {
    String newVaccineName = _vaccineNameController.text;
    widget.onSave(newVaccineName, firstDoseDate, secondDoseDate);

    Navigator.pop(context);
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
                    "Add Vaccination".tr,
                    style: AppFonts.title3(color: AppColors.grayscale90),
                  ),
                  SizedBox(
                    height: 32 * SizeConfig.heightMultiplier(context),
                  ),
                  PrimaryTextField(
                    hintText: 'Vaccine Name'.tr,
                    controller: _vaccineNameController,
                    labelText: 'Vaccine Name'.tr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text'.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  PrimaryDateField(
                    hintText: 'Date Of Vaccination'.tr,
                    labelText: 'Date Of Vaccination'.tr,
                    onChanged: (value) => setState(() => firstDoseDate = value),
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  PrimaryDateField(
                    hintText: 'Date Of Next Vaccination'.tr,
                    labelText: 'Date Of Next Vaccination'.tr,
                    onChanged: (value) =>
                        setState(() => secondDoseDate = value),
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  SizedBox(
                    //height: 220,
                    width: double.infinity,
                    child: Focus(
                      onFocusChange:
                          (hasFocus) {}, // Dummy onFocusChange callback
                      child: const FileUploaderField(),
                    ),
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
              // Navigator.pop(context);
            },
            text: 'Save'.tr,
          ),
        ),
      ),
    );
  }
}
