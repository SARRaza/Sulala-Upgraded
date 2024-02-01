import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

class AddVaccination extends StatefulWidget {
  final Function(String, DateTime?, DateTime?) onSave;

  const AddVaccination({super.key, required this.onSave});

  @override
  State<AddVaccination> createState() => _AddVaccinationState();
}

class _AddVaccinationState extends State<AddVaccination> {
  TextEditingController vaccineNameController = TextEditingController();
  DateTime? firstDoseDate;
  DateTime? secondDoseDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    vaccineNameController.dispose();
    super.dispose();
  }

  void _saveDataAndNavigateBack() {
    String newVaccineName = vaccineNameController.text;
    widget.onSave(newVaccineName, firstDoseDate, secondDoseDate);

    // Close the modal sheet and return to MyPage
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
                right: 16 * globals.widthMediaQuery,
                bottom: 52 * globals.heightMediaQuery + 10
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Add Vaccination",
                    style: AppFonts.title3(color: AppColors.grayscale90),
                  ),
                  SizedBox(
                    height: 32 * globals.heightMediaQuery,
                  ),
                  PrimaryTextField(
                    hintText: 'Vaccine Name',
                    controller: vaccineNameController,
                    labelText: 'Vaccine Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24 * globals.heightMediaQuery),
                  PrimaryDateField(
                    hintText: 'Date Of Vaccination',
                    labelText: 'Date Of Vaccination',
                    onChanged: (value) => setState(() => firstDoseDate = value),
                  ),
                  SizedBox(height: 24 * globals.heightMediaQuery),
                  PrimaryDateField(
                    hintText: 'Date Of Next Vaccination',
                    labelText: 'Date Of Next Vaccination',
                    onChanged: (value) => setState(() => secondDoseDate = value),
                  ),
                  SizedBox(height: 24 * globals.heightMediaQuery),
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
          height: 52 * globals.heightMediaQuery,
          width: 343 * globals.widthMediaQuery,
          child: PrimaryButton(
            onPressed: () {
              if(_formKey.currentState!.validate()) {
                _saveDataAndNavigateBack();
              }
              // Navigator.pop(context);
            },
            text: 'Save',
          ),
        ),
      ),
    );
  }
}
