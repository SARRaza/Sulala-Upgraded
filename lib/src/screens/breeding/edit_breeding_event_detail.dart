// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sulala_upgrade/src/widgets/animal_info_modal_sheets.dart/animal_partner_modal.dart';
import '../../data/classes.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/navigate_button.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/paragraph_text_fields/paragraph_text_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

import 'list_of_breeding_events.dart';

class EditBreedingEventDetails extends ConsumerStatefulWidget {
  final List<BreedingEventVariables> breedingEvents;
  final OviVariables OviDetails;
  final BreedingDetails? breedingDetails;
  final BreedingEventVariables breedingEvent;
  const EditBreedingEventDetails(
      {super.key,
      required this.breedingEvents,
      required this.breedingEvent,
      this.breedingDetails,
      required this.OviDetails});

  @override
  ConsumerState<EditBreedingEventDetails> createState() =>
      _EditBreedingEventDetailsState();
}

class _EditBreedingEventDetailsState
    extends ConsumerState<EditBreedingEventDetails> {
  TextEditingController breedingEventNumberController = TextEditingController();
  TextEditingController breedingDateController = TextEditingController();
  TextEditingController deliveryDateController = TextEditingController();
  TextEditingController breedingEventNotesController = TextEditingController();
  List<BreedChildItem> selectedChildren = [];
  BreedingPartner? breedPartner;
  String selectedBreedingDate = '';
  String selectedDeliveryDate = '';
  bool isFirstTimeSelection = true;

  late final TextEditingController _layingEggsDateController;

  late final TextEditingController _eggsNumberController;

  late final TextEditingController _incubationDateController;

  late final TextEditingController _hatchingDateController;

  bool initialized = false;

  @override
  void initState() {
    super.initState();
    breedingEventNumberController.text = widget.breedingEvent.eventNumber;

    selectedBreedingDate = widget.breedingEvent.breedingDate;
    selectedDeliveryDate = widget.breedingEvent.deliveryDate?? '';
    selectedChildren = widget.breedingEvent.children;
    breedingEventNotesController.text = widget.breedingEvent.notes;
    breedPartner = widget.breedingEvent.partner;
  }

  void _showBreedChildrenSelectionSheet(BuildContext context) async {
    // Initialize an empty list
    final ovianimals = ref.watch(ovianimalsProvider).where((animal) => animal.id
        != widget.OviDetails.id).toList();

    String searchQuery = '';

    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 1,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Select Children",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              border: Border.all(),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value.toLowerCase();
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: "Search By Name Or ID",
                                prefixIcon: Icon(Icons.search),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: ovianimals.length,
                        itemBuilder: (context, index) {
                          final OviDetails = ovianimals[index];

                          final bool isSelected =
                              // ignore: iterable_contains_unrelated_type
                              selectedChildren.contains(OviDetails.animalName);

                          // Apply the filter here
                          if (!OviDetails.animalName
                                  .toLowerCase()
                                  .contains(searchQuery) &&
                              !OviDetails.selectedAnimalType
                                  .toLowerCase()
                                  .contains(searchQuery)) {
                            return Container(); // Skip this item if it doesn't match the search query
                          }

                          return ListTile(
                            tileColor: isSelected
                                ? Colors.green.withOpacity(0.5)
                                : null,
                            shape: isSelected
                                ? RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  )
                                : null,
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey[100],
                              backgroundImage: OviDetails.selectedOviImage,
                              child: OviDetails.selectedOviImage == null
                                  ? const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 50,
                                      color: Colors.grey,
                                    )
                                  : null,
                            ),
                            title: Text(OviDetails.animalName),
                            subtitle: Text(OviDetails.selectedAnimalType),
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedChildren.removeWhere(
                                    (child) =>
                                        child.animalName ==
                                        OviDetails.animalName,
                                  );
                                } else {
                                  // Use a default image (icon) if selectedOviImage is null
                                  final ImageProvider? oviImage =
                                      OviDetails.selectedOviImage;

                                  selectedChildren.add(BreedChildItem(
                                    OviDetails.animalName,
                                    oviImage,
                                    OviDetails.selectedOviGender,
                                  ));
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(breedingChildrenDetailsProvider.notifier)
                            .update((state) => selectedChildren);
                        Navigator.pop(context);
                        // Append the selected children to the existing list
                        final List<BreedChildItem> existingSelectedChildren =
                            ref.read(breedingChildrenDetailsProvider);
                        existingSelectedChildren.addAll(selectedChildren);
                      },
                      child: const Text("Done"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showBreedPartnerSelectionSheet(BuildContext context) async {
    // Initialize an empty list
    final ovianimals = ref.watch(ovianimalsProvider);


    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimalPartnerModal(ovianimals: ovianimals.where(
                (animal) => animal.id != widget.OviDetails.id && animal
                    .selectedAnimalSpecies == widget.OviDetails
                    .selectedAnimalSpecies).toList());
      },
    );
  }

  void setBreedingSelectedDate(DateTime breedingDate) {
    setState(() {
      // Format the date as needed and update the local variable
      selectedBreedingDate = DateFormat('dd/MM/yyyy').format(breedingDate);
    });
  }

  void setDeliverySelectedDate(DateTime Deliverydate) {
    setState(() {
      // Format the date as needed and update the local variable
      selectedDeliveryDate = DateFormat('dd/MM/yyyy').format(Deliverydate);
    });
  }

  void setLayingEggsSelectedDate(DateTime layingEggsDate) {
    ref.read(dateOfLayingEggsProvider.notifier).update((state) {
      // Format the date as needed before updating the state
      state = DateFormat('dd/MM/yyyy').format(layingEggsDate);
      return state;
    });
  }

  void setEggsNumber(String eggsNumber) {
    ref.read(numOfEggsProvider.notifier).update((state) {
      state = eggsNumber;
      return state;
    });
  }

  void setIncubationSelectedDate(DateTime incubationDate) {
    ref.read(incubationDateProvider.notifier).update((state) {
      // Format the date as needed before updating the state
      state = DateFormat('dd/MM/yyyy').format(incubationDate);
      return state;
    });
  }

  void setHatchingSelectedDate(DateTime hatchingDate) {
    ref.read(dateOfHatchingProvider.notifier).update((state) {
      state = hatchingDate;
      return state;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedbreedPartner = ref.watch(breedingPartnerDetailsProvider);
    if(!initialized) {
      _layingEggsDateController = TextEditingController(text: widget.breedingEvent
          .layingEggsDate);
      _eggsNumberController = TextEditingController(text: widget.breedingEvent
          .eggsNumber.toString());
      _incubationDateController = TextEditingController(text: widget.breedingEvent
          .incubationDate);
      _hatchingDateController = TextEditingController(text: widget.breedingEvent
          .hatchingDate);
      initialized = true;
    }


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          title: Text(
            widget.OviDetails.animalName,
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
          padding:
              EdgeInsets.symmetric(horizontal: 16 * globals.widthMediaQuery),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  breedingEventNumberController.text,
                  style: AppFonts.title3(
                    color: AppColors.grayscale90,
                  ),
                ),
                SizedBox(
                  height: 24 * globals.heightMediaQuery,
                ),
                PrimaryTextField(
                  controller: breedingEventNumberController,
                  hintText: 'Edit Breeding Event',
                  labelText: 'Breeding Event',
                ),
                SizedBox(
                  height: 26 * globals.heightMediaQuery,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breeding ID',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    Text(
                      '001-1',
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                  ],
                ),
                SizedBox(
                  height: 26 * globals.heightMediaQuery,
                ),
                PrimaryDateField(
                  labelText: 'Breeding Date',
                  hintText: selectedBreedingDate.isNotEmpty
                      ? selectedBreedingDate
                      : "DD/MM/YYYY",
                  onChanged: (value) {
                    // Assuming value is a DateTime
                    setBreedingSelectedDate(value);
                  },
                ),
                SizedBox(
                  height: 20 * globals.heightMediaQuery,
                ),
                if (widget.OviDetails.selectedAnimalType == 'Mammal')
                  PrimaryDateField(
                  labelText: 'Delivery Date',
                  hintText: selectedDeliveryDate.isNotEmpty
                      ? selectedDeliveryDate
                      : "DD/MM/YYYY",
                  onChanged: (value) {
                    setDeliverySelectedDate(value);
                  },
                ),
                if (widget.OviDetails.selectedAnimalType == 'Oviparous')
                  Column(
                    children: [
                      PrimaryDateField(
                        controller: _layingEggsDateController,
                        labelText: 'Date of laying eggs'.tr,
                        hintText: 'DD/MM/YYYY',
                        onChanged: (value) {
                          setLayingEggsSelectedDate(value);
                        },
                      ),
                      PrimaryTextField(
                        controller: _eggsNumberController,
                        keyboardType: TextInputType.number,
                        labelText: 'Number of eggs'.tr,
                        hintText: '0',
                        onChanged: (value) {
                          setEggsNumber(value);
                        },
                      ),
                      PrimaryDateField(
                        controller: _incubationDateController,
                        labelText: 'Incubation date'.tr,
                        hintText: 'DD/MM/YYYY',
                        onChanged: (value) {
                          setIncubationSelectedDate(value);
                        },
                      ),
                      PrimaryDateField(
                        controller: _hatchingDateController,
                        labelText: 'Hatching date'.tr,
                        hintText: 'DD/MM/YYYY',
                        onChanged: (value) {
                          setHatchingSelectedDate(value);
                        },
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20 * globals.heightMediaQuery,
                ),
                const Divider(),
                SizedBox(
                  height: 10 * globals.heightMediaQuery,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breeding Partner',
                      style: AppFonts.title5(color: AppColors.grayscale90),
                    ),
                    PrimaryTextButton(
                      status: TextStatus.idle,
                      text: selectedbreedPartner?? 'Add'.tr,
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const SearchBreedingPartner(),
                        //     ));
                        _showBreedPartnerSelectionSheet(context);
                      },
                      position: TextButtonPosition.right,
                    ),
                  ],
                ),
                SizedBox(
                  height: 16 * globals.heightMediaQuery,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: breedPartner != null ? 1 : 0,
                  itemBuilder: (context, index) {
                    final partner = breedPartner!;
                    return ListTile(
                      onTap: () {},
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: globals.widthMediaQuery * 24,
                        backgroundColor: Colors.transparent,
                        backgroundImage: partner.selectedOviImage,
                        child: partner.selectedOviImage == null
                            ? const Icon(
                                Icons.camera_alt_outlined,
                                size: 50,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      title: Text(
                        partner.animalName,
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      ),
                      subtitle: Text(
                        partner.selectedOviGender,
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                      trailing: Text(
                        'ID#${partner.id}',
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                    );
                  },
                ),
                const Divider(),
                SizedBox(
                  height: 6 * globals.heightMediaQuery,
                ),
                Text(
                  "Children",
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: 16 * globals.heightMediaQuery,
                ),
                selectedChildren.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 8 * globals.heightMediaQuery,
                          ),
                          Center(
                              child: Image.asset(
                                  'assets/illustrations/cow_childx.png')),
                        ],
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: selectedChildren.length,
                        itemBuilder: (context, index) {
                          final child = selectedChildren[index];
                          return ListTile(
                            onTap: () {},
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: globals.widthMediaQuery * 24,
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
                            subtitle: Text(
                              child.selectedOviGender,
                              style:
                                  AppFonts.body2(color: AppColors.grayscale70),
                            ),
                            trailing: Text(
                              'ID#${child.id}',
                              style:
                                  AppFonts.body2(color: AppColors.grayscale70),
                            ),
                          );
                        },
                      ),
                InkWell(
                  onTap: () {
                    _showBreedChildrenSelectionSheet(context);
                  },
                  child: Row(
                    children: [
                      const PrimaryTextButton(
                        status: TextStatus.idle,
                        text: 'Add Children',
                      ),
                      SizedBox(
                        width: 8 * globals.widthMediaQuery,
                      ),
                      Icon(
                        Icons.add_rounded,
                        color: AppColors.primary40,
                        size: 20 * globals.widthMediaQuery,
                      )
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 24 * globals.heightMediaQuery,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Notes",
                      style: AppFonts.title5(color: AppColors.grayscale90),
                    ),
                    InkWell(
                        onTap: () {},
                        child:
                            Image.asset('assets/icons/frame/24px/24_Edit.png'))
                  ],
                ),
                SizedBox(
                  height: 16 * globals.heightMediaQuery,
                ),
                ParagraphTextField(
                  controller: breedingEventNotesController,
                  hintText: 'Add Notes'.tr,
                  maxLines: 6,
                ),
                SizedBox(
                  height: 100 * globals.heightMediaQuery,
                ),
                SizedBox(
                  height: 52 * globals.heightMediaQuery,
                  width: 343 * globals.widthMediaQuery,
                  child: PrimaryButton(
                    text: 'Save Changes',
                    onPressed: () {
                      final updatedBreedingEventDetails =
                          widget.breedingEvent.copyWith(
                        eventNumber: breedingEventNumberController.text,
                        breedingDate: selectedBreedingDate,
                        deliveryDate: selectedDeliveryDate,
                        layingEggsDate: _layingEggsDateController.text,
                        eggsNumber: _eggsNumberController.text.isNum ? int
                            .parse(_eggsNumberController.text) : null,
                        incubationDate: _incubationDateController.text,
                        hatchingDate: _hatchingDateController.text,
                        partner: breedPartner,
                        children: selectedChildren,
                              notes: breedingEventNotesController.text
                      );
                      final animalIndex = ref
                          .read(ovianimalsProvider)
                          .indexWhere((animal) =>
                              animal.animalName ==
                              widget.OviDetails.animalName);


                        ref.read(ovianimalsProvider.notifier).update((state)
                        {
                          final animal = state[animalIndex];
                          final events = animal.breedingEvents[animal
                              .animalName];
                          final eventIndex = events!.indexWhere((event) => event
                              .eventNumber == widget.breedingEvent.eventNumber);
                          events[eventIndex] = updatedBreedingEventDetails;
                          state[animalIndex] = state[animalIndex].copyWith(
                              breedingEvents: {animal.animalName: events});
                          return state;
                        });
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 8 * globals.heightMediaQuery,
                ),
                SizedBox(
                  height: 52 * globals.heightMediaQuery,
                  width: 343 * globals.widthMediaQuery,
                  child: NavigateButton(
                    text: 'Delete Event',
                    onPressed: deleteEvent,
                  ),
                ),
                SizedBox(
                  height: 16 * globals.heightMediaQuery,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteEvent() {
    final animalIndex = ref
        .read(ovianimalsProvider)
        .indexWhere((animal) =>
    animal.animalName ==
        widget.OviDetails.animalName);
    ref.read(ovianimalsProvider.notifier).update((state) {
      final animal = state[animalIndex];
      final events = animal.breedingEvents[animal
          .animalName];
      final eventIndex = events!.indexWhere((event) => event.eventNumber ==
          widget.breedingEvent.eventNumber);
      events.removeAt(eventIndex);
      return state;
    });
    Navigator.pop(context, {'eventDeleted': true});
  }
}
