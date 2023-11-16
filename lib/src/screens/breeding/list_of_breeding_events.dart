import 'package:flutter/material.dart';
import 'package:sulala_app/src/widgets/controls_and_buttons/buttons/primary_button.dart';
import 'package:sulala_app/src/screens/breeding/breeding_event_detail.dart';
import 'package:sulala_app/src/screens/breeding/create_breeding_event.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';

class BreedingEventVariables {
  final String eventNumber;
  final String sire;
  final String dam;
  final String partner;
  final String children;
  final String breedingDate;
  final String deliveryDate;
  final String notes;

  BreedingEventVariables({
    required this.eventNumber,
    required this.sire,
    required this.dam,
    required this.partner,
    required this.children,
    required this.breedingDate,
    required this.deliveryDate,
    required this.notes,
  });
}

List<BreedingEventVariables> breedingEvents = [];

class ListOfBreedingEvents extends StatefulWidget {
  final TextEditingController breedingNotesController;
  final TextEditingController breedingEventNumberController;
  final String selectedBreedSire;
  final String selectedBreedDam;
  final String selectedBreedPartner;
  final String selectedBreedChildren;
  final String selectedBreedingDate;
  final String selectedDeliveryDate;

  const ListOfBreedingEvents({
    super.key,
    required this.breedingNotesController,
    required this.breedingEventNumberController,
    required this.selectedBreedSire,
    required this.selectedBreedDam,
    required this.selectedBreedPartner,
    required this.selectedBreedChildren,
    required this.selectedBreedingDate,
    required this.selectedDeliveryDate,
  });

  @override
  State<ListOfBreedingEvents> createState() => _ListOfBreedingEvents();
}

class _ListOfBreedingEvents extends State<ListOfBreedingEvents> {
  @override
  void initState() {
    super.initState();
    // Add the initial breeding event to the list
    if (widget.breedingEventNumberController.text.isNotEmpty) {
      addBreedingEvent(widget.breedingEventNumberController.text);
    }
  }

  void addBreedingEvent(String eventNumber) {
    final breedingEvent = BreedingEventVariables(
      eventNumber: eventNumber,
      sire: widget.selectedBreedSire,
      dam: widget.selectedBreedDam,
      partner: widget.selectedBreedPartner,
      children: widget.selectedBreedChildren,
      breedingDate: widget.selectedBreedingDate,
      deliveryDate: widget.selectedDeliveryDate,
      notes: widget.breedingNotesController.text,
    );

    setState(() {
      breedingEvents.insert(0, breedingEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: Text(
          'Harry',
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateBreedingEvents(
                        selectedAnimalType: '',
                        selectedAnimalSpecies: '',
                        selectedAnimalBreed: '',
                      ),
                    ),
                  ).then((_) {
                    // When returning from CreateBreedingEvents, add the new event
                    if (widget.breedingEventNumberController.text.isNotEmpty) {
                      addBreedingEvent(
                          widget.breedingEventNumberController.text);
                    }
                  });
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: 16 * globals.widthMediaQuery,
          left: 16 * globals.widthMediaQuery,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Breeding History',
                style: AppFonts.title3(color: AppColors.grayscale90)),
            SizedBox(
              height: 16 * globals.heightMediaQuery,
            ),
            breedingEvents.isEmpty
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/illustrations/child_x.png'),
                          SizedBox(
                            height: 32 * globals.heightMediaQuery,
                          ),
                          Text(
                            'No Breeding Events Yet',
                            style: AppFonts.headline3(
                                color: AppColors.grayscale90),
                          ),
                          SizedBox(
                            height: 8 * globals.heightMediaQuery,
                          ),
                          Text(
                            'Add a breeding event to get started',
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                          SizedBox(
                            height: 140 * globals.heightMediaQuery,
                          ),
                          SizedBox(
                            height: 52 * globals.heightMediaQuery,
                            child: PrimaryButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateBreedingEvents(
                                      selectedAnimalType: '',
                                      selectedAnimalSpecies: '',
                                      selectedAnimalBreed: '',
                                    ),
                                  ),
                                ).then((_) {
                                  // When returning from CreateBreedingEvents, add the new event
                                  if (widget.breedingEventNumberController.text
                                      .isNotEmpty) {
                                    addBreedingEvent(widget
                                        .breedingEventNumberController.text);
                                  }
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

                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                breedingEvent.eventNumber,
                                style: AppFonts.body2(
                                    color: AppColors.grayscale90),
                              ),
                              trailing: const Icon(Icons.chevron_right_rounded),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BreedingEventDetails(
                                      breedingEvent:
                                          breedingEvent, // Pass the selected event
                                    ),
                                  ),
                                );
                              },
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
