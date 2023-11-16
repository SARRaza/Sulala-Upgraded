import 'package:flutter/material.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../lists/table_lsit/table_textbutton.dart';
import '../../other/three_information_block.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;

class GeneralInfoAnimalWidget extends StatefulWidget {
  final VoidCallback onDateOfBirthPressed;
  final VoidCallback onDateOfWeaningPressed;
  final VoidCallback onDateOfMatingPressed;
  final VoidCallback onDateOfDeathPressed;
  final VoidCallback onDateOfSalePressed;
  final String type;
  final String age;
  final String sex;

  const GeneralInfoAnimalWidget({
    Key? key,
    required this.onDateOfBirthPressed,
    required this.onDateOfWeaningPressed,
    required this.onDateOfMatingPressed,
    required this.onDateOfDeathPressed,
    required this.onDateOfSalePressed,
    required this.type,
    required this.age,
    required this.sex,
  }) : super(key: key);

  @override
  State<GeneralInfoAnimalWidget> createState() =>
      _GeneralInfoAnimalWidgetState();
}

class _GeneralInfoAnimalWidgetState extends State<GeneralInfoAnimalWidget> {
  // List<String> _uploadedFiles = [
  //   'File 1',

  //   // Add more items as needed
  // ];

  // List<Icon> get fileIcons {
  //   // Generate icons based on _uploadedFiles
  //   return List.generate(
  //     _uploadedFiles.length,
  //     (index) => Icon(Icons.insert_drive_file),
  //   );
  // }

  // List<Widget> get fileWidgets {
  //   // Generate widgets based on _uploadedFiles
  //   return List.generate(
  //     _uploadedFiles.length,
  //     (index) => ListTile(
  //       leading: fileIcons[index],
  //       title: Text(_uploadedFiles[index]),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: globals.widthMediaQuery * 343,
          child: ThreeInformationBlock(
            head1: widget.type,
            head2: widget.age,
            head3: widget.sex,
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
                  textButton: "Add",
                  textHead: "Date of Birth",
                ),
                TableTextButton(
                  onPressed: widget.onDateOfWeaningPressed,
                  textButton: "Add",
                  textHead: "Date of weaning",
                ),
                TableTextButton(
                  onPressed: widget.onDateOfMatingPressed,
                  textButton: "Add",
                  textHead: "Date of mating",
                ),
                TableTextButton(
                  onPressed: widget.onDateOfDeathPressed,
                  textButton: "Add",
                  textHead: "Date of death",
                ),
                TableTextButton(
                  onPressed: widget.onDateOfSalePressed,
                  textButton: "Add",
                  textHead: "Date of sale",
                ),
                SizedBox(
                  height: globals.heightMediaQuery * 24,
                ),
                Text(
                  "Additional Notes",
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: globals.heightMediaQuery * 14,
                ),
                Text(
                  "This is my favourite sheep. I love it very much",
                  style: AppFonts.body1(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: globals.heightMediaQuery * 14,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.file_copy_outlined,
                      color: AppColors.primary30,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "fileName1",
                        style: AppFonts.body1(color: AppColors.grayscale90),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
