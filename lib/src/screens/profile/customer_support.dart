import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/buttons/secondary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({super.key});

  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  final List<bool> _isExpanded = [false, false, false, false, false];

  List<Map<String, dynamic>> questions = [
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

  final _whatsAppNumber = '+96596721717';
  final _phoneNumber = '+965 96721717';

  Uri get _whatsAppUrl => Uri.parse(Platform.isAndroid
      ? 'https://wa.me/$_whatsAppNumber/'
      : 'https://api.whatsapp.com/send?phone=$_whatsAppNumber');

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
        return DrawUpWidget(
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
                onTap: _chat,
              ),
              ListTile(
                leading: Image.asset(
                  'assets/icons/frame/24px/32_Phone.png',
                ),
                title: Text(
                  _phoneNumber,
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
                onTap: _callUs,
              ),
              SizedBox(
                height: 32 * SizeConfig.heightMultiplier(context),
              ),
              SizedBox(
                width: 343 * SizeConfig.widthMultiplier(context),
                height: 52 * SizeConfig.heightMultiplier(context),
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
                    left: 16 * SizeConfig.widthMultiplier(context),
                    right: 16 * SizeConfig.widthMultiplier(context),
                    top: 8 * SizeConfig.heightMultiplier(context)),
                child: Text('FAQs'.tr,
                    style: AppFonts.title3(color: AppColors.grayscale90)),
              ),
              SizedBox(height: 32 * SizeConfig.heightMultiplier(context)),
              for (int i = 0; i < questions.length; i++)
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
                          questions[i]['question'],
                          style: AppFonts.body1(color: AppColors.grayscale90),
                        ),
                        if (questions[i]['answer'] != null &&
                            _isExpanded[i] == true)
                          Text(
                            questions[i]['answer'],
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
            width: 343 * SizeConfig.widthMultiplier(context),
            height: 52 * SizeConfig.heightMultiplier(context),
            child: PrimaryButton(
              onPressed: _showModalSheet,
              text: 'Need Help'.tr,
            ),
          )),
    );
  }

  Future<void> _chat() async {
    if (!await launchUrl(_whatsAppUrl)) {
      throw Exception('Could not launch $_whatsAppUrl');
    }
  }

  Future<void> _callUs() async {
    if (!await launchUrl(Uri.parse('tel:$_phoneNumber'))) {
      throw Exception('Could not launch $_phoneNumber');
    }
  }
}
