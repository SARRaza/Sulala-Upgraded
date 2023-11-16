// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/inputs/search_bars/search_bar.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

class AddParentsDrowup extends StatelessWidget {
  StateSetter setState;

  AddParentsDrowup({
    super.key,
    required this.setState,
  });

  TextEditingController searchValue = TextEditingController();
  List<String> modalAnimalSpeciesList = [
    'Tiger',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Giraffe'
  ];
  List<String> filteredModalList = [];
  List<String> selectedFilters = [];
  var _selectedItemIndex = -1;
  @override
  Widget build(BuildContext context) {
    return DrowupWidget(
      heading: 'Add Mother',
      heightFactor: 0.9,
      content: SizedBox(
        height: globals.heightMediaQuery * 552.16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimarySearchBar(
                controller: searchValue,
                onChange: (value) {
                  setState(() {
                    value = searchValue.text;
                    filteredModalList = modalAnimalSpeciesList
                        .where((element) =>
                            element.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  });
                },
                hintText: 'Search by species'),
            SizedBox(
              height: globals.heightMediaQuery * 24,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredModalList.isEmpty
                    ? modalAnimalSpeciesList.length
                    : filteredModalList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedItemIndex = index;
                      });
                    },
                    child: Container(
                        color: _selectedItemIndex == index
                            ? AppColors.grayscale20
                            : Colors.transparent,
                        padding: const EdgeInsets.all(8.0),
                        child: filteredModalList.isEmpty
                            ? Row(
                                children: [
                                  CircleAvatar(
                                    radius: globals.widthMediaQuery * 24,
                                    backgroundImage: const AssetImage(
                                        'assets/avatars/120px/Horse_avatar.png'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  SizedBox(
                                    width: globals.widthMediaQuery * 16,
                                  ),
                                  Text(
                                    modalAnimalSpeciesList[index],
                                    style: AppFonts.body2(
                                        color: AppColors.grayscale90),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  CircleAvatar(
                                    radius: globals.widthMediaQuery * 24,
                                    backgroundImage: const AssetImage(
                                        'assets/avatars/120px/Horse_avatar.png'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  SizedBox(
                                    width: globals.widthMediaQuery * 16,
                                  ),
                                  Text(
                                    filteredModalList[index],
                                    style: AppFonts.body2(
                                        color: AppColors.grayscale90),
                                  ),
                                ],
                              )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      primaryButton: PrimaryButton(
        status: PrimaryButtonStatus.idle,
        text: 'Confirm',
        onPressed: () {
          if (_selectedItemIndex != -1) {
            Navigator.pop(context, filteredModalList[_selectedItemIndex]);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
