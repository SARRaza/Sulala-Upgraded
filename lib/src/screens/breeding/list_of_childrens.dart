// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../data/classes/ovi_variables.dart';
import '../../data/globals.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
// import 'path_to_breeding_event_file.dart';

class BreedingEventChildrenList extends ConsumerStatefulWidget {
  final OviVariables OviDetails;

  const BreedingEventChildrenList({
    Key? key,
    required this.OviDetails,
  }) : super(key: key);

  @override
  ConsumerState<BreedingEventChildrenList> createState() =>
      _BreedingEventChildrenListState();
}

class _BreedingEventChildrenListState
    extends ConsumerState<BreedingEventChildrenList> {
  @override
  Widget build(BuildContext context) {
    final animalIndex = ref.read(ovianimalsProvider).indexWhere(
        (animal) => animal.animalName == widget.OviDetails.animalName);

    if (animalIndex == -1) {
      // Animal not found, you can show an error message or handle it accordingly
      return const Center(
        child: Text('Animal not found.'),
      );
    }
    final selectedAnimal = ref.read(ovianimalsProvider)[animalIndex];
    final breedingEvents = ref
        .read(breedingEventsProvider)
        .where((event) =>
            event.sire?.id == widget.OviDetails.id ||
            event.dam?.id == widget.OviDetails.id)
        .toList();

    final otherChildren = ref
        .read(ovianimalsProvider)
        .where((animal) =>
            (animal.selectedOviSire?.id == selectedAnimal.id ||
                animal.selectedOviDam?.id == selectedAnimal.id) &&
            !breedingEvents.any((event) =>
                event.children
                    .firstWhereOrNull((child) => child.id == animal.id) !=
                null))
        .toList();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: Text(
          selectedAnimal.animalName,
          style: AppFonts.headline3(color: AppColors.grayscale90),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.grayscale10,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            right: 16 * SizeConfig.widthMultiplier(context),
            left: 16 * SizeConfig.widthMultiplier(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'List Of Children',
              style: AppFonts.title3(color: AppColors.grayscale90),
            ),
            SizedBox(
              height: 16 * SizeConfig.heightMultiplier(context),
            ),
            if (breedingEvents.isNotEmpty)
              ListView.builder(
                itemCount: breedingEvents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final breedingEvent = breedingEvents[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Event Number: ${breedingEvent.eventNumber.isNotEmpty ? breedingEvent.eventNumber : 'empty'.tr}',
                            style:
                                AppFonts.caption1(color: AppColors.grayscale80),
                          ),
                          if (breedingEvent.breedingDate != null)
                            Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(breedingEvent.breedingDate!),
                              style: AppFonts.caption2(
                                  color: AppColors.grayscale80),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 8 * SizeConfig.heightMultiplier(context),
                      ),

                      // Display the list of children
                      if (breedingEvent.children.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: breedingEvent.children.length,
                          itemBuilder: (context, index) {
                            final child = breedingEvent.children[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                radius:
                                    24 * SizeConfig.widthMultiplier(context),
                                backgroundColor: Colors.transparent,
                                backgroundImage: child.selectedOviImage,
                                child: child.selectedOviImage == null
                                    ? const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 50,
                                        color: Colors.grey,
                                      )
                                    : null,
                              ),
                              title: Text(
                                child.animalName,
                                style: AppFonts.headline3(
                                    color: AppColors.grayscale90),
                              ),
                              // ignore: unnecessary_null_comparison
                              subtitle: child.selectedOviGender.isEmpty
                                  ? Text(
                                      'Gender Not Selected',
                                      style: AppFonts.body2(
                                          color: AppColors.grayscale70),
                                    )
                                  : Text(
                                      child.selectedOviGender,
                                      style: AppFonts.body2(
                                          color: AppColors.grayscale70),
                                    ),
                              trailing: Text(
                                'ID #${child.id}',
                                style: AppFonts.body2(
                                    color: AppColors.grayscale90),
                              ),
                            );
                          },
                        )
                      else
                        const Text(
                            'No children recorded for this breeding event.'),
                      SizedBox(
                        height: 16 * SizeConfig.heightMultiplier(context),
                      ),
                    ],
                  );
                },
              ),
            if (otherChildren.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Children without breeding events:',
                        style: AppFonts.caption1(color: AppColors.grayscale80),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8 * SizeConfig.heightMultiplier(context),
                  ),
                  // Display the list of children
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: otherChildren.length,
                    itemBuilder: (context, index) {
                      final child = otherChildren[index];

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 24 * SizeConfig.widthMultiplier(context),
                          backgroundColor: Colors.transparent,
                          backgroundImage: child.selectedOviImage,
                          child: child.selectedOviImage == null
                              ? const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 50,
                                  color: Colors.grey,
                                )
                              : null,
                        ),
                        title: Text(
                          child.animalName,
                          style:
                              AppFonts.headline3(color: AppColors.grayscale90),
                        ),
                        // ignore: unnecessary_null_comparison
                        subtitle: child.selectedOviGender.isEmpty
                            ? Text(
                                'Gender Not Selected',
                                style: AppFonts.body2(
                                    color: AppColors.grayscale70),
                              )
                            : Text(
                                child.selectedOviGender,
                                style: AppFonts.body2(
                                    color: AppColors.grayscale70),
                              ),
                        trailing: Text(
                          'ID #${child.id}',
                          style: AppFonts.body2(color: AppColors.grayscale90),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 16 * SizeConfig.heightMultiplier(context),
                  ),
                ],
              ),
            if (breedingEvents.isEmpty && otherChildren.isEmpty)
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 151 * SizeConfig.heightMultiplier(context),
                    ),
                    Image.asset('assets/illustrations/cow_childx.png'),
                    SizedBox(height: 32 * SizeConfig.heightMultiplier(context)),
                    Text(
                      'No Children',
                      style: AppFonts.headline3(color: AppColors.grayscale90),
                    ),
                    SizedBox(
                      height: 8 * SizeConfig.heightMultiplier(context),
                    ),
                    Text(
                      "This selectedAnimal doesn’t have children.",
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    Text(
                      "Add a child to see it here.",
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    SizedBox(
                      height: 125 * SizeConfig.heightMultiplier(context),
                    ),
                    SizedBox(
                      width: 130 * SizeConfig.widthMultiplier(context),
                      height: 52 * SizeConfig.heightMultiplier(context),
                      child: PrimaryButton(
                        text: 'Add Children',
                        onPressed: () {
                          // Implement the logic to add children here
                        },
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
