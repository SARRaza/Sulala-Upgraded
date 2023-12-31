import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import '../../../data/classes.dart';
import '../../../data/riverpod_globals.dart';
import '../../../screens/pdf/pdf_view_page.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../lists/table_lsit/table_textbutton.dart';
import '../../other/three_information_block.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

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
    final selectedDate = parseSelectedDate(widget.OviDetails.dateOfBirth);
    final List<String> uploadedFiles = ref.read(uploadedFilesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: globals.widthMediaQuery * 343,
          child: ThreeInformationBlock(
            head1: widget.OviDetails.selectedAnimalType,
            head2: widget.OviDetails.selectedAnimalSpecies,
            head3: widget.OviDetails.selectedOviGender.isNotEmpty
                ? widget.OviDetails.selectedOviGender
                : 'Not Selected',
          ),
        ),
        SizedBox(
          height: globals.heightMediaQuery * 24,
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
                  visible: widget.OviDetails.dateOfBirth.isNotEmpty,
                  child: TableTextButton(
                    onPressed: widget.onDateOfBirthPressed,
                    textButton: widget.OviDetails.dateOfBirth,
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
                  visible: widget.OviDetails.fieldName.isNotEmpty,
                  child: TableTextButton(
                      onPressed: () {},
                      textButton: widget.OviDetails.fieldContent,
                      textHead: widget.OviDetails.fieldName),
                ),
                SizedBox(
                  height: globals.heightMediaQuery * 24,
                ),
                if(widget.OviDetails.notes.isNotEmpty)
                  Column(
                    children: [
                      Text(
                        "Additional Notes",
                        style: AppFonts.title5(color: AppColors.grayscale90),
                      ),
                      SizedBox(
                        height: globals.heightMediaQuery * 14,
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
                    final fileName = uploadedFiles[index];

                    return GestureDetector(
                      onTap: () => showFile(fileName),
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
                                fileName,
                                style:
                                    AppFonts.body1(color: AppColors.grayscale90),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (_loading)
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: _uploadProgress,
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    AppColors.primary30,
                                  ),
                                  backgroundColor: AppColors.grayscale10,
                                ),
                              ),
                          ],
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

  Future<void> showFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    if(mounted) {
      if (fileName.endsWith('.pdf')) {
        // Open PDF
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PDFViewPage(file: file)),
        );
      } else {
        // Open Image in a new screen or dialog
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Image.file(file),
          ),
        );
      }
    }
  }
}
