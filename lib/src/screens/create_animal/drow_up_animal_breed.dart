// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import 'package:sulala_app/src/data/globals.dart' as globals;

import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/inputs/search_bars/search_bar.dart';

class DrowupAnimalBreed extends StatefulWidget {
  TextEditingController searchValue = TextEditingController();
  List<String> filteredBreedList = [];
  List<String> modalAnimalBreedList = [];
  StateSetter setState;

  DrowupAnimalBreed(
      {super.key,
      required this.searchValue,
      required this.filteredBreedList,
      required this.modalAnimalBreedList,
      required this.setState});

  @override
  State<DrowupAnimalBreed> createState() => _DrowupAnimalBreedState();

  void resetSelection() {
    setState(() {
      _selectedItemIndex = -1; // Reset selected index
    });
  }
}

int _selectedItemIndex = -1;

class _DrowupAnimalBreedState extends State<DrowupAnimalBreed> {
  @override
  Widget build(BuildContext context) {
    return DrowupWidget(
      heading: 'Animal Breed',
      heightFactor: 0.9,
      content: SizedBox(
        height: globals.heightMediaQuery * 530,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimarySearchBar(
                controller: widget.searchValue,
                onChange: (value) {
                  setState(() {
                    value = widget.searchValue.text;
                    widget.filteredBreedList = widget.modalAnimalBreedList
                        .where((element) =>
                            element.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  });
                },
                hintText: 'Search by breed'),
            SizedBox(
              height: globals.heightMediaQuery * 24,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.filteredBreedList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(widget.filteredBreedList[index],
                        style: AppFonts.body2(color: AppColors.grayscale90)),
                    trailing: Container(
                      width: globals.widthMediaQuery * 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _selectedItemIndex == index
                              ? AppColors.primary20
                              : AppColors.grayscale30,
                          width: _selectedItemIndex == index ? 6.0 : 1.0,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedItemIndex = index;
                      });
                    },
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
            Navigator.pop(
                context, widget.filteredBreedList[_selectedItemIndex]);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
