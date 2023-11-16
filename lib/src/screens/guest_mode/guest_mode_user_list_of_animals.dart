import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/search_bars/button_search_bar.dart';

import 'package:sulala_upgrade/src/data/globals.dart' as globals;

import '../../widgets/pages/homepage_widgets/title_text.dart';
import '../create_animal/animal_filters.dart';
import '../create_animal/create_animal.dart';
import '../create_animal/owned_animal_detail_reg_mode.dart';
import '../sign_in/sign_in.dart';
import '../sign_up/join_now.dart';

class GuestModeUserListOfAnimals extends StatefulWidget {
  final List<String> selectedFilters;

  const GuestModeUserListOfAnimals({super.key, required this.selectedFilters});

  @override
  State<GuestModeUserListOfAnimals> createState() =>
      _GuestModeUserListOfAnimals();
}

class _GuestModeUserListOfAnimals extends State<GuestModeUserListOfAnimals> {
  final List<Map<String, dynamic>> mammals = [];

  List<Map<String, dynamic>> _filteredMammals = [];

  @override
  void initState() {
    super.initState();
    _updateFilteredMammals();
  }

  void _filterMammals(String query) {
    setState(() {
      _updateFilteredMammals(query: query);
    });
  }

  void _updateFilteredMammals({String? query}) {
    _filteredMammals = mammals.where((mammal) {
      final name = mammal['name'].toString().toLowerCase();
      final subtitle = mammal['subtitle'].toString().toLowerCase();
      return (query == null ||
              query.isEmpty ||
              name.contains(query.toLowerCase()) ||
              subtitle.contains(query.toLowerCase())) &&
          (widget.selectedFilters.isEmpty ||
              widget.selectedFilters.contains(mammal['subtitle']));
    }).toList();
  }

  void _removeSelectedFilter(String filter) {
    setState(() {
      widget.selectedFilters.remove(filter);
      _updateFilteredMammals();
    });
  }

  void navigateToAnimalInfo(Map<String, dynamic> mammal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OwnedAnimalDetailsRegMode(
          imagePath: mammal['image'],
          title: mammal['name'],
          geninfo: mammal['subtitle'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Animals',
            style: AppFonts.title3(color: AppColors.grayscale90),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: globals.widthMediaQuery * 16,
                right: globals.widthMediaQuery * 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: globals.heightMediaQuery * 16),
                mammals.isNotEmpty
                    ? Visibility(
                        visible: widget.selectedFilters
                            .isNotEmpty, // Show space if there are selected filters
                        child: Wrap(
                          spacing: globals.widthMediaQuery * 8,
                          children: widget.selectedFilters.map((filter) {
                            return Chip(
                              deleteIcon: Icon(
                                Icons.close_rounded,
                                color: AppColors.grayscale90,
                                size: globals.widthMediaQuery * 18,
                              ),
                              labelStyle:
                                  AppFonts.body2(color: AppColors.grayscale90),
                              label: Text(filter),
                              backgroundColor: AppColors
                                  .grayscale10, // Set the background color

                              onDeleted: () {
                                _removeSelectedFilter(filter);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    50), // Adjust the radius as needed
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    : const SizedBox.shrink(),
                mammals.isNotEmpty
                    ? _filteredMammals.isNotEmpty
                        ? SizedBox(
                            height: globals.heightMediaQuery * 812,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _filteredMammals.length,
                              itemBuilder: (context, index) {
                                final mammal = _filteredMammals[index];
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: globals.widthMediaQuery * 24,
                                    backgroundImage:
                                        AssetImage(mammal['image']),
                                  ),
                                  title: Text(mammal['name']),
                                  subtitle: Text(mammal['subtitle']),
                                  onTap: () {
                                    navigateToAnimalInfo(mammal);
                                  },
                                );
                              },
                            ),
                          )
                        : SingleChildScrollView(
                            child: Center(
                              heightFactor: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/illustrations/cow_search.png',
                                  ),
                                  SizedBox(
                                    height: globals.heightMediaQuery * 32,
                                  ),
                                  Text(
                                    'No Animals Found',
                                    style: AppFonts.headline3(
                                        color: AppColors.grayscale90),
                                  ),
                                  Text(
                                    'Try adjusting the filters',
                                    style: AppFonts.body2(
                                        color: AppColors.grayscale70),
                                  ),
                                  SizedBox(
                                    height: globals.heightMediaQuery * 24,
                                  ),
                                ],
                              ),
                            ),
                          )
                    : Center(
                        heightFactor: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/illustrations/cow_search.png',
                            ),
                            SizedBox(
                              height: globals.heightMediaQuery * 32,
                            ),
                            Text(
                              'No Animals Added Yet',
                              style:
                                  AppFonts.title4(color: AppColors.grayscale90),
                            ),
                            Text(
                              'Sign In To Create A Farm & Add An Animal',
                              style: AppFonts.headline4(
                                  color: AppColors.grayscale70),
                            ),
                            SizedBox(
                              height: globals.heightMediaQuery * 24,
                            ),
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
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
