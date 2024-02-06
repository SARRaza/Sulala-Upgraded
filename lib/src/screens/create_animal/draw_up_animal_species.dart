import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import '../../data/place_holders.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/inputs/search_bars/search_bar.dart';

class DrawUpAnimalSpecies extends ConsumerStatefulWidget {
  final TextEditingController searchValue;
  final List<String> speciesList;
  final List<String> modalAnimalSpeciesList;

  const DrawUpAnimalSpecies(
      {super.key,
      required this.searchValue,
      required this.speciesList,
      required this.modalAnimalSpeciesList});

  @override
  ConsumerState<DrawUpAnimalSpecies> createState() =>
      _DrawUpAnimalSpeciesState();
}

class _DrawUpAnimalSpeciesState extends ConsumerState<DrawUpAnimalSpecies> {
  int _selectedItemIndex = -1;
  late List<String> filteredModalList;

  @override
  void initState() {
    super.initState();
    filteredModalList = widget.speciesList;
  }

  @override
  Widget build(BuildContext context) {
    return DrowupWidget(
      heading: 'Animal Species'.tr,
      heightFactor: 0.9,
      content: SizedBox(
        //height: SizeConfig.heightMultiplier(context) * 530,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimarySearchBar(
              controller: widget.searchValue,
              onChange: (value) {
                // Directly use value for filtering
                setState(() {
                  filteredModalList = widget.modalAnimalSpeciesList
                      .where((element) =>
                          element.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
              hintText: 'Search by species'.tr,
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 24,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredModalList.length,
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
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: SizeConfig.widthMultiplier(context) * 24,
                            backgroundImage: AssetImage(
                                speciesImages[filteredModalList[index]]!),
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier(context) * 16,
                          ),
                          Text(
                            filteredModalList[index],
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                        ],
                      ),
                    ),
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
          if (_selectedItemIndex != -1) {
            final selectedSpecies = filteredModalList[_selectedItemIndex];

            // Use the ref parameter to read and update the Riverpod provider
            ref
                .read(selectedAnimalSpeciesProvider.notifier)
                .update((state) => selectedSpecies);

            Navigator.pop(context, selectedSpecies);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
