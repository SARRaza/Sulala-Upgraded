import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/screens/guest_mode/animal_details.dart';
import 'package:sulala_upgrade/src/widgets/other/animal_list_item.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_text_button.dart';
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

  void _navigateToAnimalInfo(Map<String, dynamic> mammal) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AnimalDetails(
                imagePath: mammal['image'],
                title: mammal['name'],
                genInfo: mammal['subtitle'],
                animalType: mammal['type'],
                animalDiet: mammal['diet'])));
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
            'Animals'.tr,
            style: AppFonts.title3(color: AppColors.grayscale90),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.widthMultiplier(context) * 16,
                right: SizeConfig.widthMultiplier(context) * 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
                mammals.isNotEmpty
                    ? Visibility(
                        visible: widget.selectedFilters
                            .isNotEmpty, // Show space if there are selected filters
                        child: Wrap(
                          spacing: SizeConfig.widthMultiplier(context) * 8,
                          children: widget.selectedFilters.map((filter) {
                            return Chip(
                              deleteIcon: Icon(
                                Icons.close_rounded,
                                color: AppColors.grayscale90,
                                size: SizeConfig.widthMultiplier(context) * 18,
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
                            height: SizeConfig.heightMultiplier(context) * 812,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _filteredMammals.length,
                              itemBuilder: (context, index) {
                                final mammal = _filteredMammals[index];
                                return AnimalListItem(
                                    mammal: mammal,
                                    onTap: () => _navigateToAnimalInfo(mammal));
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
                                    height:
                                        SizeConfig.heightMultiplier(context) *
                                            32,
                                  ),
                                  Text(
                                    'No Animals Found'.tr,
                                    style: AppFonts.headline3(
                                        color: AppColors.grayscale90),
                                  ),
                                  Text(
                                    'Try adjusting the filters'.tr,
                                    style: AppFonts.body2(
                                        color: AppColors.grayscale70),
                                  ),
                                  SizedBox(
                                    height:
                                        SizeConfig.heightMultiplier(context) *
                                            24,
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
                              height: SizeConfig.heightMultiplier(context) * 32,
                            ),
                            Text(
                              'No Animals Added Yet'.tr,
                              style:
                                  AppFonts.title4(color: AppColors.grayscale90),
                            ),
                            Text(
                              'Sign In To Create A Farm & Add An Animal'.tr,
                              style: AppFonts.headline4(
                                  color: AppColors.grayscale70),
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier(context) * 24,
                            ),
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
                            SizedBox(
                                height:
                                    SizeConfig.heightMultiplier(context) * 8),
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
