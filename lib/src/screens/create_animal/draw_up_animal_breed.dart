import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/inputs/search_bars/search_bar.dart';

class DrawUpAnimalBreed extends ConsumerStatefulWidget {
  final TextEditingController searchValue;
  final List<String> breedList;

  final String? selectedAnimalSpecies;
  final Map<String, List<String>> moreSpeciesToBreedsMap;

  const DrawUpAnimalBreed(
      {super.key,
      required this.searchValue,
      required this.breedList,
      this.selectedAnimalSpecies,
      required this.moreSpeciesToBreedsMap});

  @override
  ConsumerState<DrawUpAnimalBreed> createState() => _DrawUpAnimalBreedState();
}

class _DrawUpAnimalBreedState extends ConsumerState<DrawUpAnimalBreed> {
  late List<String> filteredBreedList;
  int selectedItemIndex = -1;

  @override
  void initState() {
    super.initState();
    filteredBreedList = widget.breedList;
  }

  @override
  Widget build(BuildContext context) {
    return DrowupWidget(
      heading: 'Animal Breed'.tr,
      heightFactor: 0.9,
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimarySearchBar(
              controller: widget.searchValue,
              onChange: _onSearchChanged,
              hintText: 'Search by breed'.tr,
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 24,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredBreedList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(filteredBreedList[index],
                        style: AppFonts.body2(color: AppColors.grayscale90)),
                    trailing: Container(
                      width: SizeConfig.widthMultiplier(context) * 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedItemIndex == index
                              ? AppColors.primary20
                              : AppColors.grayscale30,
                          width: selectedItemIndex == index ? 6.0 : 1.0,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedItemIndex = index;
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
        text: 'Confirm'.tr,
        onPressed: () {
          if (selectedItemIndex != -1) {
            final selectedBreeds = filteredBreedList[selectedItemIndex];

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

  void _onSearchChanged(String value) {
    setState(() {
      value = widget.searchValue.text;
      if (value.isNotEmpty) {
        List<String> breedsForSpecies =
        widget.selectedAnimalSpecies != null
            ? widget.moreSpeciesToBreedsMap[
        widget.selectedAnimalSpecies] ??
            []
            : totalBreedsList;

        filteredBreedList = breedsForSpecies
            .where((breed) =>
            breed.toLowerCase().contains(value.toLowerCase()))
            .toList();
      } else {
        // Show all breeds for the selected species if the search value is empty
        filteredBreedList = widget.moreSpeciesToBreedsMap[
        widget.selectedAnimalSpecies] ??
            [];
      }
    });
  }
}
