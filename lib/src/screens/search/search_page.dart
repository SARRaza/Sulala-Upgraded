import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/icon_buttons/secondary_icon_button.dart';
import '../../widgets/inputs/search_bars/search_bar.dart';
import '../../widgets/lists/animal_list/animal_list_widget.dart';
import '../../widgets/lists/staff_text/staff_list_widget.dart';
import '../guest_mode/animal_details.dart';
import '../guest_mode/user_details.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
  List<Map<String, dynamic>> animals = [
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Horse',
      'genInfo':
          'The horse is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Cow',
      'genInfo':
          'The cow is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Ox',
      'genInfo':
          'The ox is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Sheep',
      'genInfo':
          'The sheep is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'genInfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'genInfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'genInfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'genInfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'genInfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    // Add more data here if needed
  ];

  List<Map<String, dynamic>> filteredOptions = [];
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredAnimals = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    filteredOptions = farms;
    filteredAnimals = animals;
    // Initialize filteredOptions with all options
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _filterOptions(String searchText) {
    setState(() {
      filteredOptions = farms
          .where((option) =>
              option['title'].toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      filteredAnimals = animals
          .where((option) =>
              option['title'].toLowerCase().contains(searchText.toLowerCase()))
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

  void _navigateToAnimalDetailsPage(Map<String, dynamic> option) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimalDetails(
          imagePath: option['imagePath'],
          title: option['title'],
          genInfo: option['genInfo'],
          animalType: option['type'],
          animalDiet: option['animalDiet'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  SizeConfig.widthMultiplier(context) * 16,
                  SizeConfig.widthMultiplier(context) * 4,
                  SizeConfig.widthMultiplier(context) * 16,
                  SizeConfig.widthMultiplier(context) * 4,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: SizeConfig.heightMultiplier(context) * 40,
                        child: PrimarySearchBar(
                          onChange: _onSearchChanged,
                          hintText: "Search Staff".tr,
                          controller: _searchController,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier(context) * 4,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier(context) * 40,
                      child: SecondaryIconButton(
                        status: SecondaryIconButtonStatus.idle,
                        icon: Icons.clear,
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _filterOptions('');
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
              if (filteredOptions.isNotEmpty)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    SizeConfig.widthMultiplier(context) * 16,
                    SizeConfig.widthMultiplier(context) * 4,
                    SizeConfig.widthMultiplier(context) * 16,
                    SizeConfig.widthMultiplier(context) * 4,
                  ),
                  child: Text(
                    'Farms'.tr,
                    style: AppFonts.caption1(color: AppColors.grayscale80),
                  ),
                ),
              if (filteredOptions.isNotEmpty)
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredOptions.length,
                    itemBuilder: (context, index) {
                      final option = filteredOptions[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          top: SizeConfig.widthMultiplier(context) * 10,
                        ),
                        child: StaffListWidget(
                          imagePath: option['imagePath'],
                          textHead: option['title'],
                          textBody: option['subtitle'],
                          avatarRadius:
                              SizeConfig.widthMultiplier(context) * 24,
                          onPressed: () => _navigateToUserDetailsPage(option),
                        ),
                      );
                    }),
              SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
              if (filteredAnimals.isNotEmpty)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    SizeConfig.widthMultiplier(context) * 16,
                    SizeConfig.widthMultiplier(context) * 4,
                    SizeConfig.widthMultiplier(context) * 16,
                    SizeConfig.widthMultiplier(context) * 4,
                  ),
                  child: Text(
                    'Animals'.tr,
                    style: AppFonts.caption1(color: AppColors.grayscale80),
                  ),
                ),
              if (filteredAnimals.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          filteredAnimals.length, //change it later please
                      itemBuilder: (context, index) {
                        final option = filteredAnimals[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            top: SizeConfig.widthMultiplier(context) * 10,
                          ),
                          child: AnimalListWidget(
                            avatarRadius:
                                SizeConfig.widthMultiplier(context) * 24,
                            imagePath: option['imagePath'],
                            textHead: option['title'],
                            textBody: option['genInfo'],
                            onPressed: () {
                              _navigateToAnimalDetailsPage(option);
                            },
                          ),
                        );
                      }),
                ),
            ],
          ),
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
