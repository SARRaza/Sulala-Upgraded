import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/screens/tutorials.dart/registered_home_tutorial.dart';
import 'package:sulala_upgrade/src/widgets/other/tutorial_overlay.dart';

import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_text_button.dart';
import '../../widgets/pages/homepage_widgets/card.dart';
import '../../widgets/pages/homepage_widgets/title_text.dart';

class GuestHomeScreenTutorial extends StatefulWidget {
  const GuestHomeScreenTutorial({Key? key}) : super(key: key);

  @override
  State<GuestHomeScreenTutorial> createState() =>
      _GuestHomeScreenTutorialState();
}

class _GuestHomeScreenTutorialState extends State<GuestHomeScreenTutorial> {
  final GlobalKey _findAnimalsCard = GlobalKey();
  final GlobalKey _findFarmsCard = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    double lineWidth = totalWidth / 3;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0.0,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Welcome'.tr,
                  style: AppFonts.title3(color: AppColors.grayscale100),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Image(
                        image: AssetImage(
                            'assets/icons/frame/24px/Icon-button.png'),
                      ),
                    ),
                    SizedBox(width: SizeConfig.widthMultiplier(context) * 4),
                  ],
                ),
              ],
            ),
            backgroundColor: Colors
                .transparent, // Set the appbar background color to transparent
            elevation: 0, // Remove the appbar shadow
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                // Background Image (Bottom Sheet)
                Positioned(
                  bottom: SizeConfig.heightMultiplier(context) * 110,
                  left: SizeConfig.widthMultiplier(context) * 225,
                  right: SizeConfig.widthMultiplier(context) * 18.75,
                  child: Image.asset(
                    'assets/illustrations/cow_eating.png',
                    fit: BoxFit.fill,
                  ),
                ),
                // Content
                Padding(
                  padding:
                      EdgeInsets.all(SizeConfig.widthMultiplier(context) * 16),
                  child: Column(
                    children: _buildActualContent(), // Actual content
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Stack(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: SizedBox(
                  height: SizeConfig.heightMultiplier(context) * 60,
                  child: BottomNavigationBar(
                    iconSize: SizeConfig.widthMultiplier(context) * 24,
                    currentIndex: 0,
                    onTap: (index) {},
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.home_outlined),
                        activeIcon: const Icon(Icons.home),
                        label: 'Home'.tr,
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          "assets/icons/frame/24px/Outlined_Cow_Icon.png",
                          scale:
                              24 / (SizeConfig.widthMultiplier(context) * 24),
                        ),
                        activeIcon: Image.asset(
                          "assets/icons/frame/24px/Filled_Cow_Icon.png",
                          scale:
                              24 / (SizeConfig.widthMultiplier(context) * 24),
                        ),
                        label: 'Animals'.tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.account_circle_outlined),
                        activeIcon: const Icon(Icons.account_circle),
                        label: 'Profile'.tr,
                      )
                    ],
                    selectedItemColor: AppColors.primary20,
                    unselectedItemColor: AppColors.grayscale50,
                    selectedLabelStyle:
                        AppFonts.caption3(color: AppColors.primary20),
                    unselectedLabelStyle:
                        AppFonts.caption3(color: AppColors.grayscale50),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: totalWidth,
                  height: 1.0,
                  color: AppColors.grayscale20,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: lineWidth,
                  height: 2.0,
                  color: AppColors.primary20,
                ),
              ),
            ],
          ),
        ),
        TutorialOverlay(
          steps: [_findAnimalsCard, _findFarmsCard],
          hints: const [
            'Here you can find information about animals and their breeds',
            'Here you can find another person\'s farm, view information about it, and join it after registration'
          ],
          onFinished: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegHomeScreenTutorial())),
        )
      ],
    );
  }

  List<Widget> _buildActualContent() {
    return [
      Row(
        children: [
          Expanded(
              child: CardWidget(
            key: _findAnimalsCard,
            color: const Color.fromRGBO(225, 236, 185, 1),
            iconPath: 'assets/icons/frame/24px/Cow_Icon.png',
            title: 'Searching for animals?'.tr,
            buttonText: 'Find animals'.tr,
            onPressed: () {},
          )),
          SizedBox(width: SizeConfig.widthMultiplier(context) * 6),
          Expanded(
              child: CardWidget(
            key: _findFarmsCard,
            color: const Color.fromRGBO(246, 239, 205, 1),
            iconPath: 'assets/icons/frame/24px/Farm_house.png',
            title: 'Searching for farm?'.tr,
            buttonText: 'Find farms'.tr,
            onPressed: () {},
          )),
        ],
      ),
      SizedBox(height: SizeConfig.heightMultiplier(context) * 110),
      TitleText(text: 'Want to start your farm\nright now and join?'.tr),
      SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
      PrimaryButton(
        text: 'Join Now'.tr,
        onPressed: () {},
        status: PrimaryButtonStatus.idle,
      ),
      SizedBox(height: SizeConfig.heightMultiplier(context) * 8),
      PrimaryTextButton(
        status: TextStatus.idle,
        text: 'Sign In'.tr,
        onPressed: () {},
      ),
    ];
  }
}
