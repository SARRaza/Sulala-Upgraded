import 'package:flutter/material.dart';

import 'package:sulala_app/src/data/globals.dart' as globals;

import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/inputs/search_bars/button_search_bar.dart';
import '../../widgets/lists/animal_list/animal_list_widget.dart';
import 'user_details.dart';

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

  @override
  void initState() {
    super.initState();
    filteredFarms = farms;
    // Initialize filteredOptions with all options
  }

  void filterOptions(String searchText) {
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

  void navigateToUserDetailsPage(Map<String, dynamic> option) {
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
                globals.widthMediaQuery * 16,
                globals.widthMediaQuery * 4,
                globals.widthMediaQuery * 16,
                globals.widthMediaQuery * 4,
              ),
              child: Text("House Farm",
                  style: AppFonts.title3(color: AppColors.grayscale90)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                globals.widthMediaQuery * 16,
                globals.widthMediaQuery * 4,
                globals.widthMediaQuery * 16,
                globals.widthMediaQuery * 4,
              ),
              child: ButtonSearchBar(
                onChange: filterOptions,
                hintText: "Search by name or ID",
                icon: Icons.filter_alt_outlined,
                controller: _searchController,
                onIconPressed: () {
                  // print("Filter Pressed");
                },
              ),
            ),
            SizedBox(height: globals.heightMediaQuery * 24),
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
                              SizedBox(height: globals.heightMediaQuery * 32),
                              Text(
                                "No farms found",
                                style: AppFonts.headline3(
                                    color: AppColors.grayscale90),
                              ),
                              SizedBox(height: globals.heightMediaQuery * 4),
                              Text(
                                "Try adjusting the filters",
                                style: AppFonts.body2(
                                    color: AppColors.grayscale70),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.all(globals.widthMediaQuery * 10),
                        child: AnimalListWidget(
                          avatarRadius: globals.widthMediaQuery * 24,
                          imagePath: option['imagePath'],
                          textHead: option['title'],
                          textBody: option['subtitle'],
                          onPressed: () {
                            navigateToUserDetailsPage(option);
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
                      SizedBox(height: globals.heightMediaQuery * 32),
                      Text(
                        "No farms found",
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      ),
                      SizedBox(height: globals.heightMediaQuery * 4),
                      Text(
                        "Try adjusting the filters",
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
}
