import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/classes/surgery_details.dart';
import 'package:sulala_upgrade/src/data/providers/surgery_list_provider.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/file_uploader_fields/file_uploader_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';

class AddSurgeriesRecords extends ConsumerStatefulWidget {
  final String animalId;

  const AddSurgeriesRecords({super.key, required this.animalId});

  @override
  ConsumerState<AddSurgeriesRecords> createState() =>
      _AddSurgeriesRecordsState();
}

class _AddSurgeriesRecordsState extends ConsumerState<AddSurgeriesRecords> {
  final _surgeryNameController = TextEditingController();
  DateTime? firstDoseDate;
  DateTime? secondDoseDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _surgeryNameController.dispose();
    super.dispose();
  }

  void _saveDataAndNavigateBack() {
    ref.read(surgeryListProvider(widget.animalId).notifier).addSurgery(
        SurgeryDetails(
            surgeryName: _surgeryNameController.text,
            firstSurgery: firstDoseDate,
            secondSurgery: secondDoseDate,
            animalId: widget.animalId));
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
                    "Add Surgeries Records".tr,
                    style: AppFonts.title3(color: AppColors.grayscale90),
                  ),
                  SizedBox(
                    height: 32 * SizeConfig.heightMultiplier(context),
                  ),
                  PrimaryTextField(
                    hintText: 'Surgery Name'.tr,
                    controller: _surgeryNameController,
                    labelText: 'Surgery Name'.tr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text'.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  PrimaryDateField(
                    hintText: 'Date Of Surgery'.tr,
                    labelText: 'Date Of Surgery'.tr,
                    onChanged: (value) => setState(() => firstDoseDate = value),
                  ),
                  SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                  PrimaryDateField(
                    hintText: 'Date Of Next Surgery'.tr,
                    labelText: 'Date Of Next Surgery'.tr,
                    onChanged: (value) =>
                        setState(() => secondDoseDate = value),
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
}
