import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

class ProfileThreeInformationBlock extends StatelessWidget {
  final String head1;

  final String head2;

  final String head3;

  const ProfileThreeInformationBlock({
    required this.head1,
    required this.head2,
    required this.head3,
    Key? key,
  }) : super(key: key);
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
      return DateFormat('dd.MM.yyyy').parse(selectedDate);
    } catch (e) {
      return null; // Return null if there is an error parsing the date
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9F5EC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  head1,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                Text(
                  "Animals",
                  style: AppFonts.caption2(color: AppColors.grayscale70),
                ),
              ],
            ),
          ),
          Container(
            height: globals.heightMediaQuery * 22,
            width: 1,
            color: AppColors.grayscale30,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  head2,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                Text(
                  "Farm",
                  style: AppFonts.caption2(color: AppColors.grayscale70),
                ),
              ],
            ),
          ),
          Container(
            height: globals.heightMediaQuery * 22,
            width: 1,
            color: AppColors.grayscale30,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  head3,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                Text(
                  'Collaborations'.tr,
                  style: AppFonts.caption2(color: AppColors.grayscale70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// Example of use:

// InformationBlock(
//                     head1: "Head 1",
//                     head2: "Head 2",
//                     head3: "Head 3",
//                   ),