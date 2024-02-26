import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/animal_filters.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/screens/create_animal/sar_animal_filters.dart';
import 'package:sulala_upgrade/src/widgets/pages/main_widgets/navigation_bar_reg_mode.dart';
import 'package:sulala_upgrade/src/widgets/styled_dismissible.dart';
import '../../data/providers/animal_providers.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/search_bars/button_search_bar.dart';

import 'create_animal.dart';

import 'owned_animal_detail_reg_mode.dart';

class UserListOfAnimals extends ConsumerStatefulWidget {
  const UserListOfAnimals({super.key});

  @override
  ConsumerState<UserListOfAnimals> createState() => _UserListOfAnimals();
}

class _UserListOfAnimals extends ConsumerState<UserListOfAnimals> {
  String filterQuery = '';
  Timer? _debounce;

  Future<void> _refreshOviAnimals() async {
    // Add your logic to refresh the list here
    // For example, you can fetch new data or update existing data
    await Future.delayed(const Duration(seconds: 2)); // Simulating a delay

    // Call _updateFilteredOviAnimals to apply filters on the refreshed list
    _updateFilteredOviAnimals(query: filterQuery);
  }

  @override
  void initState() {
    super.initState();
    _updateFilteredOviAnimals();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _filterMammals(String query) {
    setState(() {
      filterQuery = query;
      _updateFilteredOviAnimals(query: query);
    });
  }

  void _updateFilteredOviAnimals({String? query}) {}

  void _removeSelectedFilter(String filter) {
    setState(() {
      ref.read(selectedFiltersProvider).remove(filter);
      _updateFilteredOviAnimals(); // Update the filtered list after removing a filter
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Padding(
            padding:
                EdgeInsets.only(left: SizeConfig.widthMultiplier(context) * 16),
            child: Text(
              'Animals'.tr,
              style: AppFonts.title3(color: AppColors.grayscale90),
            ),
          ),
          leadingWidth: SizeConfig.widthMultiplier(context) * 56,
          leading: Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.widthMultiplier(context) * 16),
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColors.grayscale10, shape: BoxShape.circle),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                    size: SizeConfig.widthMultiplier(context) * 24,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NavigationBarRegMode(),
                      ),
                    );
                  }, // Call the addAnimal function when the button is pressed
                ),
              )),
          actions: [
            IconButton(
              padding: EdgeInsets.only(
                  right: SizeConfig.widthMultiplier(context) * 16),
              icon: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary50,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
              onPressed: () {
                ref
                    .read(selectedAnimalTypeProvider.notifier)
                    .update((state) => '');
                ref
                    .read(selectedAnimalSpeciesProvider.notifier)
                    .update((state) => '');
                ref
                    .read(selectedAnimalBreedsProvider.notifier)
                    .update((state) => '');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateAnimalPage(),
                  ),
                );
              }, // Call the addAnimal function when the button is pressed
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refreshOviAnimals,
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          color: AppColors.primary40,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.widthMultiplier(context) * 16,
                  right: SizeConfig.widthMultiplier(context) * 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.029,
                  ),
                  ButtonSearchBar(
                    onChange: _onSearchChanged,
                    hintText: "Search by name or ID".tr,
                    showFilterIcon: true,
                    // controller: _searchController,
                    onIconPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SarAnimalFilters()),
                      );
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier(context) * 20,
                  ),
                  Visibility(
                    visible: ref.watch(selectedFiltersProvider).isNotEmpty,
                    child: Wrap(
                      spacing: MediaQuery.of(context).size.width * 0.02,
                      children: ref.watch(selectedFiltersProvider).map((filter) {
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
                  ref.watch(animalListProvider).when(
                      data: (animals) {
                        final filteredOviAnimals = animals.where((animal) {
                          final filters = ref.watch(selectedFiltersProvider);
                          final animalType = filters.firstWhereOrNull(
                              (filter) => AnimalFilters
                                  .filterItems['Animal Type']!
                                  .contains(filter));
                          final animalSpecies = filters.firstWhereOrNull(
                              (filter) => AnimalFilters
                                  .filterItems['Animal Species']!
                                  .contains(filter));
                          final animalBreed = filters.firstWhereOrNull(
                              (filter) => AnimalFilters
                                  .filterItems['Animal Breed']!
                                  .contains(filter));
                          final animalSex = filters.firstWhereOrNull((filter) =>
                              AnimalFilters.filterItems['Animal Sex']!
                                  .contains(filter));
                          final breedingStage = filters.firstWhereOrNull(
                              (filter) => AnimalFilters
                                  .filterItems['Breeding Stage']!
                                  .contains(filter));
                          final tags = filters.firstWhereOrNull((filter) =>
                              AnimalFilters.filterItems['Tags']!
                                  .contains(filter));

                          return (animalType == null ||
                                  animal.selectedAnimalType == animalType) &&
                              (animalSpecies == null ||
                                  animal.selectedAnimalSpecies ==
                                      animalSpecies) &&
                              (animalBreed == null ||
                                  animal.selectedAnimalBreed == animalBreed) &&
                              (animalSex == null ||
                                  animal.selectedOviGender == animalSex) &&
                              (breedingStage == null ||
                                  animal.selectedBreedingStage ==
                                      breedingStage) &&
                              (tags == null ||
                                  animal.selectedOviChips.contains(tags)) &&
                              (filterQuery.isEmpty ||
                                  animal.animalName
                                      .toLowerCase()
                                      .contains(filterQuery.toLowerCase()));
                        }).toList();

                        return filteredOviAnimals.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: filteredOviAnimals.length,
                                itemBuilder: (context, index) {
                                  final oviDetails = filteredOviAnimals[index];
                                  return StyledDismissible(
                                      onDismissed: (direction) {
                                        // Handle item dismissal here
                                        ref
                                            .read(animalListProvider.notifier)
                                            .removeAnimal(oviDetails.id!);
                                      },
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: GestureDetector(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            radius: SizeConfig.widthMultiplier(
                                                    context) *
                                                24,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage:
                                                oviDetails.selectedOviImage,
                                            child: oviDetails
                                                        .selectedOviImage ==
                                                    null
                                                ? const Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: 50,
                                                    color: Colors.grey,
                                                  )
                                                : null,
                                          ),
                                        ),
                                        title: Text(oviDetails.animalName),
                                        subtitle:
                                            Text(oviDetails.selectedAnimalType),
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OwnedAnimalDetailsRegMode(
                                                animalId: oviDetails.id!,
                                              ),
                                            ),
                                          );
                                        },
                                      ));
                                },
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
                                            MediaQuery.of(context).size.height *
                                                0.04,
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
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),
                                      SizedBox(
                                        height: 52 *
                                            SizeConfig.heightMultiplier(
                                                context),
                                        child: PrimaryButton(
                                          onPressed: () {
                                            ref
                                                .read(selectedAnimalTypeProvider
                                                    .notifier)
                                                .update((state) => '');
                                            ref
                                                .read(
                                                    selectedAnimalSpeciesProvider
                                                        .notifier)
                                                .update((state) => '');
                                            ref
                                                .read(
                                                    selectedAnimalBreedsProvider
                                                        .notifier)
                                                .update((state) => '');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const CreateAnimalPage(),
                                              ),
                                            );
                                          }, // Call the addAnimal function when the button is pressed
                                          text: 'Add Animal'.tr,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => const CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Implement your search logic here
      _filterMammals(query);
    });
  }
}
