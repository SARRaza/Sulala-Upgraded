import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import 'add_complete_info.dart';

import 'package:sulala_upgrade/src/data/globals.dart' as globals;

class SelectedOptionsPage extends ConsumerStatefulWidget {
  const SelectedOptionsPage({super.key});

  @override
  ConsumerState<SelectedOptionsPage> createState() =>
      _SelectedOptionsPageState();
}

class _SelectedOptionsPageState extends ConsumerState<SelectedOptionsPage> {
  @override
  Widget build(BuildContext context) {
    final selectedAnimalType = ref.watch(selectedAnimalTypeProvider);
    final selectedAnimalSpecies = ref.watch(selectedAnimalSpeciesProvider);
    final selectedAnimalBreeds = ref.watch(selectedAnimalBreedsProvider);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Create Animal',
          style: AppFonts.headline3(color: AppColors.grayscale90),
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
                // Handle close button press
                Navigator.pop(context);
              },
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: globals.widthMediaQuery * 16),
            child: Container(
              width: globals.widthMediaQuery * 40,
              decoration: const BoxDecoration(
                  color: AppColors.grayscale10, shape: BoxShape.circle),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                  size: globals.widthMediaQuery * 24,
                ),
                onPressed: () {
                  // Handle close button press
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: globals.widthMediaQuery * 16,
            right: globals.widthMediaQuery * 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: globals.heightMediaQuery * 24,
            ),
            Text('Chosen Options',
                style: AppFonts.headline2(color: AppColors.grayscale90)),
            SizedBox(
              height: globals.heightMediaQuery * 8,
            ),
            Text(
              'You can apply any changes',
              style: AppFonts.body2(color: AppColors.grayscale60),
            ),
            SizedBox(
              height: globals.heightMediaQuery * 24,
            ),
            Row(
              children: [
                Text(
                  'Animal Type',
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
                const Spacer(),
                Text(
                  selectedAnimalType,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                SizedBox(
                  width: globals.widthMediaQuery * 8,
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    color: AppColors.primary40,
                    size: globals.widthMediaQuery * 12.75),
              ],
            ),
            SizedBox(height: globals.heightMediaQuery * 8),
            const Divider(
              color: AppColors.grayscale50,
            ),
            SizedBox(height: globals.heightMediaQuery * 8),
            Row(
              children: [
                Text(
                  'Animal Species',
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
                const Spacer(),
                Text(
                  selectedAnimalSpecies,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                SizedBox(
                  width: globals.widthMediaQuery * 8,
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    color: AppColors.primary40,
                    size: globals.widthMediaQuery * 12.75),
              ],
            ),
            SizedBox(height: globals.heightMediaQuery * 8),
            const Divider(
              color: AppColors.grayscale50,
            ),
            SizedBox(height: globals.heightMediaQuery * 8),
            Row(
              children: [
                Text(
                  'Animal Breed',
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
                const Spacer(),
                Text(
                  selectedAnimalBreeds,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                SizedBox(
                  width: globals.widthMediaQuery * 8,
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    color: AppColors.primary40,
                    size: globals.widthMediaQuery * 12.75),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: globals.widthMediaQuery * 343,
        height: globals.heightMediaQuery * 52,
        child: PrimaryButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateOviCumMammal(),
                ),
              );
            },
            text: 'Create Animal'),
      ),
    );
  }
}
