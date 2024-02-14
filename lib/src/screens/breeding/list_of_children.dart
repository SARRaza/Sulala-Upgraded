import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../data/globals.dart';
import '../../data/providers/animal_list_provider.dart';
import '../../data/providers/breeding_event_list_provider.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';

class BreedingEventChildrenList extends ConsumerStatefulWidget {
  final String animalId;

  const BreedingEventChildrenList({
    Key? key,
    required this.animalId,
  }) : super(key: key);

  @override
  ConsumerState<BreedingEventChildrenList> createState() =>
      _BreedingEventChildrenListState();
}

class _BreedingEventChildrenListState
    extends ConsumerState<BreedingEventChildrenList> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(animalListProvider).when(
        error: (error, trace) =>
            Scaffold(body: Center(child: Text('Error: $error'))),
        loading: () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        data: (animals) {
          final animal = animals
              .firstWhereOrNull((animal) => animal.id == widget.animalId);
          if (animal == null) {
            return Scaffold(body: Center(child: Text('Animal not found'.tr)));
          }

          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0.0,
              centerTitle: true,
              title: Text(
                animal.animalName,
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
              child: ref.watch(breedingEventListProvider(widget.animalId)).when(
                  error: (error, trace) => Text('Error: $error'),
                  loading: () => const CircularProgressIndicator(),
                  data: (events) {
                    final breedingEvents = events
                        .where((event) =>
                            event.sire?.animalId == animal.id ||
                            event.dam?.animalId == animal.id)
                        .toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'List Of Children'.tr,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'eventNumber'.trParams({
                                          'number': breedingEvent
                                                  .eventNumber.isNotEmpty
                                              ? breedingEvent.eventNumber
                                              : 'empty'.tr
                                        }),
                                        style: AppFonts.caption1(
                                            color: AppColors.grayscale80),
                                      ),
                                      if (breedingEvent.breedingDate != null)
                                        Text(
                                          DateFormat('dd/MM/yyyy').format(
                                              breedingEvent.breedingDate!),
                                          style: AppFonts.caption2(
                                              color: AppColors.grayscale80),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8 *
                                        SizeConfig.heightMultiplier(context),
                                  ),

                                  // Display the list of children
                                  if (breedingEvent.children.isNotEmpty)
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: breedingEvent.children.length,
                                      itemBuilder: (context, index) {
                                        final child =
                                            breedingEvent.children[index];
                                        return ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading: CircleAvatar(
                                            radius: 24 *
                                                SizeConfig.widthMultiplier(
                                                    context),
                                            backgroundColor: Colors.transparent,
                                            backgroundImage:
                                                child.selectedOviImage,
                                            child: child.selectedOviImage ==
                                                    null
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
                                          subtitle:
                                              child.selectedOviGender.isEmpty
                                                  ? Text(
                                                      'Gender Not Selected'.tr,
                                                      style: AppFonts.body2(
                                                          color: AppColors
                                                              .grayscale70),
                                                    )
                                                  : Text(
                                                      child.selectedOviGender,
                                                      style: AppFonts.body2(
                                                          color: AppColors
                                                              .grayscale70),
                                                    ),
                                          trailing: Text(
                                            'ID #${child.animalId}',
                                            style: AppFonts.body2(
                                                color: AppColors.grayscale90),
                                          ),
                                        );
                                      },
                                    )
                                  else
                                    Text(
                                        'No children recorded for this breeding event.'
                                            .tr),
                                  SizedBox(
                                    height: 16 *
                                        SizeConfig.heightMultiplier(context),
                                  ),
                                ],
                              );
                            },
                          ),
                        ref.watch(animalListProvider).when(
                            error: (error, trace) => Text(error.toString()),
                            loading: () => const CircularProgressIndicator(),
                            data: (animals) {
                              final otherChildren = animals
                                  .where((animal) =>
                                      (animal.selectedOviSire?.animalId ==
                                              animal.id ||
                                          animal.selectedOviDam?.animalId ==
                                              animal.id) &&
                                      !breedingEvents.any((event) =>
                                          event.children.firstWhereOrNull(
                                              (child) =>
                                                  child.animalId ==
                                                  animal.id) !=
                                          null))
                                  .toList();
                              return otherChildren.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Children without breeding events:'
                                                  .tr,
                                              style: AppFonts.caption1(
                                                  color: AppColors.grayscale80),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8 *
                                              SizeConfig.heightMultiplier(
                                                  context),
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
                                                radius: 24 *
                                                    SizeConfig.widthMultiplier(
                                                        context),
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage:
                                                    child.selectedOviImage,
                                                child: child.selectedOviImage ==
                                                        null
                                                    ? const Icon(
                                                        Icons
                                                            .camera_alt_outlined,
                                                        size: 50,
                                                        color: Colors.grey,
                                                      )
                                                    : null,
                                              ),
                                              title: Text(
                                                child.animalName,
                                                style: AppFonts.headline3(
                                                    color:
                                                        AppColors.grayscale90),
                                              ),
                                              // ignore: unnecessary_null_comparison
                                              subtitle: child
                                                      .selectedOviGender.isEmpty
                                                  ? Text(
                                                      'Gender Not Selected'.tr,
                                                      style: AppFonts.body2(
                                                          color: AppColors
                                                              .grayscale70),
                                                    )
                                                  : Text(
                                                      child.selectedOviGender,
                                                      style: AppFonts.body2(
                                                          color: AppColors
                                                              .grayscale70),
                                                    ),
                                              trailing: Text(
                                                'ID #${child.id}',
                                                style: AppFonts.body2(
                                                    color:
                                                        AppColors.grayscale90),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 16 *
                                              SizeConfig.heightMultiplier(
                                                  context),
                                        ),
                                      ],
                                    )
                                  : Container();
                            }),
                        if (breedingEvents.isEmpty &&
                            (ref.watch(animalListProvider).value ?? []).isEmpty)
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 151 *
                                      SizeConfig.heightMultiplier(context),
                                ),
                                Image.asset(
                                    'assets/illustrations/cow_child.png'),
                                SizedBox(
                                    height: 32 *
                                        SizeConfig.heightMultiplier(context)),
                                Text(
                                  'No Children'.tr,
                                  style: AppFonts.headline3(
                                      color: AppColors.grayscale90),
                                ),
                                SizedBox(
                                  height:
                                      8 * SizeConfig.heightMultiplier(context),
                                ),
                                Text(
                                  "This selectedAnimal doesn't have children."
                                      .tr,
                                  style: AppFonts.body2(
                                      color: AppColors.grayscale70),
                                ),
                                Text(
                                  "Add a child to see it here.".tr,
                                  style: AppFonts.body2(
                                      color: AppColors.grayscale70),
                                ),
                                SizedBox(
                                  height: 125 *
                                      SizeConfig.heightMultiplier(context),
                                ),
                                SizedBox(
                                  width:
                                      130 * SizeConfig.widthMultiplier(context),
                                  height:
                                      52 * SizeConfig.heightMultiplier(context),
                                  child: PrimaryButton(
                                    text: 'Add Children'.tr,
                                    onPressed: () {
                                      // Implement the logic to add children here
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    );
                  }),
            ),
          );
        });
  }
}
