import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/buttons/secondary_button.dart';
import '../../widgets/controls_and_buttons/tags/tags.dart';
import 'reg_home_page.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;

class ShowFilterReg extends StatefulWidget {
  final List<Tag> currentStateTags;
  final List<Tag> medicalStateTags;
  final List<Tag> otherStateTags;
  final Function(String, TagStatus) updatedCurrentTagStatus;
  final Function(String, TagStatus) updatedMedicalTagStatus;
  final Function(String, TagStatus) updatedOtherTagStatus;

  const ShowFilterReg(
      {super.key,
      required this.currentStateTags,
      required this.medicalStateTags,
      required this.otherStateTags,
      required this.updatedCurrentTagStatus,
      required this.updatedMedicalTagStatus,
      required this.updatedOtherTagStatus});

  @override
  State<ShowFilterReg> createState() => _ShowFilterRegState();
}

class _ShowFilterRegState extends State<ShowFilterReg> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: globals.heightMediaQuery * 20,
        ),
        Text(
          'Current State',
          style: AppFonts.headline3(color: AppColors.grayscale90),
        ),
        SizedBox(
          height: globals.heightMediaQuery * 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(
            (widget.currentStateTags.length / 3)
                .ceil(), // Calculate how many rows are needed
            (index) {
              final start = index * 3;
              final end = (start + 3).clamp(
                  0,
                  widget.currentStateTags
                      .length); // Ensure end is within the list length
              final rowTags = widget.currentStateTags.sublist(start, end);
              return Row(
                children: rowTags.map((tag) {
                  return Row(
                    children: [
                      Tags(
                        status: tag.status,
                        text: tag.name,
                        onPress: () {
                          setState(() {
                            tag.status = tag.status == TagStatus.active
                                ? TagStatus.notActive
                                : TagStatus.active;
                            widget.updatedCurrentTagStatus(
                                tag.name, tag.status);
                          });
                        },
                      ),
                      SizedBox(
                        width: globals.widthMediaQuery * 10,
                      ),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ),
        SizedBox(
          height: globals.heightMediaQuery * 20,
        ),
        Text(
          'Medical State',
          style: AppFonts.headline3(color: AppColors.grayscale90),
        ),
        SizedBox(
          height: globals.heightMediaQuery * 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(
            (widget.medicalStateTags.length / 3)
                .ceil(), // Calculate how many rows are needed
            (index) {
              final start = index * 3;
              final end = (start + 3).clamp(
                  0,
                  widget.medicalStateTags
                      .length); // Ensure end is within the list length
              final rowTags = widget.medicalStateTags.sublist(start, end);
              return Row(
                children: rowTags.map((tag) {
                  return Row(
                    children: [
                      Tags(
                        status: tag.status,
                        text: tag.name,
                        onPress: () {
                          setState(() {
                            tag.status = tag.status == TagStatus.active
                                ? TagStatus.notActive
                                : TagStatus.active;
                            widget.updatedCurrentTagStatus(
                                tag.name, tag.status);
                          });
                        },
                      ),
                      SizedBox(
                        width: globals.widthMediaQuery * 10,
                      ),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ),
        SizedBox(
          height: globals.heightMediaQuery * 20,
        ),
        Text(
          'Other',
          style: AppFonts.headline3(color: AppColors.grayscale90),
        ),
        SizedBox(
          height: globals.heightMediaQuery * 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(
            (widget.otherStateTags.length / 3)
                .ceil(), // Calculate how many rows are needed
            (index) {
              final start = index * 3;
              final end = (start + 3).clamp(
                  0,
                  widget.otherStateTags
                      .length); // Ensure end is within the list length
              final rowTags = widget.otherStateTags.sublist(start, end);
              return Row(
                children: rowTags.map((tag) {
                  return Row(
                    children: [
                      Tags(
                        status: tag.status,
                        text: tag.name,
                        onPress: () {
                          setState(() {
                            tag.status = tag.status == TagStatus.active
                                ? TagStatus.notActive
                                : TagStatus.active;
                            widget.updatedCurrentTagStatus(
                                tag.name, tag.status);
                          });
                        },
                      ),
                      SizedBox(
                        width: globals.widthMediaQuery * 10,
                      ),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ),
        SizedBox(
          height: globals.heightMediaQuery * 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: globals.heightMediaQuery * 52,
              width: globals.widthMediaQuery * 165,
              child: SecondaryButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Clear All',
                status: SecondaryButtonStatus.idle,
              ),
            ),
            SizedBox(
              height: globals.heightMediaQuery * 52,
              width: globals.widthMediaQuery * 165,
              child: PrimaryButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Apply',
                status: PrimaryButtonStatus.idle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
