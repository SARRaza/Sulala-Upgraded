import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/screens/sign_up/join_now.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/icon_secondary_button.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/buttons/secondary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/lists/table_list/table_clickable_link.dart';
import '../../widgets/other/two_information_block.dart';
import 'search_page_owner_animals.dart';

class UserDetails extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String email;
  final String phoneNumber;

  const UserDetails({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.email,
    required this.phoneNumber,
  });

  @override
  State<UserDetails> createState() => _SearchDetails();
}

class _SearchDetails extends State<UserDetails> {
  bool isHelperSelected = false;
  bool isWorkerSelected = false;
  bool isViewOnlySelected = true;
  bool isCanEditSelected = false;
  bool showList = false;
  bool isGeneralInfoSelected = false;
  bool isBreedingInfoSelected = false;
  bool isMedicalInfoSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            color: AppColors.grayscale90,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            SizeConfig.widthMultiplier(context) * 16,
            0,
            SizeConfig.widthMultiplier(context) * 16,
            0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier(context) * 24,
                ),
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: SizeConfig.widthMultiplier(context) * 60,
                    backgroundImage: AssetImage(widget.imagePath),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier(context) * 15,
                ),
                Text(
                  widget.title,
                  style: AppFonts.title4(color: AppColors.grayscale90),
                ),
                Text(
                  widget.email,
                  style: AppFonts.body2(color: AppColors.primary30),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier(context) * 15,
                ),
                Text(
                  'House Farm'.tr,
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
                SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: SizeConfig.widthMultiplier(context) * 165,
                        height: SizeConfig.heightMultiplier(context) * 40,
                        child: IconSecondaryButton(
                          iconPath:
                              'assets/icons/frame/24px/20_Status-farm.png',
                          onPressed: () {
                            _showFilterModalSheet(context);
                          },
                          text: "Join farm".tr,
                          status: SecondaryIconStatus.idle,
                        ),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        height: SizeConfig.heightMultiplier(context) * 40,
                        child: IconSecondaryButton(
                          iconPath:
                              'assets/icons/frame/24px/Outlined_Cow_green_icon.png',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SearchPageOwnerAnimals(),
                              ),
                            );
                          },
                          text: "View animals".tr,
                          status: SecondaryIconStatus.idle,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier(context) * 32,
                ),
                TwoInformationBlock(
                    head1: '24',
                    head2: '4',
                    subtitle1: 'Animals'.tr,
                    subtitle2: 'Collaborations'.tr),
                SizedBox(
                  height: SizeConfig.heightMultiplier(context) * 32,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Details'.tr,
                      style: AppFonts.title5(
                        color: AppColors.grayscale90,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier(context) * 14,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier(context) * 40,
                      child: TableClickableText(
                        text1: 'Phone number'.tr,
                        urlText: widget.phoneNumber,
                        url: 'tel:${widget.phoneNumber}',
                        iconPath: 'assets/icons/frame/24px/Outlined_Phone.png',
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier(context) * 41,
                      child: TableClickableText(
                        text1: 'Email address'.tr,
                        urlText: widget.email,
                        url: 'mailto:${widget.email}',
                        iconPath: 'assets/icons/frame/24px/16_Mail.png',
                      ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier(context) * 52),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          height: SizeConfig.heightMultiplier(context) * 52,
          width: SizeConfig.widthMultiplier(context) * 150,
          child: PrimaryButton(
            text: "Start your farm".tr,
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const JoinNow()));
            },
            status: PrimaryButtonStatus.idle,
            position: PrimaryButtonPosition.primary,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  void _showFilterModalSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: DrawUpWidget(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Image(
                      image: AssetImage('assets/illustrations/farm_gray.png')),
                ),
                SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
                Text(
                  'Join this farm?'.tr,
                  style: AppFonts.title3(color: AppColors.grayscale90),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.heightMultiplier(context) * 15),
                Text(
                  'ifYouJoin'.trParams({'name': widget.title}),
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
                SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: SizeConfig.heightMultiplier(context) * 52,
                      width: SizeConfig.widthMultiplier(context) * 165,
                      child: SecondaryButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: "Cancel".tr,
                        status: SecondaryButtonStatus.idle,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier(context) * 52,
                      width: SizeConfig.widthMultiplier(context) * 165,
                      child: PrimaryButton(
                        onPressed: () {},
                        text: "Join farm".tr,
                        status: PrimaryButtonStatus.idle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
