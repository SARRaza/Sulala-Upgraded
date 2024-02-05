// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sulala_upgrade/src/widgets/animal_info_modal_sheets.dart/animal_children_modal.dart';
import '../../data/classes/breed_child_item.dart';
import '../../data/classes/breeding_event_variables.dart';
import '../../data/classes/breeding_partner.dart';
import '../../data/classes/main_animal_dam.dart';
import '../../data/classes/main_animal_sire.dart';
import '../../data/classes/ovi_variables.dart';
import '../../data/globals.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/animal_info_modal_sheets.dart/animal_partner_modal.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/paragraph_text_fields/paragraph_text_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'list_of_breeding_events.dart';

// ignore: depend_on_referenced_packages

class CreateBreedingEvents extends ConsumerStatefulWidget {
  final OviVariables OviDetails;
  final List<BreedingEventVariables> breedingEvents;

  const CreateBreedingEvents({
    super.key,
    required this.OviDetails,
    required this.breedingEvents,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CreateBreedingEvents createState() => _CreateBreedingEvents();
}

class _CreateBreedingEvents extends ConsumerState<CreateBreedingEvents> {
  final TextEditingController _breedingEventNumberController =
      TextEditingController();
  String selectedBreedDam = 'Add';
  BreedingPartner? selectedBreedPartner;
  String selectedDeliveryDate = '';
  List<BreedChildItem> selectedChildren = [];

  final TextEditingController _eggsNumberController = TextEditingController();

  final TextEditingController _layingEggsDateController =
      TextEditingController();

  final TextEditingController _incubationDateController =
      TextEditingController();

  final TextEditingController _hatchingDateController = TextEditingController();

  final TextEditingController _breedingDateController = TextEditingController();

  final TextEditingController _deliveryDateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  late final int eventId;

  @override
  void initState() {
    eventId = (DateTime.timestamp().millisecondsSinceEpoch / 1000000).round();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: 16.0 * SizeConfig.widthMultiplier(context),
                right: 16.0 * SizeConfig.widthMultiplier(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Event',
                  style: AppFonts.title3(color: AppColors.grayscale90),
                ),
                SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                PrimaryTextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    ref
                        .read(breedingEventNumberProvider.notifier)
                        .update((state) => value);
                  },
                  controller: _breedingEventNumberController,
                  hintText: 'Enter Breeding Number',
                  labelText: 'Breeding Number',
                ),
                SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breeding ID',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    Text(
                      eventId.toString(),
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breeding Partner',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    PrimaryTextButton(
                      status: TextStatus.idle,
                      text: selectedBreedPartner == null
                          ? 'Add'.tr
                          : "${selectedBreedPartner!.animalName} (ID: ${selectedBreedPartner!.id})",
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
                SizedBox(height: 10 * SizeConfig.heightMultiplier(context)),
                PrimaryDateField(
                  labelText: 'Breeding Date',
                  hintText: 'DD/MM/YYYY',
                  controller: _breedingDateController,
                  onChanged: (breedingDate) {
                    if (widget.OviDetails.selectedAnimalType == 'Mammal') {
                      _fillDeliveryDate(breedingDate,
                          widget.OviDetails.selectedAnimalSpecies);
                    } else if (widget.OviDetails.selectedAnimalType ==
                        'Oviparous') {
                      _fillDates(breedingDate,
                          widget.OviDetails.selectedAnimalSpecies);
                    }
                  },
                ),
                SizedBox(height: 20 * SizeConfig.heightMultiplier(context)),
                if (widget.OviDetails.selectedAnimalType == 'Mammal')
                  PrimaryDateField(
                    labelText: 'Delivery Date',
                    hintText: 'DD/MM/YYYY',
                    controller: _deliveryDateController,
                  ),
                if (widget.OviDetails.selectedAnimalType == 'Oviparous')
                  Column(
                    children: [
                      PrimaryDateField(
                        controller: _layingEggsDateController,
                        labelText: 'Date of laying eggs'.tr,
                        hintText: 'DD/MM/YYYY',
                      ),
                      PrimaryTextField(
                        controller: _eggsNumberController,
                        keyboardType: TextInputType.number,
                        labelText: 'Number of eggs'.tr,
                        hintText: '0',
                      ),
                      PrimaryDateField(
                        controller: _incubationDateController,
                        labelText: 'Incubation date'.tr,
                        hintText: 'DD/MM/YYYY',
                      ),
                      PrimaryDateField(
                        controller: _hatchingDateController,
                        labelText: 'Hatching date'.tr,
                        hintText: 'DD/MM/YYYY',
                      ),
                    ],
                  ),
                SizedBox(height: 34 * SizeConfig.heightMultiplier(context)),
                Text(
                  "Children",
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: selectedChildren.length,
                  itemBuilder: (context, index) {
                    final BreedChildItem child = selectedChildren[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: SizeConfig.widthMultiplier(context) * 24,
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
                        style: AppFonts.headline4(color: AppColors.grayscale90),
                      ),
                      subtitle: Text(
                        child.selectedOviGender,
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                      trailing: Text(
                        'ID#${child.id}',
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    _showBreedChildrenSelectionSheet(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        "Add Children",
                        style: AppFonts.body1(color: AppColors.primary40),
                      ),
                      const Icon(Icons.add, color: AppColors.primary40),
                    ],
                  ),
                ),
                SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                Text(
                  "Notes",
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                SizedBox(height: 20 * SizeConfig.heightMultiplier(context)),
                ParagraphTextField(
                  hintText: 'Add Notes',
                  maxLines: 6,
                  onChanged: (value) {
                    ref
                        .read(breedingnotesProvider.notifier)
                        .update((state) => value);
                  },
                ),
                SizedBox(height: 85 * SizeConfig.heightMultiplier(context)),
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          height: 52 * SizeConfig.heightMultiplier(context),
          width: 343 * SizeConfig.widthMultiplier(context),
          child: PrimaryButton(
            onPressed: () {
              _createBreedingEvent();
              Navigator.pop(context);
            },
            text: 'Create Event',
          ),
        ),
      ),
    );
  }

  void _showBreedChildrenSelectionSheet(BuildContext context) async {
    // Initialize an empty list
    final ovianimals = ref.read(ovianimalsProvider);

    final newSelectedChildren = await showModalBottomSheet(
      context: context,
      showDragHandle: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AnimalChildrenModal(
          selectedAnimal: widget.OviDetails,
          selectedFather: widget.OviDetails.selectedOviSire,
          selectedMother: widget.OviDetails.selectedOviDam,
          selectedChildren: selectedChildren,
          selectedPartner: selectedBreedPartner,
        );
      },
    );
    if (newSelectedChildren != null) {
      setState(() {
        selectedChildren = newSelectedChildren;
      });
    }
  }

  void _showBreedPartnerSelectionSheet(BuildContext context) async {
    // Initialize an empty list
    final ovianimals = ref.read(ovianimalsProvider);

    final selectedPartner = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimalPartnerModal(
          selectedPartner: selectedBreedPartner,
          selectedAnimal: widget.OviDetails,
          selectedFather: widget.OviDetails.selectedOviSire,
          selectedMother: widget.OviDetails.selectedOviDam,
          selectedChildren: selectedChildren,
        );
      },
    );
    if (selectedPartner != null) {
      setState(() {
        selectedBreedPartner = selectedPartner;
      });
    }
  }

  // void _showBreedPartnerSelectionSheet() {
  //   double sheetHeight = MediaQuery.of(context).size.height * 0.5;

  //   TextEditingController searchController = TextEditingController();
  //   List<Map<String, String>> filteredbreedPartner = List.from(breedPartner);

  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           return SizedBox(
  //             height: sheetHeight,
  //             child: Column(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(16.0),
  //                   child: TextField(
  //                     controller: searchController,
  //                     onChanged: (value) {
  //                       setState(() {
  //                         filteredbreedPartner = breedPartner
  //                             .where((partner) => partner['name']!
  //                                 .toLowerCase()
  //                                 .contains(value.toLowerCase()))
  //                             .toList();
  //                       });
  //                     },
  //                     decoration: const InputDecoration(
  //                       hintText: "Search Partner",
  //                       prefixIcon: Icon(Icons.search),
  //                     ),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: ListView.builder(
  //                     itemCount: filteredbreedPartner.length,
  //                     itemBuilder: (context, index) {
  //                       return ListTile(
  //                         leading: const CircleAvatar(
  //                           backgroundColor: Colors.green,
  //                         ),
  //                         title: Text(filteredbreedPartner[index]['name']!),
  //                         onTap: () {
  //                           final selectedPartner =
  //                               filteredbreedPartner[index]['name']!;
  //                           ref
  //                               .read(breedingPartnerDetailsProvider.notifier)
  //                               .update((state) => selectedPartner);
  //                           Navigator.pop(context);
  //                         },
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // final List<Map<String, String>> breedPartner = [
  //   {'name': 'Alice'},
  //   {'name': 'John'},
  //   {'name': 'Jack'},
  //   {'name': 'Kiran'},
  //   {'name': 'Mantic'},
  //   {'name': 'Mongolia'},
  //   // Add more country codes and names as needed
  // ];

  void _createBreedingEvent() {
    final numOffEggs = _eggsNumberController.text;
    final partner = selectedBreedPartner;
    final children = selectedChildren;
    final ovianimals = ref.read(ovianimalsProvider);

    MainAnimalSire? sire;
    MainAnimalDam? dam;
    if (widget.OviDetails.selectedOviGender == 'Male') {
      sire = MainAnimalSire(
          widget.OviDetails.animalName,
          widget.OviDetails.selectedOviImage,
          widget.OviDetails.selectedOviGender);
      if (partner != null) {
        dam = MainAnimalDam(partner.animalName, partner.selectedOviImage,
            partner.selectedOviGender);
      }
    } else {
      if (partner != null) {
        sire = MainAnimalSire(partner.animalName, partner.selectedOviImage,
            partner.selectedOviGender);
      }
      dam = MainAnimalDam(
          widget.OviDetails.animalName,
          widget.OviDetails.selectedOviImage,
          widget.OviDetails.selectedOviGender);
    }

    for (var child in children) {
      final childIndex =
          ovianimals.indexWhere((animal) => animal.id == child.id);
      ref.read(ovianimalsProvider)[childIndex] = ref
          .read(ovianimalsProvider)[childIndex]
          .copyWith(selectedOviSire: sire, selectedOviDam: dam);
    }

    final breedingEvent = BreedingEventVariables(
        id: eventId,
        eventNumber: _breedingEventNumberController.text,
        breedDam: dam?.selectedOviImage,
        sire: sire,
        dam: dam,
        partner: partner,
        children: children,
        breedingDate:
            DateFormat('dd/MM/yyyy').parse(_breedingDateController.text),
        deliveryDate:
            DateFormat('dd/MM/yyyy').parse(_deliveryDateController.text),
        layingEggsDate:
            DateFormat('dd/MM/yyyy').parse(_layingEggsDateController.text),
        eggsNumber: numOffEggs.isNotEmpty ? int.parse(numOffEggs) : 0,
        incubationDate:
            DateFormat('dd/MM/yyyy').parse(_incubationDateController.text),
        hatchingDate:
            DateFormat('dd/MM/yyyy').parse(_hatchingDateController.text),
        notes: _notesController.text,
        shouldAddEvent: true);

    ref.read(breedingEventsProvider).add(breedingEvent);
  }

  void _fillDeliveryDate(DateTime breedingDate, String animalSpecies) {
    final deliveryDate =
        breedingDate.add(Duration(days: gestationPeriods[animalSpecies]!));
    _deliveryDateController.text =
        DateFormat('dd/MM/yyyy').format(deliveryDate);
  }

  void _fillDates(DateTime breedingDate, String animalSpecies) {
    final layingDate = breedingDate
        .add(Duration(days: breedingToLayingPeriods[animalSpecies]!));
    final formattedLayingDate = DateFormat('dd/MM/yyyy').format(layingDate);
    _layingEggsDateController.text = formattedLayingDate;
    _incubationDateController.text = formattedLayingDate;
    final hatchingDate =
        layingDate.add(Duration(days: incubationPeriods[animalSpecies]!));
    _hatchingDateController.text =
        DateFormat('dd/MM/yyyy').format(hatchingDate);
  }
}
