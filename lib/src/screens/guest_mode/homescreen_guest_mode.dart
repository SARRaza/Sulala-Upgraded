import 'package:flutter/material.dart';
import 'package:sulala_app/src/screens/guest_mode/search_page.dart';
import 'package:sulala_app/src/screens/guest_mode/search_page_animals.dart';
import 'package:sulala_app/src/screens/guest_mode/search_page_house_farm.dart';
import 'package:sulala_app/src/screens/guest_mode/shimmer_homescreen.dart';
import 'package:sulala_app/src/screens/sign_in/sign_in.dart';
import 'package:sulala_app/src/screens/sign_up/join_now.dart';
import '../../theme/colors/colors.dart';
import 'package:sulala_app/src/theme/fonts/fonts.dart';
import 'package:sulala_app/src/widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/pages/homepage_widgets/card.dart';
import '../../widgets/pages/homepage_widgets/title_text.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;

class HomeScreenGuestMode extends StatefulWidget {
  const HomeScreenGuestMode({Key? key}) : super(key: key);

  @override
  State<HomeScreenGuestMode> createState() => _HomeScreenGuestModeState();
}

class _HomeScreenGuestModeState extends State<HomeScreenGuestMode> {
  double heightMediaQuery = globals.heightMediaQuery;
  double widthMediaQuery = globals.widthMediaQuery;
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
                'Welcome',
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
                  SizedBox(width: globals.widthMediaQuery * 4),
                  InkWell(
                    onTap: () {},
                    child: const Image(
                      image: AssetImage(
                          'assets/icons/frame/24px/Icon-button1.png'),
                    ),
                  ),
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
            height: globals.heightMediaQuery * 704.004,
            child: Stack(
              children: [
                // Background Image (Bottom Sheet)
                _isLoading == false
                    ? Positioned(
                        bottom: globals.heightMediaQuery * 110,
                        left: globals.widthMediaQuery * 225,
                        right: globals.widthMediaQuery * 18.75,
                        child: Image.asset(
                          'assets/illustrations/cow_eating.png',
                          fit: BoxFit.fill,
                        ),
                      )
                    : Container(),

                // Content
                Padding(
                  padding: EdgeInsets.all(globals.widthMediaQuery * 16),
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
              title: 'Searching\nfor animals?',
              buttonText: 'Find animals',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchPageAnimals(),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: globals.widthMediaQuery * 6),
          Expanded(
            child: CardWidget(
              color: const Color.fromRGBO(246, 239, 205, 1),
              iconPath: 'assets/icons/frame/24px/Farm_house.png',
              title: 'Searching \nfor farm?',
              buttonText: 'Find farms',
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
      SizedBox(height: globals.heightMediaQuery * 110),
      const TitleText(text: 'Want to start your farm\nright now and join?'),
      SizedBox(height: globals.heightMediaQuery * 24),
      SizedBox(
        height: globals.heightMediaQuery * 48,
        width: globals.widthMediaQuery * 108,
        child: PrimaryButton(
          text: 'Join now',
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
      SizedBox(height: globals.heightMediaQuery * 8),
      PrimaryTextButton(
        status: TextStatus.idle,
        text: 'Sign in',
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
