import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../data/globals.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/option_row.dart';
import 'add_complete_info.dart';

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
          'Create Animal'.tr,
          style: AppFonts.headline3(color: AppColors.grayscale90),
        ),
        leadingWidth: SizeConfig.widthMultiplier(context) * 56,
        leading: Padding(
          padding:
              EdgeInsets.only(left: SizeConfig.widthMultiplier(context) * 16),
          child: Container(
            decoration: const BoxDecoration(
                color: AppColors.grayscale10, shape: BoxShape.circle),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: SizeConfig.widthMultiplier(context) * 24,
              ),
              onPressed: () {
                // Handle back button press
                Navigator.pop(context);
              },
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: SizeConfig.widthMultiplier(context) * 16),
            child: Container(
              width: SizeConfig.widthMultiplier(context) * 40,
              decoration: const BoxDecoration(
                  color: AppColors.grayscale10, shape: BoxShape.circle),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                  size: SizeConfig.widthMultiplier(context) * 24,
                ),
                onPressed: () {
                  // Handle close button press
                  Navigator.pop(context, true);
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.widthMultiplier(context) * 16,
            right: SizeConfig.widthMultiplier(context) * 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 24,
            ),
            Text('Chosen Options'.tr,
                style: AppFonts.headline2(color: AppColors.grayscale90)),
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 8,
            ),
            Text(
              'You can apply any changes'.tr,
              style: AppFonts.body2(color: AppColors.grayscale60),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 24,
            ),
            OptionRow(
              label: 'Animal Type'.tr,
              value: selectedAnimalType.tr,
            ),
            SizedBox(height: SizeConfig.heightMultiplier(context) * 8),
            const Divider(
              color: AppColors.grayscale50,
            ),
            SizedBox(height: SizeConfig.heightMultiplier(context) * 8),
            OptionRow(
                label: 'Animal Species'.tr, value: selectedAnimalSpecies.tr),
            SizedBox(height: SizeConfig.heightMultiplier(context) * 8),
            const Divider(
              color: AppColors.grayscale50,
            ),
            SizedBox(height: SizeConfig.heightMultiplier(context) * 8),
            OptionRow(
                label: 'Animal Breeds'.tr, value: selectedAnimalBreeds.tr),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: SizeConfig.widthMultiplier(context) * 343,
        height: SizeConfig.heightMultiplier(context) * 52,
        child: PrimaryButton(
            onPressed: () async {
              ref
                  .read(selectedAnimalImageProvider.notifier)
                  .update((state) => null);
              ref.read(animalNameProvider.notifier).update((state) => '');
              ref
                  .read(selectedOviGenderProvider.notifier)
                  .update((state) => 'Unknown');
              ref.read(layingFrequencyProvider.notifier).update((state) => '');
              ref.read(eggsPerMonthProvider.notifier).update((state) => '');
              ref
                  .read(selectedBreedingStageProvider.notifier)
                  .update((state) => '');
              ref.read(dateOfBirthProvider.notifier).update((state) => null);
              ref.read(selectedOviDatesProvider.notifier).update((state) => {});
              ref.read(selectedOviChipsProvider.notifier).update((state) => []);
              ref.read(fieldNameProvider.notifier).update((state) => '');
              ref.read(fieldContentProvider.notifier).update((state) => '');
              ref.read(additionalNotesProvider.notifier).update((state) => '');
              final close = await Navigator.push<bool?>(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCompleteInfo(),
                ),
              );
              if(close == true && mounted) {
                Navigator.pop(context, true);
              }
            },
            text: 'Create Animal'.tr),
      ),
    );
  }
}