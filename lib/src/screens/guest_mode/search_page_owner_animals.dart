import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../../data/animal_filters.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/inputs/search_bars/button_search_bar.dart';
import '../../widgets/lists/animal_list/animal_list_widget.dart';
import '../create_animal/sar_animalfilters.dart';

class SearchPageOwnerAnimals extends ConsumerStatefulWidget {
  const SearchPageOwnerAnimals({super.key});

  @override
  ConsumerState<SearchPageOwnerAnimals> createState() => _SearchPageOwnerAnimalsState();
}

class _SearchPageOwnerAnimalsState extends ConsumerState<SearchPageOwnerAnimals> {
  List<Map<String, dynamic>> animals = [
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Horse',
      'type': 'mammal',
      'species': 'horse',
      'sex': 'female',
      'breeding_stage': 'lactating',
      'tags': 'donated',
      'geninfo':
      'The horse is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Cow',
      'type': 'mammal',
      'species': 'cow',
      'sex': 'male',
      'breeding_stage': 'ready for breeding',
      'tags': 'adopted',
      'geninfo':
      'The cow is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Ox',
      'type': 'mammal',
      'species': 'cow',
      'sex': 'male',
      'breeding_stage': 'ready for breeding',
      'tags': 'borrowed',
      'geninfo':
      'The ox is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Sheep',
      'type': 'mammal',
      'species': 'sheep',
      'sex': 'female',
      'breeding_stage': 'lactating',
      'tags': 'borrowed',
      'geninfo':
      'The sheep is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'type': 'mammal',
      'species': 'cow',
      'sex': 'male',
      'breeding_stage': 'ready for breeding',
      'tags': 'borrowed',
      'geninfo':
      'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'type': 'mammal',
      'species': 'cow',
      'sex': 'male',
      'breeding_stage': 'ready for breeding',
      'tags': 'borrowed',
      'geninfo':
      'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'type': 'mammal',
      'species': 'cow',
      'sex': 'male',
      'breeding_stage': 'ready for breeding',
      'tags': 'borrowed',
      'geninfo':
      'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'type': 'mammal',
      'species': 'cow',
      'sex': 'male',
      'breeding_stage': 'ready for breeding',
      'tags': 'borrowed',
      'geninfo':
      'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'type': 'mammal',
      'species': 'cow',
      'sex': 'male',
      'breeding_stage': 'ready for breeding',
      'tags': 'borrowed',
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
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => OwnedAnimalDetails(
    //       imagePath: option['imagePath'],
    //       title: option['title'],
    //       geninfo: option['geninfo'],
    //     ),
    //   ),
    // );
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
        body: Padding(
          padding: EdgeInsets.only(
            left: globals.widthMediaQuery * 16,
            right: globals.widthMediaQuery * 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Animals",
                  style: AppFonts.title3(color: AppColors.grayscale90)),
              ButtonSearchBar(
                onChange: filterOptions,
                hintText: "Search by name or ID",
                icon: Icons.filter_alt_outlined,
                controller: _searchController,
                onIconPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SarAnimalFilters(
                          breedingEvents: [],
                        )),
                  );
                  applyFilters();
                },
              ),
              SizedBox(height: globals.heightMediaQuery * 24),
              Visibility(
                visible: ref.read(selectedFiltersProvider).isNotEmpty,
                child: Wrap(
                  spacing: MediaQuery.of(context).size.width * 0.02,
                  children: ref.read(selectedFiltersProvider).map((filter) {
                    return Chip(
                      deleteIcon: Icon(
                        Icons.close_rounded,
                        color: AppColors.grayscale90,
                        size: MediaQuery.of(context).size.width * 0.05,
                      ),
                      label: Text(filter),
                      labelStyle:
                      AppFonts.body2(color: AppColors.grayscale90),
                      backgroundColor: AppColors.grayscale10,
                      onDeleted: () {
                        _removeSelectedFilter(filter);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    );
                  }).toList(),
                ),
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
                                SizedBox(height: globals.heightMediaQuery * 32),
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
                          padding: EdgeInsets.only(
                              bottom: globals.widthMediaQuery * 32),
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
                          style:
                              AppFonts.headline3(color: AppColors.grayscale90),
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
      ),
    );
  }

  void applyFilters() {
    final selectedFilters = ref.read(selectedFiltersProvider);
    test(element) => selectedFilters.contains(element);
    final type = filterItems['Animal Type']!.firstWhereOrNull(test);
    final species = filterItems['Animal Species']!.firstWhereOrNull(test);
    final breed = filterItems['Animal Breed']!.firstWhereOrNull(test);
    final sex = filterItems['Animal Sex']!.firstWhereOrNull(test);
    final breedingStage = filterItems['Breeding Stage']!.firstWhereOrNull(test);
    final tags = filterItems['Tags']!.firstWhereOrNull(test);
    filteredAnimals = animals;
    if(_searchController.text.isNotEmpty) {
      filteredAnimals = animals
          .where(
            (option) => option['title']
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()),
      )
          .toList();
    }

    setState(() {
      filteredAnimals = filteredAnimals.where((animal) => (type == null ||
          animal['type'] == type.toLowerCase()) && (species == null ||
          animal['species'] ==
              species.toLowerCase()) && (breed == null || animal['breed'] == breed
          .toLowerCase()) && (sex == null ||
          animal['sex'] == sex.toLowerCase()) && (breedingStage == null ||
          animal['breeding_stage'] == breedingStage.toLowerCase()) && (tags ==
          null ||
          animal['tags'] == tags.toLowerCase())).toList();
    });
  }

  void _removeSelectedFilter(String filter) {
    ref.read(selectedFiltersProvider).remove(filter);
    applyFilters();
  }
}
