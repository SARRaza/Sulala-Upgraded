import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/data/place_holders.dart';
import 'package:sulala_upgrade/src/screens/guest_mode/animal_details.dart';
import '../../data/animal_filters.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/inputs/search_bars/button_search_bar.dart';
import '../../widgets/lists/animal_list/animal_list_widget.dart';
import '../create_animal/sar_animal_filters.dart';

class SearchPageOwnerAnimals extends ConsumerStatefulWidget {
  const SearchPageOwnerAnimals({super.key});

  @override
  ConsumerState<SearchPageOwnerAnimals> createState() =>
      _SearchPageOwnerAnimalsState();
}

class _SearchPageOwnerAnimalsState
    extends ConsumerState<SearchPageOwnerAnimals> {
  List<Map<String, dynamic>> animals = [
    {
      'imagePath': speciesImages['Horse']!,
      'title': 'Horse',
      'type': 'mammal',
      'species': 'horse',
      'sex': 'female',
      'breeding_stage': 'lactating',
      'tags': 'donated',
      'diet': 'Herbivore',
      'genInfo':
          'The horse is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': speciesImages['Cow']!,
      'title': 'Cow',
      'type': 'mammal',
      'species': 'cow',
      'sex': 'male',
      'breeding_stage': 'ready for breeding',
      'tags': 'adopted',
      'diet': 'Herbivore',
      'genInfo':
          'The cow is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': speciesImages['Ox']!,
      'title': 'Ox',
      'type': 'mammal',
      'species': 'cow',
      'sex': 'male',
      'breeding_stage': 'ready for breeding',
      'tags': 'borrowed',
      'diet': 'Herbivore',
      'genInfo':
          'The ox is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': speciesImages['Sheep']!,
      'title': 'Sheep',
      'type': 'mammal',
      'species': 'sheep',
      'sex': 'female',
      'breeding_stage': 'lactating',
      'tags': 'borrowed',
      'diet': 'Herbivore',
      'genInfo':
          'The sheep is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': speciesImages['Bull']!,
      'title': 'Bull',
      'type': 'mammal',
      'species': 'cow',
      'sex': 'male',
      'breeding_stage': 'ready for breeding',
      'tags': 'borrowed',
      'diet': 'Herbivore',
      'genInfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': speciesImages['Bull']!,
      'title': 'Bull',
      'type': 'mammal',
      'species': 'cow',
      'sex': 'male',
      'breeding_stage': 'ready for breeding',
      'tags': 'borrowed',
      'diet': 'Herbivore',
      'genInfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': speciesImages['Bull']!,
      'title': 'Bull',
      'type': 'mammal',
      'species': 'cow',
      'sex': 'male',
      'breeding_stage': 'ready for breeding',
      'tags': 'borrowed',
      'diet': 'Herbivore',
      'genInfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': speciesImages['Bull']!,
      'title': 'Bull',
      'type': 'mammal',
      'species': 'cow',
      'sex': 'male',
      'breeding_stage': 'ready for breeding',
      'tags': 'borrowed',
      'diet': 'Herbivore',
      'genInfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': speciesImages['Bull']!,
      'title': 'Bull',
      'type': 'mammal',
      'species': 'cow',
      'sex': 'male',
      'breeding_stage': 'ready for breeding',
      'tags': 'borrowed',
      'diet': 'Herbivore',
      'genInfo':
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
        body: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.widthMultiplier(context) * 16,
            right: SizeConfig.widthMultiplier(context) * 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Animals".tr,
                  style: AppFonts.title3(color: AppColors.grayscale90)),
              ButtonSearchBar(
                onChange: filterOptions,
                hintText: "Search by name or ID".tr,
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
                  _applyFilters();
                },
              ),
              SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
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
                      labelStyle: AppFonts.body2(color: AppColors.grayscale90),
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
                                SizedBox(
                                    height:
                                        SizeConfig.heightMultiplier(context) *
                                            32),
                                Text(
                                  "No animals found".tr,
                                  style: AppFonts.headline3(
                                      color: AppColors.grayscale90),
                                ),
                                SizedBox(
                                    height:
                                        SizeConfig.heightMultiplier(context) *
                                            4),
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
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.widthMultiplier(context) * 32),
                          child: AnimalListWidget(
                            avatarRadius:
                                SizeConfig.widthMultiplier(context) * 24,
                            imagePath: option['imagePath'],
                            textHead: option['title'],
                            textBody: option['genInfo'],
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
                        SizedBox(
                            height: SizeConfig.heightMultiplier(context) * 32),
                        Text(
                          "No animals found".tr,
                          style:
                              AppFonts.headline3(color: AppColors.grayscale90),
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
      ),
    );
  }

  void _applyFilters() {
    final selectedFilters = ref.read(selectedFiltersProvider);
    test(element) => selectedFilters.contains(element);
    final type =
        AnimalFilters.filterItems['Animal Type']!.firstWhereOrNull(test);
    final species =
        AnimalFilters.filterItems['Animal Species']!.firstWhereOrNull(test);
    final breed =
        AnimalFilters.filterItems['Animal Breed']!.firstWhereOrNull(test);
    final sex = AnimalFilters.filterItems['Animal Sex']!.firstWhereOrNull(test);
    final breedingStage =
        AnimalFilters.filterItems['Breeding Stage']!.firstWhereOrNull(test);
    final tags = AnimalFilters.filterItems['Tags']!.firstWhereOrNull(test);
    filteredAnimals = animals;

    setState(() {
      filteredAnimals = filteredAnimals
          .where((animal) =>
              (type == null || animal['type'] == type.toLowerCase()) &&
              (species == null || animal['species'] == species.toLowerCase()) &&
              (breed == null || animal['breed'] == breed.toLowerCase()) &&
              (sex == null || animal['sex'] == sex.toLowerCase()) &&
              (breedingStage == null ||
                  animal['breeding_stage'] == breedingStage.toLowerCase()) &&
              (tags == null || animal['tags'] == tags.toLowerCase()))
          .toList();

      if (_searchController.text.isNotEmpty) {
        filteredAnimals = filteredAnimals
            .where(
              (option) => option['title']
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()),
            )
            .toList();
      }
    });
  }

  void _removeSelectedFilter(String filter) {
    ref.read(selectedFiltersProvider).remove(filter);
    _applyFilters();
  }
}
