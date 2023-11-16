import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';

import 'package:sulala_upgrade/src/data/globals.dart' as globals;

import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/checkbox/checkbox_active.dart';
import '../../widgets/controls_and_buttons/checkbox/checkbox_desabled.dart';
import '../../widgets/controls_and_buttons/tags/tags.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import 'showdialogdraf.dart';
import 'user_list_of_animals.dart';

class AnimalFilters extends StatefulWidget {
  const AnimalFilters({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnimalFilters createState() => _AnimalFilters();
}

class _AnimalFilters extends State<AnimalFilters> {
  Map<String, List<String>> sectionItemsRadio = {
    'Animal Type': ['Mammal', 'Oviparous'],
    'Animal Species': ['Sheep', 'Cow', 'Horse'],
    'Animal Breed': ['Altafai stoat', 'East Siberian stoat', 'Gobi stoat'],
    'Animal Sex': ['Male', 'Female'],
  };

  Map<String, List<String>> sectionItemsCheckBox = {
    'Breeding Stage': ['Ready for breeding', 'Pregnant', 'Lactating'],
    'Tags': ['Borrowed', 'Adopted', 'Donated'],
  };

  Map<String, String?> selectedAnimals = {};
  Map<String, String?> selectedAnimals1 = {};

  @override
  void initState() {
    super.initState();
    for (var heading in sectionItemsRadio.keys) {
      selectedAnimals[heading] = null;
    }
    for (var heading in sectionItemsCheckBox.keys) {
      selectedAnimals1[heading] = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    selectedAnimals.clear();
                    selectedAnimals1.clear();
                    for (var heading in sectionItemsRadio.keys) {
                      selectedAnimals[heading] = null;
                    }
                    for (var heading in sectionItemsCheckBox.keys) {
                      selectedAnimals1[heading] = null;
                    }
                  });
                  Navigator.pop(context);
                },
                icon: Container(
                  width: globals.widthMediaQuery * 37.5,
                  height: globals.widthMediaQuery * 37.5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grayscale10,
                  ),
                  child: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            for (var sectionIndex = 0;
                sectionIndex < sectionItemsRadio.length;
                sectionIndex++)
              _buildSectionRadio(sectionIndex),
            for (var sectionIndex = 0;
                sectionIndex < sectionItemsCheckBox.length;
                sectionIndex++)
              _buildSectionCheckBox(sectionIndex),
          ],
        ),
        persistentFooterButtons: [
          SizedBox(
            width: globals.widthMediaQuery * 343,
            height: globals.heightMediaQuery * 52,
            child: PrimaryButton(
              onPressed: () {
                List<String> selectedFiltersList = [];
                selectedAnimals.forEach((key, value) {
                  if (value != null) {
                    selectedFiltersList.add(value);
                  }
                });
                selectedAnimals1.forEach((key, value) {
                  if (value != null) {
                    selectedFiltersList.add(value);
                  }
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserListOfAnimals(
                      selectedFilters: selectedFiltersList,
                    ),
                  ),
                );
              },
              text: "Continue",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionRadio(int sectionIndex) {
    String sectionHeading = sectionItemsRadio.keys.elementAt(sectionIndex);
    List<String> sectionLanguages = sectionItemsRadio[sectionHeading]!;
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
                else
                  _buildRadioListItem(sectionHeading, sectionLanguages[index],
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
      ),
    );
  }

  Widget _buildSectionCheckBox(int sectionIndex) {
    String sectionHeading = sectionItemsCheckBox.keys.elementAt(sectionIndex);
    List<String> sectionLanguages = sectionItemsCheckBox[sectionHeading]!;
    String? selectedLanguage = selectedAnimals[sectionHeading];

    bool showShowMoreButton = sectionHeading.isNotEmpty;

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
                else
                  _buildCheckBoxListItem(sectionHeading,
                      sectionLanguages[index], selectedLanguage),
            ],
          ),
          Container(
            height: 1,
            width: globals.heightMediaQuery * 343,
            color: AppColors.grayscale20,
          ),
          SizedBox(height: globals.heightMediaQuery * 15),
        ],
      ),
    );
  }

  Widget _buildRadioListItem(
      String sectionHeading, String language, String? selectedLanguage) {
    bool isSelected = language == selectedLanguage;

    Color borderColor =
        isSelected ? AppColors.primary20 : AppColors.grayscale30;
    Color trailingColor = Colors.transparent;
    Color textColor = AppColors.grayscale90;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        language,
        style: AppFonts.body2(color: textColor),
      ),
      trailing: Container(
        width: globals.widthMediaQuery * 24,
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

  Widget _buildCheckBoxListItem(
      String sectionHeading, String language, String? selectedLanguage) {
    bool isSelected = language == selectedLanguage;
    bool isMaleSelected = selectedAnimals['Animal Sex'] == 'Male';
    bool isBreedingStage = sectionHeading == 'Breeding Stage';
    bool isPregnantOrLactating =
        language == 'Pregnant' || language == 'Lactating';

    if (isMaleSelected && isBreedingStage && isPregnantOrLactating) {
      isSelected = false;
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          language,
          style: AppFonts.body2(color: AppColors.grayscale90),
        ),
        trailing: const CheckBoxDisabled(
          checked: false,
        ),
      );
    }
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        language,
        style: AppFonts.body2(color: AppColors.grayscale90),
      ),
      trailing: CheckBoxActive(
        checked: false,
        onChanged: (bool checked) {
          setState(() {
            if (isSelected) {
              selectedAnimals[sectionHeading] = null;
            } else {
              selectedAnimals[sectionHeading] = language;
            }
          });
        },
      ),
    );
  }
}

void _showDialog(BuildContext context, String sectionHeading) {
  if (sectionHeading == 'Tags') {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return DrowupWidget(
            primaryTextButton: PrimaryTextButton(
              status: TextStatus.idle,
              text: "Add New",
              onPressed: () {
                // print("Add New");
              },
            ),
            heightFactor: 0.85,
            heading: "Tags",
            content: ShowFilterUser(
              initialAdoptedStatus: TagStatus.notActive,
              initialBorrowedStatus: TagStatus.notActive,
              initialDonatedStatus: TagStatus.notActive,
              onAdoptedStatusChanged: (TagStatus status) {
                // print('Adopted status changed to: $status');
              },
              initialDeadStatus: TagStatus.notActive,
              initialEscapedStatus: TagStatus.notActive,
              initialInjuredStatus: TagStatus.notActive,
              initialMedicationStatus: TagStatus.notActive,
              initialQuarantinedStatus: TagStatus.notActive,
              initialSickStatus: TagStatus.notActive,
              initialSoldStatus: TagStatus.notActive,
              initialStolenStatus: TagStatus.notActive,
              initialTestingStatus: TagStatus.notActive,
              initialTransferredStatus: TagStatus.notActive,
              onBorrowesStatusChanged: (status) {},
              onDeadStatusChanged: (status) {},
              onDonatedStatusChanged: (status) {},
              onEscapedStatusChanged: (status) {},
              onInjuredStatusChanged: (status) {},
              onMedicationStatusChanged: (status) {},
              onQuarantinedStatusChanged: (status) {},
              onSickStatusChanged: (status) {},
              onSoldStatusChanged: (status) {},
              onStolenStatusChanged: (status) {},
              onTestingStatusChanged: (status) {},
              onTransferredStatusChanged: (status) {},
            ));
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
