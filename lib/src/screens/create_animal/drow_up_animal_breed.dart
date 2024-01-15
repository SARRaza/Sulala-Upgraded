// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sulala_upgrade/src/data/globals.dart' as globals;

import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/inputs/search_bars/search_bar.dart';

class DrowupAnimalBreed extends ConsumerStatefulWidget {
  TextEditingController searchValue = TextEditingController();
  List<String> filteredBreedList = [];

  StateSetter setState;
  String? selectedAnimalSpecies;
  Map<String, List<String>> morespeciesToBreedsMap = {};

  DrowupAnimalBreed(
      {super.key,
      required this.searchValue,
      required this.filteredBreedList,
      this.selectedAnimalSpecies,
      required this.morespeciesToBreedsMap,
      required this.setState});

  @override
  ConsumerState<DrowupAnimalBreed> createState() => _DrowupAnimalBreedState();

  void resetSelection() {
    setState(() {
      _selectedItemIndex = -1; // Reset selected index
    });
  }
}

int _selectedItemIndex = -1;

class _DrowupAnimalBreedState extends ConsumerState<DrowupAnimalBreed> {
  @override
  Widget build(BuildContext context) {
    return DrowupWidget(
      heading: 'Animal Breed',
      heightFactor: 0.9,
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimarySearchBar(
              controller: widget.searchValue,
              onChange: (value) {
                setState(() {
                  value = widget.searchValue.text;
                  if (value.isNotEmpty) {
                    List<String> breedsForSpecies = widget.selectedAnimalSpecies
                        != null ?
                        widget.morespeciesToBreedsMap[
                                widget.selectedAnimalSpecies] ??
                            [] : totalBreedsList;

                    widget.filteredBreedList = breedsForSpecies
                        .where((breed) =>
                            breed.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  } else {
                    // Show all breeds for the selected species if the search value is empty
                    widget.filteredBreedList = widget.morespeciesToBreedsMap[
                            widget.selectedAnimalSpecies] ??
                        [];
                  }
                });
              },
              hintText: 'Search by breed',
            ),
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
            final selectedBreeds = widget.filteredBreedList[_selectedItemIndex];

            // Use the ref parameter to read and update the Riverpod provider
            ref
                .read(selectedAnimalBreedsProvider.notifier)
                .update((state) => selectedBreeds);

            Navigator.pop(context, selectedBreeds);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
