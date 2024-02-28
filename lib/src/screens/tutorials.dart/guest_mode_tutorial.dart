import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sulala_upgrade/src/screens/tutorials.dart/registered_home_tutorial.dart';

import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/buttons/tutorial_next_button.dart';
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
  final GlobalKey _findAnimals = GlobalKey();
  final GlobalKey _findFarms = GlobalKey();
  final GlobalKey _joinNow = GlobalKey();
  final GlobalKey _signIn = GlobalKey();
  final GlobalKey _next1 = GlobalKey();
  BuildContext? showcaseContext;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(showcaseContext!).startShowCase(
            [_findAnimals, _findFarms, _joinNow, _signIn, _next1]));
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) {
          showcaseContext = context;
          double totalWidth = MediaQuery.of(context).size.width;
          double lineWidth = totalWidth / 3;

          return SafeArea(
            child: Scaffold(
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
                          onTap: () {
                          },
                          child: const Image(
                            image:
                                AssetImage('assets/icons/frame/24px/Icon-button.png'),
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
              floatingActionButton: TutorialTextButton(
                  showcaseKey: _next1,
                  description: 'Click Here To Go To Next Page Tutorial'.tr,
                  onTargetClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegHomeScreenTutorial() // Replace with your desired page.
                      ),
                    );
                  }),
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
                        onTap: (index) {
                        },
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: const Icon(Icons.home_outlined),
                            activeIcon: const Icon(Icons.home),
                            label: 'Home'.tr,
                          ),
                          BottomNavigationBarItem(
                            icon: Image.asset(
                              "assets/icons/frame/24px/Outlined_Cow_Icon.png",
                              scale: 24 / (SizeConfig.widthMultiplier(context) * 24),
                            ),
                            activeIcon: Image.asset(
                              "assets/icons/frame/24px/Filled_Cow_Icon.png",
                              scale: 24 / (SizeConfig.widthMultiplier(context) * 24),
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
          );
        }
      ),
    );
  }

  List<Widget> _buildActualContent() {
    return [
      Row(
        children: [
          Expanded(
            child: Showcase(
              targetPadding: EdgeInsets.fromLTRB(
                50 * SizeConfig.widthMultiplier(context),
                25 * SizeConfig.heightMultiplier(context),
                20 * SizeConfig.widthMultiplier(context),
                25 * SizeConfig.heightMultiplier(context),
              ),
              targetShapeBorder: const CircleBorder(),
              key: _findAnimals,
              tooltipBackgroundColor: Colors.transparent,
              descTextStyle: AppFonts.headline1(color: AppColors.grayscale00),
              description:
                  'Here you can find information about animals and their breeds'
                      .tr,
              child: CardWidget(
                color: const Color.fromRGBO(225, 236, 185, 1),
                iconPath: 'assets/icons/frame/24px/Cow_Icon.png',
                title: 'Searching for animals?'.tr,
                buttonText: 'Find animals'.tr,
                onPressed: () {
                },
              ),
            ),
          ),
          SizedBox(width: SizeConfig.widthMultiplier(context) * 6),
          Expanded(
            child: Showcase(
              key: _findFarms,
              targetPadding: EdgeInsets.fromLTRB(
                20 * SizeConfig.widthMultiplier(context),
                25 * SizeConfig.heightMultiplier(context),
                50 * SizeConfig.widthMultiplier(context),
                25 * SizeConfig.heightMultiplier(context),
              ),
              targetShapeBorder: const CircleBorder(),
              tooltipBackgroundColor: const Color.fromARGB(255, 254, 255, 168),
              description:
                  "Here You Can Find Another Person's Farm, View Information About It & Join It After Registration."
                      .tr,
              descTextStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              child: CardWidget(
                color: const Color.fromRGBO(246, 239, 205, 1),
                iconPath: 'assets/icons/frame/24px/Farm_house.png',
                title: 'Searching for farm?'.tr,
                buttonText: 'Find farms'.tr,
                onPressed: () {
                },
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: SizeConfig.heightMultiplier(context) * 110),
      TitleText(text: 'Want to start your farm\nright now and join?'.tr),
      SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
      Showcase(
        key: _joinNow,
        description: 'Join The Farms'.tr,
        tooltipBackgroundColor: const Color.fromARGB(255, 36, 86, 38),
        descTextStyle: const TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        targetPadding: const EdgeInsets.all(5),
        targetBorderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        child: PrimaryButton(
          text: 'Join Now'.tr,
          onPressed: () {
          },
          status: PrimaryButtonStatus.idle,
        ),
      ),
      SizedBox(height: SizeConfig.heightMultiplier(context) * 8),
      Showcase(
        key: _signIn,
        description: 'Sign In By Clicking This'.tr,
        descTextStyle: const TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 36, 86, 38),
            fontWeight: FontWeight.bold),
        child: PrimaryTextButton(
          status: TextStatus.idle,
          text: 'Sign In'.tr,
          onPressed: () {
          },
        ),
      ),
    ];
  }
}