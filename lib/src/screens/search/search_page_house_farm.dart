import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sulala_upgrade/src/data/globals.dart';

import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/inputs/search_bars/button_search_bar.dart';
import '../../widgets/lists/animal_list/animal_list_widget.dart';
import '../guest_mode/user_details.dart';

class SearchPageHouseFarm extends StatefulWidget {
  const SearchPageHouseFarm({super.key});

  @override
  State<SearchPageHouseFarm> createState() => _SearchPageHouseFarmState();
}

class _SearchPageHouseFarmState extends State<SearchPageHouseFarm> {
  List<Map<String, dynamic>> farms = [
    {
      'imagePath': 'assets/avatars/120px/Staff1.png',
      'title': 'Paul Rivera',
      'subtitle': 'Viewer',
      'email': 'paul@example.com',
      'phoneNumber': '+1 234 567 890',
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Rebecca Wilson',
      'subtitle': 'Helper',
      'email': 'paul@example.com',
      'phoneNumber': '+1 234 567 890',
    },
    {
      'imagePath': 'assets/avatars/120px/Staff1.png',
      'title': 'Patricia Williams',
      'subtitle': 'Helper',
      'email': 'paul@example.com',
      'phoneNumber': '+1 234 567 890',
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Scott Simmons',
      'subtitle': 'Worker',
      'email': 'paul@example.com',
      'phoneNumber': '+1 234 567 890',
    },
    {
      'imagePath': 'assets/avatars/120px/Staff1.png',
      'title': 'Lee Hall',
      'subtitle': 'Worker',
      'email': 'paul@example.com',
      'phoneNumber': '+1 234 567 890',
    },
    // Your data here
  ];

  List<Map<String, dynamic>> filteredOptions = [];
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredFarms = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    filteredFarms = farms;
    // Initialize filteredOptions with all options
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _filterOptions(String searchText) {
    setState(() {
      filteredFarms = farms
          .where(
            (option) => option['title']
                .toLowerCase()
                .contains(searchText.toLowerCase()),
          )
          .toList();
    });
  }

  void _navigateToUserDetailsPage(Map<String, dynamic> option) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetails(
          imagePath: option['imagePath'],
          title: option['title'],
          subtitle: option['subtitle'],
          email: option['email'],
          phoneNumber: option['phoneNumber'],
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            color: AppColors.grayscale90,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                SizeConfig.widthMultiplier(context) * 16,
                SizeConfig.widthMultiplier(context) * 4,
                SizeConfig.widthMultiplier(context) * 16,
                SizeConfig.widthMultiplier(context) * 4,
              ),
              child: Text("House Farm".tr,
                  style: AppFonts.title3(color: AppColors.grayscale90)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                SizeConfig.widthMultiplier(context) * 16,
                SizeConfig.widthMultiplier(context) * 4,
                SizeConfig.widthMultiplier(context) * 16,
                SizeConfig.widthMultiplier(context) * 4,
              ),
              child: ButtonSearchBar(
                onChange: _onSearchChanged,
                hintText: "Search by name or ID".tr,
                showFilterIcon: false,
                controller: _searchController,
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
            if (filteredFarms.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredFarms.length, //change it later please
                  itemBuilder: (context, index) {
                    final option = filteredFarms[index];
                    if (filteredOptions.isNotEmpty) {
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                  image: AssetImage(
                                      'assets/illustrations/home_search.png')),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier(context) *
                                      32),
                              Text(
                                "No farms found".tr,
                                style: AppFonts.headline3(
                                    color: AppColors.grayscale90),
                              ),
                              SizedBox(
                                  height:
                                      SizeConfig.heightMultiplier(context) * 4),
                              Text(
                                "Try adjusting the filters".tr,
                                style: AppFonts.body2(
                                    color: AppColors.grayscale70),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.all(
                            SizeConfig.widthMultiplier(context) * 10),
                        child: AnimalListWidget(
                          avatarRadius:
                              SizeConfig.widthMultiplier(context) * 24,
                          imagePath: option['imagePath'],
                          textHead: option['title'],
                          textBody: option['subtitle'],
                          onPressed: () {
                            _navigateToUserDetailsPage(option);
                          },
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
            if (filteredFarms.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                          image: AssetImage(
                              'assets/illustrations/home_search.png')),
                      SizedBox(
                          height: SizeConfig.heightMultiplier(context) * 32),
                      Text(
                        "No farms found".tr,
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      ),
                      SizedBox(
                          height: SizeConfig.heightMultiplier(context) * 4),
                      Text(
                        "Try adjusting the filters".tr,
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _filterOptions(query);
    });
  }
}
