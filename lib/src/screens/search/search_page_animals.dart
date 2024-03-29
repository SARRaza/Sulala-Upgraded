import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sulala_upgrade/src/data/globals.dart';

import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/inputs/search_bars/button_search_bar.dart';
import '../../widgets/lists/animal_list/animal_list_widget.dart';
import '../guest_mode/animal_details.dart';

class SearchPageAnimals extends StatefulWidget {
  const SearchPageAnimals({super.key});

  @override
  State<SearchPageAnimals> createState() => _SearchPageAnimalsState();
}

class _SearchPageAnimalsState extends State<SearchPageAnimals> {
  List<Map<String, dynamic>> animals = [
    {
      'type': 'Mammal',
      'diet': 'Herbivore',
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Horse',
      'genInfo':
          'The horse is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'type': 'Mammal',
      'diet': 'Herbivore',
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Cow',
      'genInfo':
          'The cow is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'type': 'Mammal',
      'diet': 'Herbivore',
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Ox',
      'genInfo':
          'The ox is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'type': 'Mammal',
      'diet': 'Herbivore',
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Sheep',
      'genInfo':
          'The sheep is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'type': 'Mammal',
      'diet': 'Herbivore',
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'genInfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'type': 'Mammal',
      'diet': 'Herbivore',
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'genInfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'type': 'Mammal',
      'diet': 'Herbivore',
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'genInfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'type': 'Mammal',
      'diet': 'Herbivore',
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'genInfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'type': 'Mammal',
      'diet': 'Herbivore',
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
    filteredAnimals = animals;
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
      filteredAnimals = animals
          .where(
            (option) => option['title']
                .toLowerCase()
                .contains(searchText.toLowerCase()),
          )
          .toList();
    });
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
          animalDiet: option['diet'],
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
              child: Text("Animals".tr,
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
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 24,
            ),
            if (filteredAnimals.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredAnimals.length, //change it later please
                  itemBuilder: (context, index) {
                    final option = filteredAnimals[index];
                    if (filteredOptions.isNotEmpty) {
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                  image: AssetImage(
                                      'assets/illustrations/cow_search.png')),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier(context) *
                                      33),
                              Text(
                                "No animals found".tr,
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
                          textBody: option['genInfo'],
                          onPressed: () {
                            _navigateToAnimalDetailsPage(option);
                          },
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
            if (filteredAnimals.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                          image: AssetImage(
                              'assets/illustrations/cow_search.png')),
                      SizedBox(
                          height: SizeConfig.heightMultiplier(context) * 32),
                      Text(
                        "No animals found".tr,
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
