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
import '../../widgets/controls_and_buttons/text_buttons/primary_text_button.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/paragraph_text_fields/paragraph_text_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';

class CreateBreedingEvents extends ConsumerStatefulWidget {
  final OviVariables oviDetails;
  final List<BreedingEventVariables> breedingEvents;

  const CreateBreedingEvents({
    super.key,
    required this.oviDetails,
    required this.breedingEvents,
  });

  @override
  ConsumerState<CreateBreedingEvents> createState() => _CreateBreedingEvents();
}

class _CreateBreedingEvents extends ConsumerState<CreateBreedingEvents> {
  final _breedingEventNumberController = TextEditingController();
  String selectedBreedDam = 'Add';
  BreedingPartner? selectedBreedPartner;
  String selectedDeliveryDate = '';
  List<BreedChildItem> selectedChildren = [];

  final _eggsNumberController = TextEditingController();

  final _layingEggsDateController = TextEditingController();

  final _incubationDateController = TextEditingController();

  final _hatchingDateController = TextEditingController();

  final _breedingDateController = TextEditingController();

  final _deliveryDateController = TextEditingController();
  final _notesController = TextEditingController();
  late final int eventId;

  @override
  void initState() {
    super.initState();
    eventId = (DateTime.timestamp().millisecondsSinceEpoch / 1000000).round();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          title: Text(
            widget.oviDetails.animalName,
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
                  'Create Event'.tr,
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
                  hintText: 'Enter Breeding Number'.tr,
                  labelText: 'Breeding Number'.tr,
                ),
                SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breeding ID'.tr,
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
                      'Breeding Partner'.tr,
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    PrimaryTextButton(
                      status: TextStatus.idle,
                      text: selectedBreedPartner == null
                          ? 'Add'.tr
                          : "${selectedBreedPartner!.animalName} (ID: ${selectedBreedPartner!.id})",
                      onPressed: () {
                        _showBreedPartnerSelectionSheet(context);
                      },
                      position: TextButtonPosition.right,
                    ),
                  ],
                ),
                SizedBox(height: 10 * SizeConfig.heightMultiplier(context)),
                PrimaryDateField(
                  labelText: 'Breeding Date'.tr,
                  hintText: 'DD/MM/YYYY',
                  controller: _breedingDateController,
                  onChanged: (breedingDate) {
                    if (widget.oviDetails.selectedAnimalType == 'Mammal') {
                      _fillDeliveryDate(breedingDate,
                          widget.oviDetails.selectedAnimalSpecies);
                    } else if (widget.oviDetails.selectedAnimalType ==
                        'Oviparous') {
                      _fillDates(breedingDate,
                          widget.oviDetails.selectedAnimalSpecies);
                    }
                  },
                ),
                SizedBox(height: 20 * SizeConfig.heightMultiplier(context)),
                if (widget.oviDetails.selectedAnimalType == 'Mammal')
                  PrimaryDateField(
                    labelText: 'Delivery Date'.tr,
                    hintText: 'DD/MM/YYYY',
                    controller: _deliveryDateController,
                  ),
                if (widget.oviDetails.selectedAnimalType == 'Oviparous')
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
                  "Children".tr,
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
                        "Add Children".tr,
                        style: AppFonts.body1(color: AppColors.primary40),
                      ),
                      const Icon(Icons.add, color: AppColors.primary40),
                    ],
                  ),
                ),
                SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                Text(
                  "Notes".tr,
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                SizedBox(height: 20 * SizeConfig.heightMultiplier(context)),
                ParagraphTextField(
                  hintText: 'Add Notes'.tr,
                  maxLines: 6,
                  onChanged: (value) {
                    ref
                        .read(breedingNotesProvider.notifier)
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
            text: 'Create Event'.tr,
          ),
        ),
      ),
    );
  }

  void _showBreedChildrenSelectionSheet(BuildContext context) async {
    final newSelectedChildren = await showModalBottomSheet(
      context: context,
      showDragHandle: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AnimalChildrenModal(
          selectedAnimal: widget.oviDetails,
          selectedFather: widget.oviDetails.selectedOviSire,
          selectedMother: widget.oviDetails.selectedOviDam,
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
    final selectedPartner = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimalPartnerModal(
          selectedPartner: selectedBreedPartner,
          selectedAnimal: widget.oviDetails,
          selectedFather: widget.oviDetails.selectedOviSire,
          selectedMother: widget.oviDetails.selectedOviDam,
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

  void _createBreedingEvent() {
    final numOffEggs = _eggsNumberController.text;
    final partner = selectedBreedPartner;
    final children = selectedChildren;
    final oviAnimals = ref.read(oviAnimalsProvider);

    MainAnimalSire? sire;
    MainAnimalDam? dam;
    if (widget.oviDetails.selectedOviGender == 'Male') {
      sire = MainAnimalSire(
          widget.oviDetails.animalName,
          widget.oviDetails.selectedOviImage,
          widget.oviDetails.selectedOviGender);
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
          widget.oviDetails.animalName,
          widget.oviDetails.selectedOviImage,
          widget.oviDetails.selectedOviGender);
    }

    for (var child in children) {
      final childIndex =
          oviAnimals.indexWhere((animal) => animal.id == child.id);
      ref.read(oviAnimalsProvider)[childIndex] = ref
          .read(oviAnimalsProvider)[childIndex]
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
