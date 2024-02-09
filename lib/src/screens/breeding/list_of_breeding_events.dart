import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/widgets/styled_dismissible.dart';
import '../../data/classes/breeding_event_variables.dart';
import '../../data/classes/ovi_variables.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/dialogs/confirm_delete_dialog.dart';
import 'breeding_event_detail.dart';
import 'create_breeding_event.dart';

class ListOfBreedingEvents extends ConsumerStatefulWidget {
  final bool shouldAddBreedEvent;
  final OviVariables oviDetails;
  final List<BreedingEventVariables> breedingEvents;

  const ListOfBreedingEvents(
      {super.key,
      required this.shouldAddBreedEvent,
      required this.oviDetails,
      required this.breedingEvents});

  @override
  ConsumerState<ListOfBreedingEvents> createState() => _ListOfBreedingEvents();
}

class _ListOfBreedingEvents extends ConsumerState<ListOfBreedingEvents> {
  String filterQuery = '';

  @override
  Widget build(BuildContext context) {
    final breedingEvents = ref
        .read(breedingEventsProvider)
        .where((event) =>
            event.sire?.id == widget.oviDetails.id ||
            event.dam?.id == widget.oviDetails.id)
        .toList();

    // Filter the breeding events based on the query
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.oviDetails.animalName,
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
                        oviDetails: widget.oviDetails,
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
            Text('Breeding History'.tr,
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
                            'No Breeding Events Yet'.tr,
                            style: AppFonts.headline3(
                                color: AppColors.grayscale90),
                          ),
                          SizedBox(
                            height: 8 * SizeConfig.heightMultiplier(context),
                          ),
                          Text(
                            'Add a breeding event to get started'.tr,
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
                                      oviDetails: widget.oviDetails,
                                      breedingEvents: widget.breedingEvents,
                                    ),
                                  ),
                                ).then((shouldAddBreedingEvent) {
                                  setState(() {});
                                });
                              },
                              text: 'Add Breeding Event'.tr,
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
                                        oviDetails: widget.oviDetails,
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
                                        ? Text('New Event'.tr)
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
