import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

class AddSurgeriesRecords extends StatefulWidget {
  final Function(String, DateTime?, DateTime?) onSave;

  const AddSurgeriesRecords({super.key, required this.onSave});

  @override
  State<AddSurgeriesRecords> createState() => _AddSurgeriesRecordsState();
}

class _AddSurgeriesRecordsState extends State<AddSurgeriesRecords> {
  TextEditingController surgeryNameController = TextEditingController();
  DateTime? firstDoseDate;
  DateTime? secondDoseDate;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    surgeryNameController.dispose();
    super.dispose();
  }

  void _saveDataAndNavigateBack() {
    String newSurgeryName = surgeryNameController.text;
    widget.onSave(newSurgeryName, firstDoseDate, secondDoseDate);

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
                    "Add Surgeries Records",
                    style: AppFonts.title3(color: AppColors.grayscale90),
                  ),
                  SizedBox(
                    height: 32 * globals.heightMediaQuery,
                  ),
                  PrimaryTextField(
                    hintText: 'Surgery Name',
                    controller: surgeryNameController,
                    labelText: 'Surgery Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text'.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24 * globals.heightMediaQuery),
                  PrimaryDateField(
                    hintText: 'Date Of Surgery',
                    labelText: 'Date Of Surgery',
                    onChanged: (value) => setState(() => firstDoseDate = value),
                  ),
                  SizedBox(height: 24 * globals.heightMediaQuery),
                  PrimaryDateField(
                    hintText: 'Date Of Next Surgery',
                    labelText: 'Date Of Next Surgery',
                    onChanged: (value) => setState(() => secondDoseDate = value),
                  ),
                  SizedBox(height: 24 * globals.heightMediaQuery),
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
          height: 52 * globals.heightMediaQuery,
          width: 343 * globals.widthMediaQuery,
          child: PrimaryButton(
            onPressed: () {
              if(_formKey.currentState!.validate()) {
                _saveDataAndNavigateBack();
              }
            },
            text: 'Save',
          ),
        ),
      ),
    );
  }
}
