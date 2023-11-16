import 'package:flutter/material.dart';
import 'package:sulala_app/src/screens/create_animal/user_list_of_animals.dart';
import '../../../screens/profile/profile_page.dart';
import '../../../screens/reg_mode/reg_home_page.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;

class NavigationBarRegMode extends StatefulWidget {
  const NavigationBarRegMode({Key? key}) : super(key: key);

  @override
  State<NavigationBarRegMode> createState() => _NavigationBarRegModeState();
}

class _NavigationBarRegModeState extends State<NavigationBarRegMode> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeScreenRegMode(),
    const UserListOfAnimals(
      selectedFilters: [],
    ),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    double lineWidth = totalWidth / 3;
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: Stack(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: SizedBox(
                height: globals.heightMediaQuery * 60,
                child: BottomNavigationBar(
                  iconSize: globals.widthMediaQuery * 24,
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  items: <BottomNavigationBarItem>[
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      activeIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/icons/frame/24px/Outlined_Cow_Icon.png",
                        scale: 24 / (globals.widthMediaQuery * 24),
                      ),
                      activeIcon: Image.asset(
                        "assets/icons/frame/24px/Filled_Cow_Icon.png",
                        scale: 24 / (globals.widthMediaQuery * 24),
                      ),
                      label: 'Animals',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle_outlined),
                      activeIcon: Icon(Icons.account_circle),
                      label: 'Profile',
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
              left: lineWidth * _currentIndex,
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
}
