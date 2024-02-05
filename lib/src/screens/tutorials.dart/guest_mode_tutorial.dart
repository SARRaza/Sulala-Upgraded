// import 'package:flutter/material.dart';
// import 'package:showcaseview/showcaseview.dart';

// import '../../theme/colors/colors.dart';
// import '../../theme/fonts/fonts.dart';
// import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
// import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
// import '../../widgets/pages/homepage_widgets/card.dart';
// import '../../widgets/pages/homepage_widgets/title_text.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

// import '../../widgets/pages/main_widgets/navigation_bar_guest_mode.dart';

// class GuestModeTutorial extends StatefulWidget {
//   const GuestModeTutorial({super.key});

//   @override
//   State<GuestModeTutorial> createState() => _GuestModeTutorial();
// }

// class _GuestModeTutorial extends State<GuestModeTutorial> {
//   final GlobalKey _close = GlobalKey();
//   final GlobalKey _findAnimals = GlobalKey();
//   final GlobalKey _findFarms = GlobalKey();
//   final GlobalKey _joinNow = GlobalKey();
//   final GlobalKey _signIn = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ShowCaseWidget.of(context).startShowCase(
//         [_close, _findAnimals, _findFarms, _joinNow, _signIn],
//       );
//     });
//   }

//   void _cancelShowcase() {
//     ShowCaseWidget.of(context).dismiss();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         scrolledUnderElevation: 0.0,
//         automaticallyImplyLeading: false,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Welcome',
//               style: AppFonts.title3(color: AppColors.grayscale100),
//             ),
//             Row(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     // Navigator.of(context).pushNamed('/search');
//                   },
//                   child: const Image(
//                     image:
//                         AssetImage('assets/icons/frame/24px/Icon-button.png'),
//                   ),
//                 ),
//                 SizedBox(width: SizeConfig.widthMultiplier(context) * 4),
//                 Showcase(
//                   targetShapeBorder: const CircleBorder(),
//                   tooltipBackgroundColor: Colors.transparent,
//                   descTextStyle:
//                       AppFonts.headline1(color: AppColors.grayscale00),
//                   description: 'Close the tutorial',
//                   key: _close,
//                   child: InkWell(
//                       onTap: () {
//                         _cancelShowcase();
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) =>
//                                 const NavigationBarGuestMode()));
//                       },
//                       child: const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Icon(Icons.close, color: AppColors.grayscale90),
//                       )),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16 * SizeConfig.heightMultiplier(context)),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Showcase(
//                     targetPadding: EdgeInsets.fromLTRB(
//                       50 * SizeConfig.widthMultiplier(context),
//                       25 * SizeConfig.heightMultiplier(context),
//                       50 * SizeConfig.widthMultiplier(context),
//                       25 * SizeConfig.heightMultiplier(context),
//                     ),
//                     targetShapeBorder: const CircleBorder(),
//                     key: _findAnimals,
//                     tooltipBackgroundColor: Colors.transparent,
//                     descTextStyle:
//                         AppFonts.headline1(color: AppColors.grayscale00),
//                     description:
//                         'Here you can find information about animals and their breeds',
//                     child: CardWidget(
//                       color: const Color.fromRGBO(225, 236, 185, 1),
//                       iconPath: 'assets/icons/frame/24px/Cow_Icon.png',
//                       title: 'Searching\nfor animals?',
//                       buttonText: 'Find animals',
//                       onPressed: () {
//                         // Navigator.of(context).pushNamed('/search_animals');
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 13 * SizeConfig.widthMultiplier(context)),
//                 Expanded(
//                   child: Showcase(
//                     targetPadding: EdgeInsets.fromLTRB(
//                       50 * SizeConfig.widthMultiplier(context),
//                       25 * SizeConfig.heightMultiplier(context),
//                       50 * SizeConfig.widthMultiplier(context),
//                       25 * SizeConfig.heightMultiplier(context),
//                     ),
//                     targetShapeBorder: const CircleBorder(),
//                     key: _findFarms,
//                     tooltipBackgroundColor: Colors.transparent,
//                     descTextStyle:
//                         AppFonts.headline1(color: AppColors.grayscale00),
//                     description:
//                         "Here You Can Find Another Person's Farm, View Information About It & Join It After Registration.",
//                     child: CardWidget(
//                       color: const Color.fromRGBO(246, 239, 205, 1),
//                       iconPath: 'assets/icons/frame/24px/Farm_house.png',
//                       title: 'Searching \nfor farm?',
//                       buttonText: 'Find farms',
//                       onPressed: () {
//                         // Navigator.of(context).pushNamed('/search_house_farm');
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 107 * SizeConfig.heightMultiplier(context)),
//             const TitleText(
//                 text: 'Want to start your farm\nright now and join?'),
//             SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
//             Showcase(
//               key: _joinNow,
//               description: 'Join the App',
//               targetPadding: EdgeInsets.fromLTRB(
//                 50 * SizeConfig.widthMultiplier(context),
//                 25 * SizeConfig.heightMultiplier(context),
//                 50 * SizeConfig.widthMultiplier(context),
//                 25 * SizeConfig.heightMultiplier(context),
//               ),
//               targetShapeBorder: const CircleBorder(),
//               tooltipBackgroundColor: Colors.transparent,
//               descTextStyle: AppFonts.headline1(color: AppColors.grayscale00),
//               child: SizedBox(
//                 height: 52 * SizeConfig.heightMultiplier(context),
//                 width: 108 * SizeConfig.widthMultiplier(context),
//                 child: PrimaryButton(
//                   text: 'Join now',
//                   onPressed: () {
//                     // Navigator.of(context).pushNamed('/join_now');
//                   },
//                   status: PrimaryButtonStatus.idle,
//                 ),
//               ),
//             ),
//             SizedBox(height: 8 * SizeConfig.heightMultiplier(context)),
//             Showcase(
//               targetPadding: EdgeInsets.fromLTRB(
//                 50 * SizeConfig.widthMultiplier(context),
//                 25 * SizeConfig.heightMultiplier(context),
//                 50 * SizeConfig.widthMultiplier(context),
//                 25 * SizeConfig.heightMultiplier(context),
//               ),
//               targetShapeBorder: const CircleBorder(),
//               tooltipBackgroundColor: Colors.transparent,
//               descTextStyle: AppFonts.headline1(color: AppColors.grayscale00),
//               key: _signIn,
//               description: 'Sign in',
//               child: TextButton(
//                 onPressed: () {
//                   // Handle text button press
//                 },
//                 child: PrimaryTextButton(
//                   status: TextStatus.idle,
//                   text: 'Sign in',
//                   onPressed: () {
//                     // Navigator.of(context).pushNamed('/sign_in');
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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
        title: const Text(
          'Welcome',
          style: TextStyle(
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
                      'Here you can find information about animals and their breeds',
                  child: CardWidget(
                    imagePath: 'assets/icons/frame/24px/Cow_Icon.png',
                    text: 'Searching For Animals',
                    buttonText: 'Find Animals',
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
                      "Here You Can Find Another Person's Farm, View Information About It & Join It After Registration.",
                  descTextStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  child: CardWidget(
                    imagePath: 'assets/icons/frame/24px/Farm_house.png',
                    text: 'Search For\nFarms',
                    buttonText: 'Find Farms',
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
          const Text(
            'Want To Start Your Farm\n Right Now & Join',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Showcase(
            key: _joinNow,
            description: 'Join The Farms',
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
              child: const Text(
                'Join Now',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16), // Set the text color of the button
              ),
            ),
          ),
          const SizedBox(height: 20),
          Showcase(
            key: _signIn,
            description: 'Sign In By Clicking This',
            descTextStyle: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 36, 86, 38),
                fontWeight: FontWeight.bold),
            child: TextButton(
              onPressed: () {
                // Handle text button press
              },
              child: const Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 36, 86, 38),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Showcase(
        key: _next1,
        targetPadding: EdgeInsets.all(5),
        targetBorderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        description: 'Click Here To Go To Next Page Tutorial',
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
        child: Container(
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
