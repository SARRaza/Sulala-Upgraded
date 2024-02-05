// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/widgets/styled_dismissible.dart';
import '../../data/classes/breeding_event_variables.dart';
import '../../data/classes/ovi_variables.dart';
import '../../data/globals.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/dialogs/confirm_delete_dialog.dart';
import '../create_animal/owned_animal_detail_reg_mode.dart';
import 'breeding_event_detail.dart';
import 'create_breeding_event.dart';

class ListOfBreedingEvents extends ConsumerStatefulWidget {
  // final TextEditingController breedingNotesController;
  // final TextEditingController breedingEventNumberController;
  // final String selectedBreedSire;
  // final String selectedBreedDam;
  // final String selectedBreedPartner;
  // // final String selectedBreedChildren;
  // final String selectedBreedingDate;
  // final String selectedDeliveryDate;
  final bool shouldAddBreedEvent;
  final OviVariables OviDetails;
  final List<BreedingEventVariables> breedingEvents;

  const ListOfBreedingEvents(
      {super.key,
      // required this.breedingNotesController,
      // required this.breedingEventNumberController,
      // required this.selectedBreedSire,
      // required this.selectedBreedDam,
      // required this.selectedBreedPartner,
      // // required this.selectedBreedChildren,
      // required this.selectedBreedingDate,
      // required this.selectedDeliveryDate,
      required this.shouldAddBreedEvent,
      required this.OviDetails,
      required this.breedingEvents});

  @override
  ConsumerState<ListOfBreedingEvents> createState() => _ListOfBreedingEvents();
}

class _ListOfBreedingEvents extends ConsumerState<ListOfBreedingEvents> {
  String filterQuery = '';

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
    final breedingEvents = ref
        .read(breedingEventsProvider)
        .where((event) =>
            event.sire?.id == widget.OviDetails.id ||
            event.dam?.id == widget.OviDetails.id)
        .toList();

    // Filter the breeding events based on the query
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.OviDetails.animalName,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.grayscale10,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () async {
                  ref
                      .read(breedingDateProvider.notifier)
                      .update((state) => null);
                  ref
                      .read(deliveryDateProvider.notifier)
                      .update((state) => null);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateBreedingEvents(
                        OviDetails: widget.OviDetails,
                        breedingEvents: widget.breedingEvents,
                      ),
                    ),
                  );
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: 16 * SizeConfig.widthMultiplier(context),
          left: 16 * SizeConfig.widthMultiplier(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Breeding History',
                style: AppFonts.title3(color: AppColors.grayscale90)),
            SizedBox(
              height: 16 * SizeConfig.heightMultiplier(context),
            ),
            breedingEvents.isEmpty
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/illustrations/child_x.png'),
                          SizedBox(
                            height: 32 * SizeConfig.heightMultiplier(context),
                          ),
                          Text(
                            'No Breeding Events Yet',
                            style: AppFonts.headline3(
                                color: AppColors.grayscale90),
                          ),
                          SizedBox(
                            height: 8 * SizeConfig.heightMultiplier(context),
                          ),
                          Text(
                            'Add a breeding event to get started',
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                          SizedBox(
                            height: 140 * SizeConfig.heightMultiplier(context),
                          ),
                          SizedBox(
                            height: 52 * SizeConfig.heightMultiplier(context),
                            child: PrimaryButton(
                              onPressed: () {
                                ref
                                    .read(breedingDateProvider.notifier)
                                    .update((state) => null);
                                ref
                                    .read(deliveryDateProvider.notifier)
                                    .update((state) => null);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateBreedingEvents(
                                      OviDetails: widget.OviDetails,
                                      breedingEvents: widget.breedingEvents,
                                    ),
                                  ),
                                ).then((shouldAddBreedingEvent) {
                                  setState(() {});
                                });
                              },
                              text: 'Add Breeding Event',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: breedingEvents.length,
                      itemBuilder: (context, index) {
                        final breedingEvent = breedingEvents[index];

                        return StyledDismissible(
                          confirmDismiss: _confirmEventDeletion,
                          onDismissed: (direction) {
                            // Handle item dismissal here
                            setState(() {
                              breedingEvents.removeAt(index);
                              ref
                                  .read(breedingEventsProvider.notifier)
                                  .update((state) => breedingEvents);
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BreedingEventDetails(
                                        breedingEvents: breedingEvents,
                                        OviDetails: widget.OviDetails,
                                        breedingEvent: breedingEvent,
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    breedingEvent.eventNumber.isEmpty
                                        ? const Text('New Event')
                                        : Text(
                                            breedingEvent.eventNumber,
                                            style: AppFonts.body2(
                                                color: AppColors.grayscale90),
                                          ),
                                    const Icon(
                                      Icons.chevron_right_rounded,
                                      color: AppColors.grayscale50,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 25,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _confirmEventDeletion(DismissDirection direction) async {
    // Show a confirmation dialog
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDeleteDialog(
          content: 'Are you sure you want to delete this breeding event?'.tr,
        );
      },
    );
  }
}
