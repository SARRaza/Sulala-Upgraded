import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'registered_home_tutorial.dart';

class GuestHomeScreenTutorial extends StatefulWidget {
  const GuestHomeScreenTutorial({super.key});

  @override
  State<GuestHomeScreenTutorial> createState() => _GuestHomeScreenTutorial();
}

class _GuestHomeScreenTutorial extends State<GuestHomeScreenTutorial> {
  final GlobalKey _findAnimals = GlobalKey();
  final GlobalKey _findFarms = GlobalKey();
  final GlobalKey _joinNow = GlobalKey();
  final GlobalKey _signIn = GlobalKey();
  final GlobalKey _next1 = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context).startShowCase(
            [_findAnimals, _findFarms, _joinNow, _signIn, _next1]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back arrow button
        title: Text(
          'Welcome'.tr,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications button press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Showcase(
                  targetPadding: EdgeInsets.fromLTRB(
                    50 * SizeConfig.widthMultiplier(context),
                    25 * SizeConfig.heightMultiplier(context),
                    50 * SizeConfig.widthMultiplier(context),
                    25 * SizeConfig.heightMultiplier(context),
                  ),
                  targetShapeBorder: const CircleBorder(),
                  key: _findAnimals,
                  tooltipBackgroundColor: Colors.transparent,
                  descTextStyle:
                      AppFonts.headline1(color: AppColors.grayscale00),
                  description:
                      'Here you can find information about animals and their breeds'
                          .tr,
                  child: CardWidget(
                    imagePath: 'assets/icons/frame/24px/Cow_Icon.png',
                    text: 'Searching For Animals'.tr,
                    buttonText: 'Find Animals'.tr,
                    onPressed: () {
                      // Handle button 1 press
                    },
                    color: const Color.fromRGBO(225, 236, 185, 1),
                  ),
                ),
              ),
              Expanded(
                child: Showcase(
                  targetBorderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  key: _findFarms,
                  tooltipBackgroundColor:
                      const Color.fromARGB(255, 254, 255, 168),
                  description:
                      "Here You Can Find Another Person's Farm, View Information About It & Join It After Registration."
                          .tr,
                  descTextStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  child: CardWidget(
                    imagePath: 'assets/icons/frame/24px/Farm_house.png',
                    text: 'Search For\nFarms'.tr,
                    buttonText: 'Find Farms'.tr,
                    onPressed: () {
                      // Handle button 2 press
                    },
                    color: const Color.fromRGBO(246, 239, 205, 1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 120),
          Text(
            'Want To Start Your Farm\n Right Now & Join'.tr,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    255, 36, 86, 38), // Set the background color of the button
              ),
              onPressed: () {},
              child: Text(
                'Join Now'.tr,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16), // Set the text color of the button
              ),
            ),
          ),
          const SizedBox(height: 20),
          Showcase(
            key: _signIn,
            description: 'Sign In By Clicking This'.tr,
            descTextStyle: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 36, 86, 38),
                fontWeight: FontWeight.bold),
            child: TextButton(
              onPressed: () {
                // Handle text button press
              },
              child: Text(
                'Sign In'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 36, 86, 38),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Showcase(
        key: _next1,
        targetPadding: const EdgeInsets.all(5),
        targetBorderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        description: 'Click Here To Go To Next Page Tutorial'.tr,
        descTextStyle: const TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 36, 86, 38),
            fontWeight: FontWeight.bold),
        onTargetClick: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  const RegHomeScreenTutorial(), // Replace with your desired page.
            ),
          );
        },
        disposeOnTap: true,
        child: SizedBox(
          height: 70,
          width: 100,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      const RegHomeScreenTutorial(), // Replace with your desired page.
                ),
              );
            },
            backgroundColor: Colors.white,
            elevation: 10,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.arrow_right_alt,
              size: 54,
            ),
          ),
        ),
      ),
    );
  }
}
