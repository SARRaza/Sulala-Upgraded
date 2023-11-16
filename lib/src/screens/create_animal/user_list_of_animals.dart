import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/search_bars/button_search_bar.dart';
import 'animal_filters.dart';
import 'create_animal.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

import 'owned_animal_detail_reg_mode.dart';

class UserListOfAnimals extends StatefulWidget {
  final List<String> selectedFilters;

  const UserListOfAnimals({super.key, required this.selectedFilters});

  @override
  State<UserListOfAnimals> createState() => _UserListOfAnimalsState();
}

class _UserListOfAnimalsState extends State<UserListOfAnimals> {
  final List<Map<String, dynamic>> mammals = [
    {
      'name': 'Kenneth',
      'image': 'assets/avatars/120px/Cat.png',
      'subtitle': 'Oviparous',
    },
    {
      'name': 'Beverly',
      'image': 'assets/avatars/120px/Dog.png',
      'subtitle': 'Mammal',
    },
    {
      'name': 'John',
      'image': 'assets/avatars/120px/Sheep.png',
      'subtitle': 'Mammal',
    },
    {
      'name': 'Patrick',
      'image': 'assets/avatars/120px/Horse.png',
      'subtitle': 'Oviparous',
    },
    {
      'name': 'Brian',
      'image': 'assets/avatars/120px/Duck.png',
      'subtitle': 'Mammal',
    },
    {
      'name': 'Joyce',
      'image': 'assets/avatars/120px/Cat.png',
      'subtitle': 'Mammal',
    },
    {
      'name': 'Billy',
      'image': 'assets/avatars/120px/Sheep.png',
      'subtitle': 'Mammal',
    },
    {
      'name': 'Billy',
      'image': 'assets/avatars/120px/Sheep.png',
      'subtitle': 'Mammal',
    },
  ];

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Animals',
                style: AppFonts.title3(color: AppColors.grayscale90),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                icon: Container(
                  width: globals.widthMediaQuery * 37.5,
                  height: globals.widthMediaQuery * 37.5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary50,
                  ),
                  child: const Icon(Icons.add),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateAnimalPage()),
                  );
                },
              ),
            ],
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
                ButtonSearchBar(
                  onChange: _filterMammals,
                  hintText: "Search by name or ID",
                  icon: Icons.filter_alt_outlined,
                  // controller: _searchController,
                  onIconPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AnimalFilters()),
                    );
                  },
                ),
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
                              'No Animals Added',
                              style: AppFonts.headline3(
                                  color: AppColors.grayscale90),
                            ),
                            Text(
                              'Add an animal to get started',
                              style:
                                  AppFonts.body2(color: AppColors.grayscale70),
                            ),
                            SizedBox(
                              height: globals.heightMediaQuery * 24,
                            ),
                            SizedBox(
                              width: globals.widthMediaQuery * 168.75,
                              height: globals.heightMediaQuery * 40,
                              child: PrimaryButton(
                                  text: 'Add',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateAnimalPage()),
                                    );
                                  }),
                            )
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
