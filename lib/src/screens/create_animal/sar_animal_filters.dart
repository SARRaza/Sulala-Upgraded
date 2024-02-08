import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import '../../data/animal_filters.dart';
import '../../data/classes/breeding_event_variables.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';

import '../../widgets/controls_and_buttons/tags/tags.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_text_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../reg_mode/reg_home_page.dart';
import '../reg_mode/show_filter_reg.dart';
import 'draw_up_animal_breed.dart';
import 'draw_up_animal_species.dart';

class SarAnimalFilters extends ConsumerStatefulWidget {
  final List<BreedingEventVariables> breedingEvents;

  const SarAnimalFilters({super.key, required this.breedingEvents});

  @override
  ConsumerState<SarAnimalFilters> createState() => _SarAnimalFilters();
}

class _SarAnimalFilters extends ConsumerState<SarAnimalFilters> {
  Map<String, String?> selectedAnimals = {};
  Map<String, List<String>> visibleFilterItems = {};
  List<Tag> currentStateTags = [
    Tag(name: 'Borrowed', status: TagStatus.notActive),
    Tag(name: 'Adopted', status: TagStatus.notActive),
    Tag(name: 'Donated', status: TagStatus.notActive),
    Tag(name: 'Escaped', status: TagStatus.notActive),
    Tag(name: 'Stolen', status: TagStatus.notActive),
    Tag(name: 'Transferred', status: TagStatus.notActive),
  ];
  List<Tag> medicalStateTags = [
    Tag(name: 'Injured', status: TagStatus.notActive),
    Tag(name: 'Sick', status: TagStatus.notActive),
    Tag(name: 'Quarantined', status: TagStatus.notActive),
    Tag(name: 'Medication', status: TagStatus.notActive),
    Tag(name: 'Testing', status: TagStatus.notActive),
  ];

  List<Tag> otherStateTags = [
    Tag(name: 'Sold', status: TagStatus.notActive),
    Tag(name: 'Dead', status: TagStatus.notActive),
  ];

  @override
  void initState() {
    super.initState();
    for (var heading in AnimalFilters.filterItems.keys) {
      selectedAnimals[heading] = null;
    }
    AnimalFilters.filterItems.forEach((heading, list) {
      visibleFilterItems[heading] = list.take(3).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Filter Animals'.tr,
          style: AppFonts.headline3(color: AppColors.grayscale90),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: SizeConfig.widthMultiplier(context) * 16,
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  selectedAnimals.clear();
                  for (var heading in visibleFilterItems.keys) {
                    selectedAnimals[heading] = null;
                  }
                  for (var i = 0; i < currentStateTags.length; i++) {
                    currentStateTags[i].status = TagStatus.notActive;
                  }
                  for (var i = 0; i < medicalStateTags.length; i++) {
                    medicalStateTags[i].status = TagStatus.notActive;
                  }
                  for (var i = 0; i < otherStateTags.length; i++) {
                    otherStateTags[i].status = TagStatus.notActive;
                  }
                });
              },
              icon: Container(
                  width: SizeConfig.widthMultiplier(context) * 37.5,
                  height: SizeConfig.widthMultiplier(context) * 37.5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grayscale10,
                  ),
                  child: const Icon(Icons.clear)),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          for (var sectionIndex = 0;
              sectionIndex < visibleFilterItems.length;
              sectionIndex++)
            _buildSection(sectionIndex),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: PrimaryButton(
          onPressed: () {
            List<String> selectedFiltersList = [];
            selectedAnimals.forEach((key, value) {
              if (value != null) {
                selectedFiltersList.add(value);
              }
            });
            for (var tag in currentStateTags) {
              if (tag.status == TagStatus.active) {
                selectedFiltersList.add(tag.name);
              }
            }
            for (var tag in medicalStateTags) {
              if (tag.status == TagStatus.active) {
                selectedFiltersList.add(tag.name);
              }
            }
            for (var tag in otherStateTags) {
              if (tag.status == TagStatus.active) {
                selectedFiltersList.add(tag.name);
              }
            }

            ref
                .read(selectedFiltersProvider.notifier)
                .update((state) => selectedFiltersList);

            Navigator.pop(context);
          },
          text: "Continue".tr,
        ),
      ),
    );
  }

  Widget _buildSection(int sectionIndex) {
    String sectionHeading = visibleFilterItems.keys.elementAt(sectionIndex);
    List<String> sectionLanguages = visibleFilterItems[sectionHeading]!;
    String? selectedLanguage = selectedAnimals[sectionHeading];

    bool showShowMoreButton =
        AnimalFilters.filterItems[sectionHeading]!.length >
            visibleFilterItems[sectionHeading]!.length;

    return Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.widthMultiplier(context) * 16,
            right: SizeConfig.widthMultiplier(context) * 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sectionHeading.tr,
              style: AppFonts.headline3(color: AppColors.grayscale90),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (var index = 0;
                    index <
                        (showShowMoreButton
                            ? sectionLanguages.length + 1
                            : sectionLanguages.length);
                    index++)
                  if (showShowMoreButton && index == sectionLanguages.length)
                    PrimaryTextButton(
                      text: 'Show more'.tr,
                      onPressed: () {
                        switch (sectionHeading) {
                          case 'Animal Species':
                            var speciesList = AnimalFilters
                                .filterItems[sectionHeading]!
                                .where((item) =>
                                    !visibleFilterItems[sectionHeading]!
                                        .contains(item))
                                .toList();
                            final animalType = selectedAnimals['Animal Type'];
                            if (animalType == 'Mammal') {
                              speciesList = speciesList
                                  .where((element) =>
                                      mammalSpeciesList.contains(element))
                                  .toList();
                            } else if (animalType == 'Oviparous') {
                              speciesList = speciesList
                                  .where((element) =>
                                      oviparousSpeciesList.contains(element))
                                  .toList();
                            }
                            _showAnimalSpecies(
                                sectionHeading, context, speciesList);
                            break;
                          case 'Animal Breed':
                            _showAnimalBreed(sectionHeading, context);
                            break;
                          case 'Tags':
                            _showAnimalTags(context);
                            break;
                        }
                      },
                      status: TextStatus.idle,
                      position: TextButtonPosition.right,
                    )
                  else
                    _buildListItem(sectionHeading, sectionLanguages[index],
                        selectedLanguage),
              ],
            ),
            Container(
              height: 1,
              width: SizeConfig.widthMultiplier(context) * 343,
              color: AppColors.grayscale20,
            ),
            SizedBox(height: SizeConfig.heightMultiplier(context) * 15),
          ],
        ));
  }

  void _showAnimalSpecies(
      String section, BuildContext context, List<String> speciesList) async {
    List<String> filteredModalList = List.from(speciesList);
    TextEditingController searchValue = TextEditingController();

    DrawUpAnimalSpecies drawUpAnimalSpecies = DrawUpAnimalSpecies(
      searchValue: searchValue,
      speciesList: filteredModalList,
      modalAnimalSpeciesList: speciesList,
    );

    final selectedSpeciesValue = await showModalBottomSheet<String>(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return drawUpAnimalSpecies;
      },
    );

    if (selectedSpeciesValue != null) {
      setState(() {
        visibleFilterItems[section]?.add(selectedSpeciesValue);
        selectedAnimals[section] = selectedSpeciesValue;
        visibleFilterItems['Animal Breed'] =
            speciesToBreedsMap[selectedSpeciesValue]!;
      });
    }
  }

  void _showAnimalBreed(String section, BuildContext context) async {
    final selectedAnimalSpecies = selectedAnimals['Animal Species'];
    List<String> filteredBreedList = selectedAnimalSpecies != null
        ? List.from(moreSpeciesToBreedsMap[selectedAnimalSpecies] ?? [])
        : totalBreedsList;
    TextEditingController searchValue = TextEditingController();

    DrawUpAnimalBreed drawUpAnimalBreed = DrawUpAnimalBreed(
      searchValue: searchValue,
      breedList: filteredBreedList,
      moreSpeciesToBreedsMap: moreSpeciesToBreedsMap,
      selectedAnimalSpecies: selectedAnimalSpecies,
    );

    final selectedBreedValue = await showModalBottomSheet<String>(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return drawUpAnimalBreed;
      },
    );

    if (selectedBreedValue != null) {
      setState(() {
        if (!visibleFilterItems[section]!.contains(selectedBreedValue)) {
          visibleFilterItems[section]?.add(selectedBreedValue);
        }
        selectedAnimals[section] = selectedBreedValue;
      });
    }
  }

  Future<void> _showAnimalTags(context) async {
    await showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: DrawUpWidget(
            heightFactor: 0.73,
            heading: "Tags".tr,
            content: ShowFilterReg(
              currentStateTags: currentStateTags,
              medicalStateTags: medicalStateTags,
              otherStateTags: otherStateTags,
              updatedCurrentTagStatus: _updateCurrentTagStatus,
              updatedMedicalTagStatus: _updateMedicalTagStatus,
              updatedOtherTagStatus: _updateOtherTagStatus,
            ),
          ),
        );
      },
    );
    setState(() {});
  }

  void _updateCurrentTagStatus(String tagName, TagStatus updatedStatus) {
    final tagIndex = currentStateTags.indexWhere((tag) => tag.name == tagName);
    if (tagIndex != -1) {
      currentStateTags[tagIndex].status = updatedStatus;
    }
  }

  void _updateMedicalTagStatus(String tagName, TagStatus updatedStatus) {
    final tagIndex = medicalStateTags.indexWhere((tag) => tag.name == tagName);
    if (tagIndex != -1) {
      medicalStateTags[tagIndex].status = updatedStatus;
    }
  }

  void _updateOtherTagStatus(String tagName, TagStatus updatedStatus) {
    final tagIndex = otherStateTags.indexWhere((tag) => tag.name == tagName);
    if (tagIndex != -1) {
      otherStateTags[tagIndex].status = updatedStatus;
    }
  }

  Widget _buildListItem(
      String sectionHeading, String language, String? selectedLanguage) {
    bool isSelected = language == selectedLanguage;
    bool isMaleSelected = selectedAnimals['Animal Sex'] == 'Male';
    bool isBreedingStage = sectionHeading == 'Breeding Stage';
    bool isPregnantOrLactating =
        language == 'Pregnant' || language == 'Lactating';

    if (isMaleSelected && isBreedingStage && isPregnantOrLactating) {
      isSelected = false;
    }
    if (sectionHeading == 'Tags') {
      isSelected = currentStateTags.any((tag) =>
              tag.status == TagStatus.active && tag.name == language) ||
          medicalStateTags.any((tag) =>
              tag.status == TagStatus.active && tag.name == language) ||
          otherStateTags.any(
              (tag) => tag.status == TagStatus.active && tag.name == language);
    }

    Color borderColor = isSelected ? Colors.green : Colors.grey;
    Color trailingColor = isPregnantOrLactating && isMaleSelected
        ? const Color.fromARGB(117, 158, 158, 158)
        : Colors.transparent;
    Color textColor =
        isPregnantOrLactating && isMaleSelected ? Colors.grey : Colors.black;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        language.tr,
        style: AppFonts.body2(color: textColor),
      ),
      trailing: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
            width: isSelected ? 6.0 : 1.0,
          ),
          color: trailingColor,
        ),
      ),
      onTap: () {
        setState(() {
          if (sectionHeading == 'Tags') {
            final currentStateIndex =
                currentStateTags.indexWhere((tag) => tag.name == language);
            final medicalStateIndex =
                medicalStateTags.indexWhere((tag) => tag.name == language);
            final otherStateIndex =
                otherStateTags.indexWhere((tag) => tag.name == language);
            if (currentStateIndex != -1) {
              currentStateTags[currentStateIndex].status =
                  isSelected ? TagStatus.notActive : TagStatus.active;
            }
            if (medicalStateIndex != -1) {
              medicalStateTags[medicalStateIndex].status =
                  isSelected ? TagStatus.notActive : TagStatus.active;
            }
            if (otherStateIndex != -1) {
              otherStateTags[otherStateIndex].status =
                  isSelected ? TagStatus.notActive : TagStatus.active;
            }
            return;
          }
          if (isSelected) {
            selectedAnimals[sectionHeading] = null;
          } else {
            selectedAnimals[sectionHeading] = language;
          }
          if (sectionHeading == 'Animal Type') {
            final animalType = selectedAnimals[sectionHeading];
            if (animalType == 'Mammal') {
              visibleFilterItems['Animal Species'] = AnimalFilters
                  .filterItems['Animal Species']!
                  .where((element) => mammalSpeciesList.contains(element))
                  .take(3)
                  .toList();
            } else if (animalType == 'Oviparous') {
              visibleFilterItems['Animal Species'] = AnimalFilters
                  .filterItems['Animal Species']!
                  .where((element) => oviparousSpeciesList.contains(element))
                  .take(3)
                  .toList();
            }
          } else if (sectionHeading == 'Animal Species' &&
              selectedAnimals[sectionHeading] != null) {
            visibleFilterItems['Animal Breed'] =
                speciesToBreedsMap[selectedAnimals[sectionHeading]]!;
          }
        });
      },
    );
  }
}
