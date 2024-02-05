// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import '../../../data/classes/ovi_variables.dart';
import '../../../data/riverpod_globals.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';

class AnimalTypeSelector extends ConsumerStatefulWidget {
  final OviVariables OviDetails;

  const AnimalTypeSelector({super.key, required this.OviDetails});

  @override
  _AnimalTypeSelectorState createState() => _AnimalTypeSelectorState();
}

class _AnimalTypeSelectorState extends ConsumerState<AnimalTypeSelector> {
  late String selectedAnimalType = widget.OviDetails.selectedAnimalType;

  @override
  void initState() {
    super.initState();
    // Initialize with the default value or the one from your model
    selectedAnimalType = widget.OviDetails.selectedAnimalType;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Mammal',
              style: AppFonts.body2(color: AppColors.grayscale90)),
          trailing: Container(
            width: SizeConfig.widthMultiplier(context) * 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selectedAnimalType == 'Mammal'
                    ? AppColors.primary20
                    : AppColors.grayscale30,
                width: selectedAnimalType == 'Mammal' ? 6.0 : 1.0,
              ),
            ),
          ),
          onTap: () {
            setState(() {
              ref
                  .read(selectedAnimalTypeProvider.notifier)
                  .update((state) => 'Mammal');
              selectedAnimalType = 'Mammal';
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Oviparous',
              style: AppFonts.body2(color: AppColors.grayscale90)),
          trailing: Container(
            width: SizeConfig.widthMultiplier(context) * 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selectedAnimalType == 'Oviparous'
                    ? AppColors.primary20
                    : AppColors.grayscale30,
                width: selectedAnimalType == 'Oviparous' ? 6.0 : 1.0,
              ),
            ),
          ),
          onTap: () {
            setState(() {
              ref
                  .read(selectedAnimalTypeProvider.notifier)
                  .update((state) => 'Oviparous');
              selectedAnimalType = 'Oviparous';
            });
            Navigator.pop(context); // Close the modal sheet
          },
        ),

        // Add more radio buttons as needed
      ],
    );
  }
}
