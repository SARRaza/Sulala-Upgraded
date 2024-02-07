import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/buttons/secondary_button.dart';
import '../../widgets/controls_and_buttons/tags/tags.dart';
import 'reg_home_page.dart';

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
          height: SizeConfig.heightMultiplier(context) * 20,
        ),
        Text(
          'Current State'.tr,
          style: AppFonts.headline3(color: AppColors.grayscale90),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier(context) * 10,
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

              return TagRow(tags: rowTags, onTagPressed: _onTagPressed);
            },
          ),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier(context) * 20,
        ),
        Text(
          'Medical State'.tr,
          style: AppFonts.headline3(color: AppColors.grayscale90),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier(context) * 10,
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

              return TagRow(tags: rowTags, onTagPressed: _onTagPressed);
            },
          ),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier(context) * 20,
        ),
        Text(
          'Other'.tr,
          style: AppFonts.headline3(color: AppColors.grayscale90),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier(context) * 10,
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

              return TagRow(tags: rowTags, onTagPressed: _onTagPressed);
            },
          ),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier(context) * 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 52,
              width: SizeConfig.widthMultiplier(context) * 165,
              child: SecondaryButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Clear All'.tr,
                status: SecondaryButtonStatus.idle,
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 52,
              width: SizeConfig.widthMultiplier(context) * 165,
              child: PrimaryButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Apply'.tr,
                status: PrimaryButtonStatus.idle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _onTagPressed(Tag tag) {
    setState(() {
      tag.status = tag.status == TagStatus.active
          ? TagStatus.notActive
          : TagStatus.active;
      widget.updatedCurrentTagStatus(
          tag.name, tag.status);
    });
  }
}

class TagRow extends StatelessWidget {
  final List<Tag> tags;
  final Function(Tag) onTagPressed;

  const TagRow({
    Key? key,
    required this.tags,
    required this.onTagPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: SizeConfig.widthMultiplier(context) * 10, // Horizontal space between tags
      runSpacing: SizeConfig.heightMultiplier(context) * 10, // Vertical space between rows
      children: tags.map((tag) => Tags(
        status: tag.status,
        text: tag.name.tr,
        onPress: () => onTagPressed(tag),
      )).toList(),
    );
  }
}
