import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/buttons/secondary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomerSupportState createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  final List<bool> _isExpanded = [false, false, false, false, false];

  List<Map<String, dynamic>> quastions = [
    {
      'question': 'Question #1'.tr,
      'answer': 'Subtitle1'.tr,
    },
    {
      'question': 'Question #2'.tr,
      'answer': 'Subtitle2'.tr,
    },
    {
      'question': 'Question #3'.tr,
      'answer': 'Subtitle3'.tr,
    },
    {
      'question': 'Question #4'.tr,
      'answer': 'Subtitle4'.tr,
    },
    {
      'question': 'Question #5'.tr,
      'answer': 'Subtitle5'.tr,
    },
  ];

  void _toggleExpansion(int index) {
    setState(() {
      _isExpanded[index] = !_isExpanded[index];
    });
  }

  void _showModalSheet() {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return DrowupWidget(
          heightFactor: 0.475,
          heading: 'Contact Us'.tr,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Image.asset(
                  'assets/icons/frame/24px/32_WhatsApp.png',
                ),
                title: Text(
                  'WhatsApp'.tr,
                  style: AppFonts.body1(color: AppColors.grayscale90),
                ),
                subtitle: Text(
                  'Chat With Support'.tr,
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.grayscale50,
                  size: 30,
                ),
                onTap: () {
                  // Handle option 1 tap
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icons/frame/24px/32_Phone.png',
                ),
                title: Text(
                  '+965 96721717',
                  style: AppFonts.body1(color: AppColors.grayscale90),
                ),
                subtitle: Text(
                  'Call Us'.tr,
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.grayscale50,
                  size: 30,
                ),
                onTap: () {
                  // Handle option 1 tap
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 32 * globals.heightMediaQuery,
              ),
              SizedBox(
                width: 343 * globals.widthMediaQuery,
                height: 52 * globals.heightMediaQuery,
                child: SecondaryButton(
                  text: 'Cancel'.tr,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0.0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Customer Support'.tr,
              style: AppFonts.headline3(color: AppColors.grayscale90),
            ),
            leading: IconButton(
              padding: EdgeInsets.zero,
              icon: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.grayscale10,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.grayscale90,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 16 * globals.widthMediaQuery,
                    right: 16 * globals.widthMediaQuery,
                    top: 8 * globals.heightMediaQuery),
                child: Text('FAQs'.tr,
                    style: AppFonts.title3(color: AppColors.grayscale90)),
              ),
              SizedBox(height: 32 * globals.heightMediaQuery),
              for (int i = 0; i < quastions.length; i++)
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.grayscale20,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quastions[i]['question'],
                          style: AppFonts.body1(color: AppColors.grayscale90),
                        ),
                        if (quastions[i]['answer'] != null &&
                            _isExpanded[i] == true)
                          Text(
                            quastions[i]['answer'],
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        _isExpanded[i]
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                        color: AppColors.grayscale50,
                        size: 30,
                      ),
                      onPressed: () => _toggleExpansion(i),
                    ),
                  ),
                ),
            ],
          ),
          floatingActionButton: SizedBox(
            width: 343 * globals.widthMediaQuery,
            height: 52 * globals.heightMediaQuery,
            child: PrimaryButton(
              onPressed: _showModalSheet,
              text: 'Need Help'.tr,
            ),
          )),
    );
  }
}
