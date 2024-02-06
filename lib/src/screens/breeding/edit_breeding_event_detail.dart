import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sulala_upgrade/src/widgets/animal_info_modal_sheets.dart/animal_partner_modal.dart';
import '../../data/classes/breed_child_item.dart';
import '../../data/classes/breeding_details.dart';
import '../../data/classes/breeding_event_variables.dart';
import '../../data/classes/breeding_partner.dart';
import '../../data/classes/main_animal_dam.dart';
import '../../data/classes/main_animal_sire.dart';
import '../../data/classes/ovi_variables.dart';
import '../../data/globals.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/animal_info_modal_sheets.dart/animal_children_modal.dart';
import '../../widgets/controls_and_buttons/buttons/navigate_button.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_text_button.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/paragraph_text_fields/paragraph_text_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';

class EditBreedingEventDetails extends ConsumerStatefulWidget {
  final List<BreedingEventVariables> breedingEvents;
  final OviVariables oviDetails;
  final BreedingDetails? breedingDetails;
  final BreedingEventVariables breedingEvent;
  const EditBreedingEventDetails(
      {super.key,
      required this.breedingEvents,
      required this.breedingEvent,
      this.breedingDetails,
      required this.oviDetails});

  @override
  ConsumerState<EditBreedingEventDetails> createState() =>
      _EditBreedingEventDetailsState();
}

class _EditBreedingEventDetailsState
    extends ConsumerState<EditBreedingEventDetails> {
  final _breedingEventNumberController = TextEditingController();
  final _breedingDateController = TextEditingController();
  final _deliveryDateController = TextEditingController();
  final _breedingEventNotesController = TextEditingController();
  List<BreedChildItem> selectedChildren = [];
  BreedingPartner? breedPartner;
  late DateTime? selectedBreedingDate;
  late DateTime? selectedDeliveryDate;
  bool isFirstTimeSelection = true;
  final _layingEggsDateController = TextEditingController();
  final _eggsNumberController = TextEditingController();
  final _incubationDateController = TextEditingController();
  final _hatchingDateController = TextEditingController();

  bool initialized = false;

  @override
  void initState() {
    super.initState();
    _breedingEventNumberController.text = widget.breedingEvent.eventNumber;

    selectedBreedingDate = widget.breedingEvent.breedingDate;
    selectedDeliveryDate = widget.breedingEvent.deliveryDate;
    selectedChildren = widget.breedingEvent.children;
    _breedingEventNotesController.text = widget.breedingEvent.notes;
    breedPartner = widget.breedingEvent.partner;
    if (breedPartner?.id == widget.oviDetails.id) {
      breedPartner = widget.breedingEvent.sire?.id == widget.oviDetails.id
          ? BreedingPartner(
              widget.breedingEvent.dam!.animalName,
              widget.breedingEvent.dam!.selectedOviImage,
              widget.breedingEvent.dam!.selectedOviGender)
          : BreedingPartner(
              widget.breedingEvent.sire!.animalName,
              widget.breedingEvent.sire!.selectedOviImage,
              widget.breedingEvent.sire!.selectedOviGender);
    }
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
          selectedPartner: breedPartner,
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
    final newPartner = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimalPartnerModal(
          selectedPartner: breedPartner,
          selectedAnimal: widget.oviDetails,
          selectedFather: widget.oviDetails.selectedOviSire,
          selectedMother: widget.oviDetails.selectedOviDam,
          selectedChildren: selectedChildren,
        );
      },
    );
    if (newPartner != null) {
      setState(() {
        breedPartner = newPartner;
      });
    }
  }

  void _setBreedingSelectedDate(DateTime breedingDate) {
    setState(() {
      // Format the date as needed and update the local variable
      selectedBreedingDate = breedingDate;
    });
  }

  void _setDeliverySelectedDate(DateTime deliveryDate) {
    setState(() {
      // Format the date as needed and update the local variable
      selectedDeliveryDate = deliveryDate;
    });
  }

  void _setLayingEggsSelectedDate(DateTime layingEggsDate) {
    ref
        .read(dateOfLayingEggsProvider.notifier)
        .update((state) => layingEggsDate);
  }

  void _setEggsNumber(String eggsNumber) {
    ref.read(numOfEggsProvider.notifier).update((state) {
      state = eggsNumber;
      return state;
    });
  }

  void _setIncubationSelectedDate(DateTime incubationDate) {
    ref.read(incubationDateProvider.notifier).update((state) => incubationDate);
  }

  void _setHatchingSelectedDate(DateTime hatchingDate) {
    ref.read(dateOfHatchingProvider.notifier).update((state) {
      state = hatchingDate;
      return state;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedBreedPartner = ref.watch(breedingPartnerDetailsProvider);
    if (!initialized) {
      if (widget.breedingEvent.layingEggsDate != null) {
        _layingEggsDateController.text = DateFormat('dd/MM/yyyy')
            .format(widget.breedingEvent.layingEggsDate!);
      }
      if (widget.breedingEvent.layingEggsDate != null) {
        _layingEggsDateController.text = DateFormat('dd/MM/yyyy')
            .format(widget.breedingEvent.layingEggsDate!);
      }
      if (widget.breedingEvent.layingEggsDate != null) {
        _layingEggsDateController.text = DateFormat('dd/MM/yyyy')
            .format(widget.breedingEvent.layingEggsDate!);
      }
      _eggsNumberController.text = widget.breedingEvent.eggsNumber.toString();
      if (widget.breedingEvent.incubationDate != null) {
        _incubationDateController.text = DateFormat('dd/MM/yyyy')
            .format(widget.breedingEvent.incubationDate!);
      }
      if (widget.breedingEvent.hatchingDate != null) {
        _hatchingDateController.text =
            DateFormat('dd/MM/yyyy').format(widget.breedingEvent.hatchingDate!);
      }
      initialized = true;
    }

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
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 16 * SizeConfig.widthMultiplier(context)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _breedingEventNumberController.text,
                  style: AppFonts.title3(
                    color: AppColors.grayscale90,
                  ),
                ),
                SizedBox(
                  height: 24 * SizeConfig.heightMultiplier(context),
                ),
                PrimaryTextField(
                  controller: _breedingEventNumberController,
                  hintText: 'Edit Breeding Event'.tr,
                  labelText: 'Breeding Event'.tr,
                ),
                SizedBox(
                  height: 26 * SizeConfig.heightMultiplier(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breeding ID'.tr,
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    Text(
                      widget.breedingEvent.id.toString(),
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                  ],
                ),
                SizedBox(
                  height: 26 * SizeConfig.heightMultiplier(context),
                ),
                PrimaryDateField(
                  labelText: 'Breeding Date'.tr,
                  hintText: "DD/MM/YYYY",
                  onChanged: (value) {
                    // Assuming value is a DateTime
                    _setBreedingSelectedDate(value);
                  },
                  controller: _breedingDateController,
                ),
                SizedBox(
                  height: 20 * SizeConfig.heightMultiplier(context),
                ),
                if (widget.oviDetails.selectedAnimalType == 'Mammal')
                  PrimaryDateField(
                    labelText: 'Delivery Date'.tr,
                    hintText: "DD/MM/YYYY",
                    onChanged: (value) {
                      _setDeliverySelectedDate(value);
                    },
                    controller: _deliveryDateController,
                  ),
                if (widget.oviDetails.selectedAnimalType == 'Oviparous')
                  Column(
                    children: [
                      PrimaryDateField(
                        controller: _layingEggsDateController,
                        labelText: 'Date of laying eggs'.tr,
                        hintText: 'DD/MM/YYYY',
                        onChanged: (value) {
                          _setLayingEggsSelectedDate(value);
                        },
                      ),
                      PrimaryTextField(
                        controller: _eggsNumberController,
                        keyboardType: TextInputType.number,
                        labelText: 'Number of eggs'.tr,
                        hintText: '0',
                        onChanged: (value) {
                          _setEggsNumber(value);
                        },
                      ),
                      PrimaryDateField(
                        controller: _incubationDateController,
                        labelText: 'Incubation date'.tr,
                        hintText: 'DD/MM/YYYY',
                        onChanged: (value) {
                          _setIncubationSelectedDate(value);
                        },
                      ),
                      PrimaryDateField(
                        controller: _hatchingDateController,
                        labelText: 'Hatching date'.tr,
                        hintText: 'DD/MM/YYYY',
                        onChanged: (value) {
                          _setHatchingSelectedDate(value);
                        },
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20 * SizeConfig.heightMultiplier(context),
                ),
                const Divider(),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breeding Partner'.tr,
                      style: AppFonts.title5(color: AppColors.grayscale90),
                    ),
                    PrimaryTextButton(
                      status: TextStatus.idle,
                      text: selectedBreedPartner ?? 'Add'.tr,
                      onPressed: () {
                        _showBreedPartnerSelectionSheet(context);
                      },
                      position: TextButtonPosition.right,
                    ),
                  ],
                ),
                SizedBox(
                  height: 16 * SizeConfig.heightMultiplier(context),
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
                        radius: SizeConfig.widthMultiplier(context) * 24,
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
                  height: 6 * SizeConfig.heightMultiplier(context),
                ),
                Text(
                  "Children".tr,
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: 16 * SizeConfig.heightMultiplier(context),
                ),
                selectedChildren.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 8 * SizeConfig.heightMultiplier(context),
                          ),
                          Center(
                              child: Image.asset(
                                  'assets/illustrations/cow_child.png')),
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
                      PrimaryTextButton(
                        status: TextStatus.idle,
                        text: 'Add Children'.tr,
                      ),
                      SizedBox(
                        width: 8 * SizeConfig.widthMultiplier(context),
                      ),
                      Icon(
                        Icons.add_rounded,
                        color: AppColors.primary40,
                        size: 20 * SizeConfig.widthMultiplier(context),
                      )
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 24 * SizeConfig.heightMultiplier(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Notes".tr,
                      style: AppFonts.title5(color: AppColors.grayscale90),
                    ),
                    InkWell(
                        onTap: () {},
                        child:
                            Image.asset('assets/icons/frame/24px/24_Edit.png'))
                  ],
                ),
                SizedBox(
                  height: 16 * SizeConfig.heightMultiplier(context),
                ),
                ParagraphTextField(
                  controller: _breedingEventNotesController,
                  hintText: 'Add Notes'.tr,
                  maxLines: 6,
                ),
                SizedBox(
                  height: 100 * SizeConfig.heightMultiplier(context),
                ),
                SizedBox(
                  height: 52 * SizeConfig.heightMultiplier(context),
                  width: 343 * SizeConfig.widthMultiplier(context),
                  child: PrimaryButton(
                    text: 'Save Changes'.tr,
                    onPressed: () {
                      MainAnimalSire? sire;
                      MainAnimalDam? dam;
                      if (widget.oviDetails.selectedOviGender == 'Male') {
                        sire = MainAnimalSire(
                            widget.oviDetails.animalName,
                            widget.oviDetails.selectedOviImage,
                            widget.oviDetails.selectedOviGender);
                        if (breedPartner != null) {
                          dam = MainAnimalDam(
                              breedPartner!.animalName,
                              breedPartner!.selectedOviImage,
                              breedPartner!.selectedOviGender);
                        }
                      } else {
                        if (breedPartner != null) {
                          sire = MainAnimalSire(
                              breedPartner!.animalName,
                              breedPartner!.selectedOviImage,
                              breedPartner!.selectedOviGender);
                        }
                        dam = MainAnimalDam(
                            widget.oviDetails.animalName,
                            widget.oviDetails.selectedOviImage,
                            widget.oviDetails.selectedOviGender);
                      }

                      final updatedBreedingEventDetails = widget.breedingEvent
                          .copyWith(
                              eventNumber: _breedingEventNumberController.text,
                              breedingDate: selectedBreedingDate,
                              deliveryDate: selectedDeliveryDate,
                              layingEggsDate:
                                  _layingEggsDateController
                                          .text.isNotEmpty
                                      ? DateFormat(
                                              'dd/MM/yyyy')
                                          .parse(_layingEggsDateController.text)
                                      : null,
                              eggsNumber:
                                  _eggsNumberController
                                          .text.isNum
                                      ? int.parse(_eggsNumberController.text)
                                      : null,
                              incubationDate: _incubationDateController
                                      .text.isNotEmpty
                                  ? DateFormat('dd/MM/yyyy')
                                      .parse(_incubationDateController.text)
                                  : null,
                              hatchingDate: _hatchingDateController
                                      .text.isNotEmpty
                                  ? DateFormat('dd/MM/yyyy')
                                      .parse(_hatchingDateController.text)
                                  : null,
                              partner: breedPartner,
                              children: selectedChildren,
                              notes: _breedingEventNotesController.text,
                              sire: sire,
                              dam: dam);
                      ref.read(breedingEventsProvider.notifier).update((state) {
                        final eventIndex = state.indexWhere(
                            (event) => event.id == widget.breedingEvent.id);
                        state[eventIndex] = updatedBreedingEventDetails;
                        return state;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 8 * SizeConfig.heightMultiplier(context),
                ),
                SizedBox(
                  height: 52 * SizeConfig.heightMultiplier(context),
                  width: 343 * SizeConfig.widthMultiplier(context),
                  child: NavigateButton(
                    text: 'Delete Event'.tr,
                    onPressed: _deleteEvent,
                  ),
                ),
                SizedBox(
                  height: 16 * SizeConfig.heightMultiplier(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteEvent() {
    ref
        .read(breedingEventsProvider)
        .removeWhere((event) => event.id == widget.breedingEvent.id);

    Navigator.pop(context, {'eventDeleted': true});
  }
}
