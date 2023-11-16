import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sulala_app/src/widgets/pages/main_widgets/navigation_bar_guest_mode.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/pages/homepage_widgets/card.dart';
import '../../widgets/pages/homepage_widgets/title_text.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;

class GuestModeTutorial extends StatefulWidget {
  const GuestModeTutorial({super.key});

  @override
  State<GuestModeTutorial> createState() => _GuestModeTutorial();
}

class _GuestModeTutorial extends State<GuestModeTutorial> {
  final GlobalKey _close = GlobalKey();
  final GlobalKey _findAnimals = GlobalKey();
  final GlobalKey _findFarms = GlobalKey();
  final GlobalKey _joinNow = GlobalKey();
  final GlobalKey _signIn = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase(
        [_close, _findAnimals, _findFarms, _joinNow, _signIn],
      );
    });
  }

  void _cancelShowcase() {
    ShowCaseWidget.of(context).dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Welcome',
              style: AppFonts.title3(color: AppColors.grayscale100),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.of(context).pushNamed('/search');
                  },
                  child: const Image(
                    image:
                        AssetImage('assets/icons/frame/24px/Icon-button.png'),
                  ),
                ),
                SizedBox(width: globals.widthMediaQuery * 4),
                Showcase(
                  targetShapeBorder: const CircleBorder(),
                  tooltipBackgroundColor: Colors.transparent,
                  descTextStyle:
                      AppFonts.headline1(color: AppColors.grayscale00),
                  description: 'Close the tutorial',
                  key: _close,
                  child: InkWell(
                      onTap: () {
                        _cancelShowcase();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const NavigationBarGuestMode()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.close, color: AppColors.grayscale90),
                      )),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * globals.heightMediaQuery),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Showcase(
                    targetPadding: EdgeInsets.fromLTRB(
                      50 * globals.widthMediaQuery,
                      25 * globals.heightMediaQuery,
                      50 * globals.widthMediaQuery,
                      25 * globals.heightMediaQuery,
                    ),
                    targetShapeBorder: const CircleBorder(),
                    key: _findAnimals,
                    tooltipBackgroundColor: Colors.transparent,
                    descTextStyle:
                        AppFonts.headline1(color: AppColors.grayscale00),
                    description:
                        'Here you can find information about animals and their breeds',
                    child: CardWidget(
                      color: const Color.fromRGBO(225, 236, 185, 1),
                      iconPath: 'assets/icons/frame/24px/Cow_Icon.png',
                      title: 'Searching\nfor animals?',
                      buttonText: 'Find animals',
                      onPressed: () {
                        // Navigator.of(context).pushNamed('/search_animals');
                      },
                    ),
                  ),
                ),
                SizedBox(width: 13 * globals.widthMediaQuery),
                Expanded(
                  child: Showcase(
                    targetPadding: EdgeInsets.fromLTRB(
                      50 * globals.widthMediaQuery,
                      25 * globals.heightMediaQuery,
                      50 * globals.widthMediaQuery,
                      25 * globals.heightMediaQuery,
                    ),
                    targetShapeBorder: const CircleBorder(),
                    key: _findFarms,
                    tooltipBackgroundColor: Colors.transparent,
                    descTextStyle:
                        AppFonts.headline1(color: AppColors.grayscale00),
                    description:
                        "Here You Can Find Another Person's Farm, View Information About It & Join It After Registration.",
                    child: CardWidget(
                      color: const Color.fromRGBO(246, 239, 205, 1),
                      iconPath: 'assets/icons/frame/24px/Farm_house.png',
                      title: 'Searching \nfor farm?',
                      buttonText: 'Find farms',
                      onPressed: () {
                        // Navigator.of(context).pushNamed('/search_house_farm');
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 107 * globals.heightMediaQuery),
            const TitleText(
                text: 'Want to start your farm\nright now and join?'),
            SizedBox(height: 24 * globals.heightMediaQuery),
            Showcase(
              key: _joinNow,
              description: 'Join the App',
              targetPadding: EdgeInsets.fromLTRB(
                50 * globals.widthMediaQuery,
                25 * globals.heightMediaQuery,
                50 * globals.widthMediaQuery,
                25 * globals.heightMediaQuery,
              ),
              targetShapeBorder: const CircleBorder(),
              tooltipBackgroundColor: Colors.transparent,
              descTextStyle: AppFonts.headline1(color: AppColors.grayscale00),
              child: SizedBox(
                height: 52 * globals.heightMediaQuery,
                width: 108 * globals.widthMediaQuery,
                child: PrimaryButton(
                  text: 'Join now',
                  onPressed: () {
                    // Navigator.of(context).pushNamed('/join_now');
                  },
                  status: PrimaryButtonStatus.idle,
                ),
              ),
            ),
            SizedBox(height: 8 * globals.heightMediaQuery),
            Showcase(
              targetPadding: EdgeInsets.fromLTRB(
                50 * globals.widthMediaQuery,
                25 * globals.heightMediaQuery,
                50 * globals.widthMediaQuery,
                25 * globals.heightMediaQuery,
              ),
              targetShapeBorder: const CircleBorder(),
              tooltipBackgroundColor: Colors.transparent,
              descTextStyle: AppFonts.headline1(color: AppColors.grayscale00),
              key: _signIn,
              description: 'Sign in',
              child: TextButton(
                onPressed: () {
                  // Handle text button press
                },
                child: PrimaryTextButton(
                  status: TextStatus.idle,
                  text: 'Sign in',
                  onPressed: () {
                    // Navigator.of(context).pushNamed('/sign_in');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
