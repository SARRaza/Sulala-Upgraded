import 'package:flutter/material.dart';

import 'package:sulala_upgrade/src/data/globals.dart' as globals;

import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/inputs/search_bars/button_search_bar.dart';
import '../../widgets/lists/animal_list/animal_list_widget.dart';
import 'animal_details.dart';

class SearchPageAnimals extends StatefulWidget {
  const SearchPageAnimals({super.key});

  @override
  State<SearchPageAnimals> createState() => _SearchPageAnimalsState();
}

class _SearchPageAnimalsState extends State<SearchPageAnimals> {
  List<Map<String, dynamic>> animals = [
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Horse',
      'geninfo':
          'The horse is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Cow',
      'geninfo':
          'The cow is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Ox',
      'geninfo':
          'The ox is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Sheep',
      'geninfo':
          'The sheep is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'geninfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'geninfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'geninfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'geninfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'geninfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    // Add more data here if needed
  ];

  List<Map<String, dynamic>> filteredOptions = [];
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredAnimals = [];

  @override
  void initState() {
    super.initState();
    filteredAnimals = animals;
    // Initialize filteredOptions with all options
  }

  void filterOptions(String searchText) {
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

  void navigateToAnimalDetailsPage(Map<String, dynamic> option) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimalDetails(
          imagePath: option['imagePath'],
          title: option['title'],
          geninfo: option['geninfo'],
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
              child: Text("Animals",
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
            SizedBox(
              height: globals.heightMediaQuery * 24,
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
                              SizedBox(height: globals.heightMediaQuery * 33),
                              Text(
                                "No animals found",
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
                          textBody: option['geninfo'],
                          onPressed: () {
                            navigateToAnimalDetailsPage(option);
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
                      SizedBox(height: globals.heightMediaQuery * 32),
                      Text(
                        "No animals found",
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
