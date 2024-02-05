import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import '../../data/animal_filters.dart';
import '../../data/classes/breeding_event_variables.dart';
import '../../data/globals.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';

import '../../widgets/controls_and_buttons/tags/tags.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../reg_mode/reg_home_page.dart';
import '../reg_mode/show_filter_reg.dart';
import 'drow_up_animal_breed.dart';
import 'drow_up_animal_species.dart';
import 'sar_listofanimals.dart';

// ignore: must_be_immutable
class SarAnimalFilters extends ConsumerStatefulWidget {
  final List<BreedingEventVariables> breedingEvents;

  const SarAnimalFilters({super.key, required this.breedingEvents});

  @override
  // ignore: library_private_types_in_public_api
  _SarAnimalFilters createState() => _SarAnimalFilters();
}

class _SarAnimalFilters extends ConsumerState<SarAnimalFilters> {
  Map<String, String?> selectedAnimals = {};
  Map<String, List<String>> visibleFilterItems = {};
  List<Tag> currentStateTags = [
    Tag(name: 'Borrowed'.tr, status: TagStatus.notActive),
    Tag(name: 'Adopted'.tr, status: TagStatus.notActive),
    Tag(name: 'Donated'.tr, status: TagStatus.notActive),
    Tag(name: 'Escaped'.tr, status: TagStatus.notActive),
    Tag(name: 'Stolen'.tr, status: TagStatus.notActive),
    Tag(name: 'Transferred'.tr, status: TagStatus.notActive),
  ];
  List<Tag> medicalStateTags = [
    Tag(name: 'Injured'.tr, status: TagStatus.notActive),
    Tag(name: 'Sick'.tr, status: TagStatus.notActive),
    Tag(name: 'Quarantined'.tr, status: TagStatus.notActive),
    Tag(name: 'Medication'.tr, status: TagStatus.notActive),
    Tag(name: 'Testing'.tr, status: TagStatus.notActive),
  ];

  List<Tag> otherStateTags = [
    Tag(name: 'Sold'.tr, status: TagStatus.notActive),
    Tag(name: 'Dead'.tr, status: TagStatus.notActive),
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

  void _showDialog(BuildContext context, String sectionHeading) {
    if (sectionHeading == 'Tags') {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SizedBox(
            width: double.infinity,
            child: FractionallySizedBox(
              heightFactor: 0.62,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'Tags',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Current State',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Tags(
                              text: 'Borrowed',
                              icon: Icons.ac_unit,
                              onPress: () {
                                // Handle tag click
                              },
                              status: TagStatus.active,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Tags(
                              text: 'Adopted',
                              icon: Icons.ac_unit,
                              onPress: () {
                                // Handle tag click
                              },
                              status: TagStatus.notActive,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Tags(
                              text: 'Donated',
                              icon: Icons.ac_unit,
                              onPress: () {
                                // Handle tag click
                              },
                              status: TagStatus.disabled,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Tags(
                              text: 'Escaped',
                              icon: Icons.ac_unit,
                              onPress: () {
                                // Handle tag click
                              },
                              status: TagStatus.active,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Tags(
                              text: 'Stolen',
                              icon: Icons.ac_unit,
                              onPress: () {
                                // Handle tag click
                              },
                              status: TagStatus.notActive,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Tags(
                              text: 'Transferred',
                              icon: Icons.ac_unit,
                              onPress: () {
                                // Handle tag click
                              },
                              status: TagStatus.disabled,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Medical State',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Tags(
                              text: 'Injured',
                              icon: Icons.ac_unit,
                              onPress: () {
                                // Handle tag click
                              },
                              status: TagStatus.active,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Tags(
                              text: 'Sick',
                              icon: Icons.ac_unit,
                              onPress: () {
                                // Handle tag click
                              },
                              status: TagStatus.notActive,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Tags(
                              text: 'Quarantined',
                              icon: Icons.ac_unit,
                              onPress: () {
                                // Handle tag click
                              },
                              status: TagStatus.disabled,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Tags(
                              text: 'Medication',
                              icon: Icons.ac_unit,
                              onPress: () {
                                // Handle tag click
                              },
                              status: TagStatus.active,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Tags(
                              text: 'Testing',
                              icon: Icons.ac_unit,
                              onPress: () {
                                // Handle tag click
                              },
                              status: TagStatus.notActive,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Others',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 42, 41, 41),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Tags(
                              text: 'Sold',
                              icon: Icons.ac_unit,
                              onPress: () {
                                // Handle tag click
                              },
                              status: TagStatus.active,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Tags(
                              text: 'Dead',
                              icon: Icons.ac_unit,
                              onPress: () {
                                // Handle tag click
                              },
                              status: TagStatus.notActive,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor:
                                    const Color.fromARGB(255, 225, 225, 225),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              onPressed: () {
                                // Handle cancel button press
                                Navigator.pop(context); // Close the modal sheet
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text('Clear All',
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor:
                                    const Color.fromARGB(255, 36, 86, 38),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              onPressed: () {
                                // Handle join farm button press
                                Navigator.pop(context); // Close the modal sheet
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  'Apply',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Show More"),
            content: const Text("You tapped the 'Show more >' button."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
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
          'Filter Animals',
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
          text: "Continue",
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(16),
      //   child: ButtonWidget(
      //     onPressed: () {
      //       List<String> selectedFiltersList = [];
      //       selectedAnimals.forEach((key, value) {
      //         if (value != null) {
      //           selectedFiltersList.add(value);
      //         }
      //       });

      //       ref
      //           .read(selectedFiltersProvider.notifier)
      //           .update((state) => selectedFiltersList);

      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => ListOfAnimals(
      //             shouldAddAnimal: false,
      //           ),
      //         ),
      //       );
      //     },
      //     buttonText: 'Continue',
      //   ),
      // ),
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
              sectionHeading,
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
                      text: 'Show more',
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
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       _showDialog(
                  //           context, sectionHeading); // Show dialog on tap
                  //     },
                  //     child: const Text(
                  //       'Show more >',
                  //       style: TextStyle(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.bold,
                  //         color: Color.fromARGB(255, 36, 86, 38),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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

    DrowupAnimalSpecies drowupAnimalSpecies = DrowupAnimalSpecies(
      searchValue: searchValue,
      filteredModalList: filteredModalList,
      modalAnimalSpeciesList: speciesList,
      setState: setState,
    );

    drowupAnimalSpecies.resetSelection();

    final selectedSpeciesValue = await showModalBottomSheet<String>(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return drowupAnimalSpecies;
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
        ? List.from(morespeciesToBreedsMap[selectedAnimalSpecies] ?? [])
        : totalBreedsList;
    TextEditingController searchValue = TextEditingController();

    DrowupAnimalBreed drowupAnimalBreed = DrowupAnimalBreed(
      searchValue: searchValue,
      filteredBreedList: filteredBreedList,
      setState: setState,
      morespeciesToBreedsMap: morespeciesToBreedsMap,
      selectedAnimalSpecies: selectedAnimalSpecies,
    );

    drowupAnimalBreed.resetSelection();

    final selectedBreedValue = await showModalBottomSheet<String>(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return drowupAnimalBreed;
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
          child: DrowupWidget(
            heightFactor: 0.73,
            heading: "Tags".tr,
            content: ShowFilterReg(
              currentStateTags: currentStateTags,
              medicalStateTags: medicalStateTags,
              otherStateTags: otherStateTags,
              updatedCurrentTagStatus: updateCurrentTagStatus,
              updatedMedicalTagStatus: updateMedicalTagStatus,
              updatedOtherTagStatus: updateOtherTagStatus,
            ),
          ),
        );
      },
    );
    setState(() {});
  }

  void updateCurrentTagStatus(String tagName, TagStatus updatedStatus) {
    final tagIndex = currentStateTags.indexWhere((tag) => tag.name == tagName);
    if (tagIndex != -1) {
      currentStateTags[tagIndex].status = updatedStatus;
    }
  }

  void updateMedicalTagStatus(String tagName, TagStatus updatedStatus) {
    final tagIndex = medicalStateTags.indexWhere((tag) => tag.name == tagName);
    if (tagIndex != -1) {
      medicalStateTags[tagIndex].status = updatedStatus;
    }
  }

  void updateOtherTagStatus(String tagName, TagStatus updatedStatus) {
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
        language,
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
