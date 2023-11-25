import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';

import '../../widgets/controls_and_buttons/tags/tags.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../breeding/list_of_breeding_events.dart';
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
  Map<String, List<String>> sectionItems = {
    'Animal Type': ['Mammal', 'Oviparous'],
    'Animal Species': ['Sheep', 'Cow', 'Horse'],
    'Animal Breed': ['Altafai stoat', 'East Siberian stoat', 'Gobi stoat'],
    'Animal Sex': ['Male', 'Female'],
    'Breeding Stage': ['Ready for breeding', 'Pregnant', 'Lactating'],
    'Tags': ['Borrowed', 'Adopted', 'Donated'],
  };

  Map<String, String?> selectedAnimals = {};

  @override
  void initState() {
    super.initState();
    for (var heading in sectionItems.keys) {
      selectedAnimals[heading] = null;
    }
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
              right: globals.widthMediaQuery * 16,
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  selectedAnimals.clear();
                  for (var heading in sectionItems.keys) {
                    selectedAnimals[heading] = null;
                  }
                });
              },
              icon: Container(
                  width: globals.widthMediaQuery * 37.5,
                  height: globals.widthMediaQuery * 37.5,
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
              sectionIndex < sectionItems.length;
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

            ref
                .read(selectedFiltersProvider.notifier)
                .update((state) => selectedFiltersList);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserListOfAnimals(
                  shouldAddAnimal: false,
                  breedingEvents: [],
                ),
              ),
            );
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
    String sectionHeading = sectionItems.keys.elementAt(sectionIndex);
    List<String> sectionLanguages = sectionItems[sectionHeading]!;
    String? selectedLanguage = selectedAnimals[sectionHeading];

    bool showShowMoreButton =
        sectionHeading != 'Animal Type' && sectionHeading != 'Animal Sex';

    return Padding(
        padding: EdgeInsets.only(
            left: globals.widthMediaQuery * 16,
            right: globals.widthMediaQuery * 16),
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
                        _showDialog(
                            context, sectionHeading); // Show dialog on tap
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
              width: globals.widthMediaQuery * 343,
              color: AppColors.grayscale20,
            ),
            SizedBox(height: globals.heightMediaQuery * 15),
          ],
        ));
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
          if (isSelected) {
            selectedAnimals[sectionHeading] = null;
          } else {
            selectedAnimals[sectionHeading] = language;
          }
        });
      },
    );
  }
}
