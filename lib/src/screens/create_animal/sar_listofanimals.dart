import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/animal_filters.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import 'package:sulala_upgrade/src/screens/create_animal/sar_animalfilters.dart';
import 'package:sulala_upgrade/src/widgets/pages/main_widgets/navigation_bar_reg_mode.dart';
import '../../data/classes.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/search_bars/button_search_bar.dart';

import 'create_animal.dart';

import 'owned_animal_detail_reg_mode.dart';

// ignore: must_be_immutable
class UserListOfAnimals extends ConsumerStatefulWidget {
  final bool shouldAddAnimal;
  final List<BreedingEventVariables> breedingEvents;

  const UserListOfAnimals(
      {super.key, required this.shouldAddAnimal, required this.breedingEvents});

  @override
  ConsumerState<UserListOfAnimals> createState() => _UserListOfAnimals();
}

class _UserListOfAnimals extends ConsumerState<UserListOfAnimals> {
  String filterQuery = '';
  final TextEditingController searchController = TextEditingController();
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

    // Add the initial breeding event to the list only if shouldAddAnimal is true
    if (widget.shouldAddAnimal) {
      addOviAnimal(
        ref.read(animalNameProvider),
        ref.read(breedingEventNumberProvider),
      );
    }
  }

  void addOviAnimal(String animalName, String breedingeventNumber) {
    final breedingDetails = BreedingDetails(
      breedsire: ref.read(breedingSireDetailsProvider),
      breeddam: ref.read(breedingDamDetailsProvider),
      breedpartner: ref.read(breedingPartnerProvider),
      breedchildren: ref.read(breedingChildrenDetailsProvider),
      breedingDate: ref.read(breedingDateProvider),
      breeddeliveryDate: ref.read(deliveryDateProvider),
      breedingnotes: ref.read(breedingnotesProvider),
      shouldAddEvent: ref.read(shoudlAddEventProvider),
    );
    // ignore: non_constant_identifier_names
    final OviDetails = OviVariables(
      animalName: animalName,
      breedingeventNumber: breedingeventNumber,
      breedingDetails: breedingDetails,
      medicalNeeds: ref.read(medicalNeedsProvider),
      shouldAddAnimal: ref.read(shoudlAddAnimalProvider),
      selectedBreedingStage: ref.read(selectedBreedingStageProvider),
      layingFrequency: ref.read(layingFrequencyProvider),
      eggsPerMonth: ref.read(eggsPerMonthProvider),
      selectedOviSire: ref.read(animalSireDetailsProvider),
      selectedOviDam: ref.read(animalDamDetailsProvider),
      dateOfBirth: ref.read(dateOfBirthProvider),
      keptInOval: ref.read(keptInOvalProvider),
      dateOfLayingEggs: ref.read(dateOfLayingEggsProvider),
      numOfEggs: ref.read(numOfEggsProvider),
      dateOfSonar: ref.read(dateOfSonarProvider),
      expDlvDate: ref.read(expDeliveryDateProvider),
      fieldName: ref.read(fieldNameProvider),
      incubationDate: ref.read(incubationDateProvider),
      fieldContent: ref.read(fieldContentProvider),
      notes: ref.read(additionalnotesProvider),
      selectedOviGender: ref.read(selectedOviGenderProvider),
      selectedOviDates: ref.read(selectedOviDatesProvider),
      selectedAnimalBreed: ref.read(selectedAnimalBreedsProvider),
      selectedAnimalSpecies: ref.read(selectedAnimalSpeciesProvider),
      selectedAnimalType: ref.read(selectedAnimalTypeProvider),
      selectedOviChips: ref.read(selectedOviChipsProvider),
      selectedOviImage: ref.read(selectedAnimalImageProvider),
      selectedFilters: ref.read(selectedFiltersProvider),
      breedsire: ref.read(breedingSireDetailsProvider),
      breeddam: ref.read(breedingDamDetailsProvider),
      breedpartner: ref.read(breedingPartnerProvider),
      breedchildren: ref.read(breedingChildrenDetailsProvider),
      breedingDate: ref.read(breedingDateProvider),
      breeddeliveryDate: ref.read(deliveryDateProvider),
      breedingnotes: ref.read(breedingnotesProvider),
      shouldAddEvent: ref.read(shoudlAddEventProvider),
      breedingEvents: {animalName: []},
      vaccineDetails: {animalName: []},
      checkUpDetails: {animalName: []},
      surgeryDetails: {animalName: []},
    );

    final ovianimals = ref.read(ovianimalsProvider);
    final breedingChildrenDetails = ref.read(breedingChildrenDetailsProvider);
    for (var child in breedingChildrenDetails) {
      final childIndex =
          ovianimals.indexWhere((animal) => animal.id == child.id);

      ref.read(ovianimalsProvider.notifier).update((state) {
        if(OviDetails.selectedOviGender == 'Male') {
          state[childIndex].selectedOviSire = [
            MainAnimalSire(OviDetails.animalName, OviDetails.selectedOviImage,
                OviDetails.selectedOviGender)
          ];
        } else {
          state[childIndex].selectedOviDam = [
            MainAnimalDam(OviDetails.animalName, OviDetails.selectedOviImage,
                OviDetails.selectedOviGender)
          ];
        }
        return state;
      });
    }
    ref.read(breedingChildrenDetailsProvider.notifier).update((state) => []);

    setState(() {
      if (ref.read(ovianimalsProvider).isEmpty) {
        ref.read(ovianimalsProvider).add(OviDetails);
      } else {
        ref.read(ovianimalsProvider).insert(0, OviDetails);
      }
      // ignore: unused_result
      ref.refresh(mammalCountProvider);
      // ignore: unused_result
      ref.refresh(oviparousCountProvider);
    });
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
    // Filter the OviAnimals list based on the filterQuery
    final filteredOviAnimals = ref.read(ovianimalsProvider).where((animal) {
      final filters = ref.read(selectedFiltersProvider);
      final animalType = filters.firstWhereOrNull(
          (filter) => filterItems['Animal Type']!.contains(filter));
      final animalSpecies = filters.firstWhereOrNull(
          (filter) => filterItems['Animal Species']!.contains(filter));
      final animalBreed = filters.firstWhereOrNull(
          (filter) => filterItems['Animal Breed']!.contains(filter));
      final animalSex = filters.firstWhereOrNull(
          (filter) => filterItems['Animal Sex']!.contains(filter));
      final breedingStage = filters.firstWhereOrNull(
          (filter) => filterItems['Breeding Stage']!.contains(filter));
      final tags = filters
          .firstWhereOrNull((filter) => filterItems['Tags']!.contains(filter));

      return (animalType == null || animal.selectedAnimalType == animalType) &&
          (animalSpecies == null ||
              animal.selectedAnimalSpecies == animalSpecies) &&
          (animalBreed == null || animal.selectedAnimalBreed == animalBreed) &&
          (animalSex == null || animal.selectedOviGender == animalSex) &&
          (breedingStage == null ||
              animal.selectedBreedingStage == breedingStage) &&
          (tags == null || animal.selectedOviChips.contains(tags));
    }).toList();
    return RefreshIndicator(
      onRefresh: _refreshOviAnimals,
      color: AppColors.primary40,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0.0,
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: EdgeInsets.only(left: globals.widthMediaQuery * 16),
              child: Text(
                'Animals'.tr,
                style: AppFonts.title3(color: AppColors.grayscale90),
              ),
            ),
            leadingWidth: globals.widthMediaQuery * 56,
            leading: Padding(
                padding: EdgeInsets.only(left: globals.widthMediaQuery * 16),
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.grayscale10, shape: BoxShape.circle),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.black,
                      size: globals.widthMediaQuery * 24,
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
                padding: EdgeInsets.only(right: globals.widthMediaQuery * 16),
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
                      builder: (context) => CreateAnimalPage(
                        breedingEvents: widget.breedingEvents,
                      ),
                    ),
                  ).then((_) {
                    // When returning from CreateBreedingEvents, add the new event
                    if (ref.read(animalNameProvider).isNotEmpty) {
                      addOviAnimal(
                        ref.read(animalNameProvider),
                        ref.read(breedingEventNumberProvider),
                      );
                    }
                  });
                }, // Call the addAnimal function when the button is pressed
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: globals.widthMediaQuery * 16,
                  right: globals.widthMediaQuery * 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.029,
                  ),
                  ButtonSearchBar(
                    onChange: _filterMammals,
                    hintText: "Search by name or ID".tr,
                    icon: Icons.filter_alt_outlined,
                    // controller: _searchController,
                    onIconPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SarAnimalFilters(
                                  breedingEvents: widget.breedingEvents,
                                )),
                      );
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: globals.heightMediaQuery * 20,
                  ),
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
                  filteredOviAnimals.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: filteredOviAnimals.length,
                          itemBuilder: (context, index) {
                            // ignore: non_constant_identifier_names
                            final OviDetails = filteredOviAnimals[index];
                            return Dismissible(
                                key:
                                    UniqueKey(), // Provide a unique key for each item
                                direction: DismissDirection
                                    .endToStart, // Enable swipe from right to left
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 20),
                                  color: Colors
                                      .red, // Background color for delete action
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                onDismissed: (direction) {
                                  // Handle item dismissal here
                                  setState(() {
                                    final removedAnimal =
                                        filteredOviAnimals.removeAt(index);
                                    ref
                                        .read(ovianimalsProvider)
                                        .remove(removedAnimal);
                                    // You may want to update your data source (e.g., ovianimalsProvider) here too
                                  });
                                },
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         EnlargedAnimalImageScreen(
                                      //       image: OviDetails.selectedOviImage,
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                    child: CircleAvatar(
                                      radius: globals.widthMediaQuery * 24,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          OviDetails.selectedOviImage != null
                                              ? FileImage(
                                                  OviDetails.selectedOviImage!)
                                              : null,
                                      child: OviDetails.selectedOviImage == null
                                          ? const Icon(
                                              Icons.camera_alt_outlined,
                                              size: 50,
                                              color: Colors.grey,
                                            )
                                          : null,
                                    ),
                                  ),
                                  title: Text(OviDetails.animalName),
                                  subtitle: Text(OviDetails.selectedAnimalType),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OwnedAnimalDetailsRegMode(
                                          OviDetails: OviDetails,
                                          imagePath: '',
                                          title: '',
                                          geninfo: '',
                                          breedingEvents: widget.breedingEvents,
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
                                      MediaQuery.of(context).size.height * 0.04,
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
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                SizedBox(
                                  height: 52 * globals.heightMediaQuery,
                                  child: PrimaryButton(
                                    onPressed: () {
                                      ref
                                          .read(selectedAnimalTypeProvider
                                              .notifier)
                                          .update((state) => '');
                                      ref
                                          .read(selectedAnimalSpeciesProvider
                                              .notifier)
                                          .update((state) => '');
                                      ref
                                          .read(selectedAnimalBreedsProvider
                                              .notifier)
                                          .update((state) => '');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CreateAnimalPage(
                                            breedingEvents:
                                                widget.breedingEvents,
                                          ),
                                        ),
                                      ).then((_) {
                                        // When returning from CreateBreedingEvents, add the new event
                                        if (ref
                                            .read(animalNameProvider)
                                            .isNotEmpty) {
                                          addOviAnimal(
                                            ref.read(animalNameProvider),
                                            ref.read(
                                                breedingEventNumberProvider),
                                          );
                                        }
                                      });
                                    }, // Call the addAnimal function when the button is pressed
                                    text: 'Add Animal'.tr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
