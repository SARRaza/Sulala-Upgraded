import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sulala_upgrade/src/data/providers/animal_list_provider.dart';
import 'package:sulala_upgrade/src/screens/reg_mode/image_view_page.dart';
import 'package:sulala_upgrade/src/widgets/styled_dismissible.dart';
import '../../../data/classes/ovi_variables.dart';
import '../../../screens/pdf/pdf_view_page.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../dialogs/confirm_delete_dialog.dart';
import '../../lists/table_list/table_text_button.dart';
import '../../other/three_information_block.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

class GeneralInfoAnimalWidget extends ConsumerStatefulWidget {
  final VoidCallback onDateOfBirthPressed;
  final VoidCallback onDateOfWeaningPressed;
  final VoidCallback onDateOfMatingPressed;
  final VoidCallback onDateOfDeathPressed;
  final VoidCallback onDateOfSalePressed;
  final VoidCallback onDateOfHatchingPressed;
  final String type;
  final String age;
  final String sex;
  final String breed;
  final String fieldName;
  final String fieldContent;
  final OviVariables oviDetails;

  const GeneralInfoAnimalWidget({
    Key? key,
    required this.onDateOfBirthPressed,
    required this.onDateOfWeaningPressed,
    required this.onDateOfMatingPressed,
    required this.onDateOfDeathPressed,
    required this.onDateOfSalePressed,
    required this.onDateOfHatchingPressed,
    required this.type,
    required this.age,
    required this.sex,
    required this.breed,
    required this.fieldName,
    required this.fieldContent,
    required this.oviDetails,
  }) : super(key: key);

  @override
  ConsumerState<GeneralInfoAnimalWidget> createState() =>
      _GeneralInfoAnimalWidgetState();
}

class _GeneralInfoAnimalWidgetState
    extends ConsumerState<GeneralInfoAnimalWidget> {
  bool loading = false;
  double uploadProgress = 0.0;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: SizeConfig.widthMultiplier(context) * 343,
          child: ThreeInformationBlock(
            head1: widget.oviDetails.selectedAnimalType,
            head2: widget.oviDetails.selectedAnimalSpecies,
            head3: widget.oviDetails.selectedOviGender.isNotEmpty
                ? widget.oviDetails.selectedOviGender
                : 'Not Selected'.tr,
          ),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier(context) * 24,
        ),
        Text(
          "General Information".tr,
          style: AppFonts.title5(color: AppColors.grayscale90),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TableTextButton(
                  onPressed: widget.onDateOfBirthPressed,
                  textButton: _calculateAge(widget.oviDetails.dateOfBirth),
                  textHead: "Age".tr,
                ),
                Visibility(
                  visible: widget.oviDetails.dateOfBirth != null,
                  child: TableTextButton(
                    onPressed: widget.onDateOfBirthPressed,
                    textButton: DateFormat('dd/MM/yyyy').format(
                        widget.oviDetails.dateOfBirth ?? DateTime.now()),
                    textHead: "Date of Birth".tr,
                  ),
                ),
                TableTextButton(
                  onPressed: () {},
                  textButton: widget.oviDetails.selectedAnimalBreed,
                  textHead: "Breed".tr,
                ),
                Visibility(
                  visible: widget.oviDetails.selectedOviGender == 'Female' &&
                      widget.oviDetails.selectedAnimalType == 'Mammal',
                  child: TableTextButton(
                    onPressed: widget.onDateOfWeaningPressed,
                    textButton: widget.oviDetails.selectedOviDates
                                .containsKey('Date Of Weaning') &&
                            widget.oviDetails
                                    .selectedOviDates['Date Of Weaning'] !=
                                null
                        ? DateFormat('dd/MM/yyyy').format(
                            widget.oviDetails
                                .selectedOviDates['Date Of Weaning']!,
                          )
                        : 'Add'.tr,
                    textHead: "Date of Weaning".tr,
                  ),
                ),
                Visibility(
                  visible: widget.oviDetails.selectedOviGender == 'Female' &&
                      widget.oviDetails.selectedAnimalType == 'Oviparous',
                  child: TableTextButton(
                    onPressed: widget.onDateOfHatchingPressed,
                    textButton: widget.oviDetails.selectedOviDates
                                .containsKey('Date Of Hatching') &&
                            widget.oviDetails
                                    .selectedOviDates['Date Of Hatching'] !=
                                null
                        ? DateFormat('dd/MM/yyyy').format(
                            widget.oviDetails
                                .selectedOviDates['Date Of Hatching']!,
                          )
                        : 'Add'.tr,
                    textHead: "Date of Hatching".tr,
                  ),
                ),
                TableTextButton(
                  onPressed: widget.onDateOfMatingPressed,
                  textButton: widget.oviDetails.selectedOviDates
                              .containsKey('Date Of Mating') &&
                          widget.oviDetails
                                  .selectedOviDates['Date Of Mating'] !=
                              null
                      ? DateFormat('dd/MM/yyyy').format(
                          widget.oviDetails.selectedOviDates['Date Of Mating']!,
                        )
                      : 'Add'.tr,
                  textHead: "Date of Mating".tr,
                ),
                TableTextButton(
                  onPressed: widget.onDateOfDeathPressed,
                  textButton: widget.oviDetails.selectedOviDates
                              .containsKey('Date Of Death') &&
                          widget.oviDetails.selectedOviDates['Date Of Death'] !=
                              null
                      ? DateFormat('dd/MM/yyyy').format(
                          widget.oviDetails.selectedOviDates['Date Of Death']!,
                        )
                      : 'Add'.tr,
                  textHead: "Date of Death".tr,
                ),
                TableTextButton(
                  onPressed: widget.onDateOfSalePressed,
                  textButton: widget.oviDetails.selectedOviDates
                              .containsKey('Date Of Sale') &&
                          widget.oviDetails.selectedOviDates['Date Of Sale'] !=
                              null
                      ? DateFormat('dd/MM/yyyy').format(
                          widget.oviDetails.selectedOviDates['Date Of Sale']!,
                        )
                      : 'Add'.tr,
                  textHead: "Date of Sale".tr,
                ),
                Visibility(
                  visible: widget.oviDetails.customFields != null,
                  child: Column(
                    children: widget.oviDetails.customFields!.keys
                        .map((fieldName) => TableTextButton(
                            onPressed: () {},
                            textButton:
                                widget.oviDetails.customFields![fieldName]!,
                            textHead: fieldName))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier(context) * 24,
                ),
                if (widget.oviDetails.notes.isNotEmpty)
                  Column(
                    children: [
                      Text(
                        "Additional Notes".tr,
                        style: AppFonts.title5(color: AppColors.grayscale90),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier(context) * 14,
                      ),
                      Text(
                        widget.oviDetails.notes,
                        style: AppFonts.body1(color: AppColors.grayscale90),
                      ),
                    ],
                  ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.oviDetails.files?.length,
                  itemBuilder: (context, index) {
                    final filePath = widget.oviDetails.files![index].path;

                    return StyledDismissible(
                      confirmDismiss: _confirmFileDeletion,
                      onDismissed: (direction) => _deleteFile(filePath),
                      child: GestureDetector(
                        onTap: () => _showFile(filePath),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.file_copy_outlined,
                                color: AppColors.primary30,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  filePath.split('/').last,
                                  style: AppFonts.body1(
                                      color: AppColors.grayscale90),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (loading)
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: uploadProgress,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                      AppColors.primary30,
                                    ),
                                    backgroundColor: AppColors.grayscale10,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 111,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showFile(String filePath) {
    final file = File(filePath);
    if (mounted) {
      if (filePath.endsWith('.pdf')) {
        // Open PDF
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PDFViewPage(file: file)),
        );
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ImageViewPage(imageProvider: FileImage(file))));
      }
    }
  }

  Future<bool?> _confirmFileDeletion(DismissDirection direction) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(
          content: 'Are you sure you want to delete this file?'.tr,
        );
      },
    );
  }

  _deleteFile(String filePath) {
    File(filePath).delete();
    ref.read(animalListProvider.notifier).updateAnimal(widget.oviDetails
        .copyWith(files: widget.oviDetails.files!.where((file) => file.path !=
        filePath).toList()));
  }

  String _calculateAge(DateTime? selectedDate) {
    if (selectedDate == null) {
      return 'Not Selected'.tr; // Handle the case when the date is not selected
    }

    final currentDate = DateTime.now();
    final ageInYears = currentDate.year - selectedDate.year;
    return '1 year'.trPlural('numYears', ageInYears);
  }
}
