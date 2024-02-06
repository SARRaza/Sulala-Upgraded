import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sulala_upgrade/src/screens/reg_mode/image_view_page.dart';
import 'package:sulala_upgrade/src/widgets/styled_dismissible.dart';
import '../../../data/classes/ovi_variables.dart';
import '../../../data/riverpod_globals.dart';
import '../../../screens/pdf/pdf_view_page.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../dialogs/confirm_delete_dialog.dart';
import '../../lists/table_list/table_textbutton.dart';
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
  // ignore: non_constant_identifier_names
  final OviVariables OviDetails;

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
    // ignore: non_constant_identifier_names
    required this.OviDetails,
  }) : super(key: key);

  @override
  ConsumerState<GeneralInfoAnimalWidget> createState() =>
      _GeneralInfoAnimalWidgetState();
}

String calculateAge(DateTime? selectedDate) {
  if (selectedDate == null) {
    return 'Not Selected'; // Handle the case when the date is not selected
  }

  final currentDate = DateTime.now();
  final ageInYears = currentDate.year - selectedDate.year;
  return '$ageInYears Years';
}

DateTime? parseSelectedDate(String? selectedDate) {
  if (selectedDate == null) {
    return null; // Return null if the date is not selected
  }

  try {
    return DateFormat('dd/MM/yyyy').parse(selectedDate);
  } catch (e) {
    return null; // Return null if there is an error parsing the date
  }
}

const bool _loading = false;
double _uploadProgress = 0.0;

class _GeneralInfoAnimalWidgetState
    extends ConsumerState<GeneralInfoAnimalWidget> {
  @override
  Widget build(BuildContext context) {
    final selectedDate = widget.OviDetails.dateOfBirth;

    final animalDetails = ref
        .watch(oviAnimalsProvider)
        .firstWhere((animal) => animal.id == widget.OviDetails.id);
    final List<String> uploadedFiles =
        animalDetails.files?.map((file) => file.path).toList() ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: SizeConfig.widthMultiplier(context) * 343,
          child: ThreeInformationBlock(
            head1: widget.OviDetails.selectedAnimalType,
            head2: widget.OviDetails.selectedAnimalSpecies,
            head3: widget.OviDetails.selectedOviGender.isNotEmpty
                ? widget.OviDetails.selectedOviGender
                : 'Not Selected',
          ),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier(context) * 24,
        ),
        Text(
          "General Information",
          style: AppFonts.title5(color: AppColors.grayscale90),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TableTextButton(
                  onPressed: widget.onDateOfBirthPressed,
                  textButton: calculateAge(selectedDate),
                  textHead: "Age",
                ),
                Visibility(
                  visible: widget.OviDetails.dateOfBirth != null,
                  child: TableTextButton(
                    onPressed: widget.onDateOfBirthPressed,
                    textButton: DateFormat('dd/MM/yyyy').format(
                        widget.OviDetails.dateOfBirth ?? DateTime.now()),
                    textHead: "Date of Birth",
                  ),
                ),
                TableTextButton(
                  onPressed: () {},
                  textButton: widget.OviDetails.selectedAnimalBreed,
                  textHead: "Breed",
                ),
                Visibility(
                  visible: widget.OviDetails.selectedOviGender == 'Female' &&
                      widget.OviDetails.selectedAnimalType == 'Mammal',
                  child: TableTextButton(
                    onPressed: widget.onDateOfWeaningPressed,
                    textButton: widget.OviDetails.selectedOviDates
                                .containsKey('Date Of Weaning') &&
                            widget.OviDetails
                                    .selectedOviDates['Date Of Weaning'] !=
                                null
                        ? DateFormat('dd/MM/yyyy').format(
                            widget.OviDetails
                                .selectedOviDates['Date Of Weaning']!,
                          )
                        : 'Add',
                    textHead: "Date of Weaning",
                  ),
                ),
                Visibility(
                  visible: widget.OviDetails.selectedOviGender == 'Female' &&
                      widget.OviDetails.selectedAnimalType == 'Oviparous',
                  child: TableTextButton(
                    onPressed: widget.onDateOfHatchingPressed,
                    textButton: widget.OviDetails.selectedOviDates
                                .containsKey('Date Of Hatching') &&
                            widget.OviDetails
                                    .selectedOviDates['Date Of Hatching'] !=
                                null
                        ? DateFormat('dd/MM/yyyy').format(
                            widget.OviDetails
                                .selectedOviDates['Date Of Hatching']!,
                          )
                        : 'Add',
                    textHead: "Date of Hatching",
                  ),
                ),
                TableTextButton(
                  onPressed: widget.onDateOfMatingPressed,
                  textButton: widget.OviDetails.selectedOviDates
                              .containsKey('Date Of Mating') &&
                          widget.OviDetails
                                  .selectedOviDates['Date Of Mating'] !=
                              null
                      ? DateFormat('dd/MM/yyyy').format(
                          widget.OviDetails.selectedOviDates['Date Of Mating']!,
                        )
                      : 'Add',
                  textHead: "Date of Mating",
                ),
                TableTextButton(
                  onPressed: widget.onDateOfDeathPressed,
                  textButton: widget.OviDetails.selectedOviDates
                              .containsKey('Date Of Death') &&
                          widget.OviDetails.selectedOviDates['Date Of Death'] !=
                              null
                      ? DateFormat('dd/MM/yyyy').format(
                          widget.OviDetails.selectedOviDates['Date Of Death']!,
                        )
                      : 'Add',
                  textHead: "Date of Death",
                ),
                TableTextButton(
                  onPressed: widget.onDateOfSalePressed,
                  textButton: widget.OviDetails.selectedOviDates
                              .containsKey('Date Of Sale') &&
                          widget.OviDetails.selectedOviDates['Date Of Sale'] !=
                              null
                      ? DateFormat('dd/MM/yyyy').format(
                          widget.OviDetails.selectedOviDates['Date Of Sale']!,
                        )
                      : 'Add',
                  textHead: "Date of Sale",
                ),
                Visibility(
                  visible: widget.OviDetails.customFields != null,
                  child: Column(
                    children: widget.OviDetails.customFields!.keys
                        .map((fieldName) => TableTextButton(
                            onPressed: () {},
                            textButton:
                                widget.OviDetails.customFields![fieldName]!,
                            textHead: fieldName))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier(context) * 24,
                ),
                if (widget.OviDetails.notes.isNotEmpty)
                  Column(
                    children: [
                      Text(
                        "Additional Notes",
                        style: AppFonts.title5(color: AppColors.grayscale90),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier(context) * 14,
                      ),
                      Text(
                        widget.OviDetails.notes,
                        style: AppFonts.body1(color: AppColors.grayscale90),
                      ),
                    ],
                  ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: uploadedFiles.length,
                  itemBuilder: (context, index) {
                    final filePath = uploadedFiles[index];

                    return StyledDismissible(
                      confirmDismiss: _confirmFileDeletion,
                      onDismissed: (direction) => _deleteFile(filePath),
                      child: GestureDetector(
                        onTap: () => showFile(filePath),
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
                              if (_loading)
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: _uploadProgress,
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

  void showFile(String filePath) {
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
    ref.read(oviAnimalsProvider.notifier).update((state) {
      final animalIndex =
          state.indexWhere((animal) => animal.id == widget.OviDetails.id);
      state[animalIndex] = state[animalIndex].copyWith(
          files: state[animalIndex]
              .files!
              .where((file) => file.path != filePath)
              .toList());

      return state;
    });
  }
}
