import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/pages/homepage_widgets/card.dart';
import '../../widgets/pages/homepage_widgets/title_text.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

import '../sign_in/sign_in.dart';
import '../sign_up/join_now.dart';
import '../search/search_page.dart';
import '../search/search_page_animals.dart';
import '../search/search_page_house_farm.dart';
import 'shimmer_homescreen.dart';

class HomeScreenGuestMode extends StatefulWidget {
  const HomeScreenGuestMode({Key? key}) : super(key: key);

  @override
  State<HomeScreenGuestMode> createState() => _HomeScreenGuestModeState();
}

class _HomeScreenGuestModeState extends State<HomeScreenGuestMode> {
  bool _isLoading = true; // Add a boolean for loading state

  @override
  void initState() {
    super.initState();

    // Call the asynchronous function to simulate data loading
    _loadData();
  }

  Future<void> _loadData() async {
    // Simulate data loading with a delay
    await Future.delayed(const Duration(seconds: 2));

    // Update the loading state
    setState(() {
      _isLoading = false; // Data is loaded, set loading state to false
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ),
                      );
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
          child: SizedBox(
            height: SizeConfig.heightMultiplier(context) * 704.004,
            child: Stack(
              children: [
                // Background Image (Bottom Sheet)
                _isLoading == false
                    ? Positioned(
                        bottom: SizeConfig.heightMultiplier(context) * 110,
                        left: SizeConfig.widthMultiplier(context) * 225,
                        right: SizeConfig.widthMultiplier(context) * 18.75,
                        child: Image.asset(
                          'assets/illustrations/cow_eating.png',
                          fit: BoxFit.fill,
                        ),
                      )
                    : Container(),

                // Content
                Padding(
                  padding:
                      EdgeInsets.all(SizeConfig.widthMultiplier(context) * 16),
                  child: Column(
                    children: _isLoading
                        ? [
                            const ShimmerHomePageWidget()
                          ] // Shimmer placeholders
                        : _buildActualContent(), // Actual content
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActualContent() {
    return [
      Row(
        children: [
          Expanded(
            child: CardWidget(
              color: const Color.fromRGBO(225, 236, 185, 1),
              iconPath: 'assets/icons/frame/24px/Cow_Icon.png',
              title: 'Searching for animals?'.tr,
              buttonText: 'Find animals'.tr,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchPageAnimals(),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: SizeConfig.widthMultiplier(context) * 6),
          Expanded(
            child: CardWidget(
              color: const Color.fromRGBO(246, 239, 205, 1),
              iconPath: 'assets/icons/frame/24px/Farm_house.png',
              title: 'Searching for farm?'.tr,
              buttonText: 'Find farms'.tr,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchPageHouseFarm(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      SizedBox(height: SizeConfig.heightMultiplier(context) * 110),
      TitleText(text: 'Want to start your farm\nright now and join?'.tr),
      SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
      SizedBox(
        height: SizeConfig.heightMultiplier(context) * 48,
        width: SizeConfig.widthMultiplier(context) * 108,
        child: PrimaryButton(
          text: 'Join Now'.tr,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const JoinNow(),
              ),
            );
          },
          status: PrimaryButtonStatus.idle,
        ),
      ),
      SizedBox(height: SizeConfig.heightMultiplier(context) * 8),
      PrimaryTextButton(
        status: TextStatus.idle,
        text: 'Sign In'.tr,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SignIn(),
            ),
          );
        },
      ),
    ];
  }
}
