import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sulala_upgrade/src/widgets/animal_info_modal_sheets.dart/animal_partner_modal.dart';
import '../../data/classes/breed_child_item.dart';
import '../../data/classes/breeding_partner.dart';
import '../../data/classes/main_animal_dam.dart';
import '../../data/classes/main_animal_sire.dart';
import '../../data/globals.dart';
import '../../data/providers/animal_providers.dart';
import '../../data/providers/breeding_event_providers.dart';
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
  final int animalId;
  final int eventId;
  const EditBreedingEventDetails(
      {super.key, required this.animalId, required this.eventId});

  @override
  ConsumerState<EditBreedingEventDetails> createState() =>
      _EditBreedingEventDetailsState();
}

class _EditBreedingEventDetailsState
    extends ConsumerState<EditBreedingEventDetails> {
  TextEditingController? _breedingEventNumberController;
  TextEditingController? _breedingDateController;
  TextEditingController? _deliveryDateController;
  TextEditingController? _breedingEventNotesController;
  TextEditingController? _layingEggsDateController;
  TextEditingController? _eggsNumberController;
  TextEditingController? _incubationDateController;
  TextEditingController? _hatchingDateController;
  BreedingPartner? breedPartner;
  List<BreedChildItem>? selectedChildren;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ref.watch(animalListProvider).when(
          error: (error, trace) => Scaffold(
                body: Text('Error: $error'),
              ),
          loading: () => const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          data: (animals) {
            final animal = animals
                .firstWhereOrNull((animal) => animal.id == widget.animalId);
            if (animal == null) {
              return Text('Animal not found'.tr);
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
                padding: EdgeInsets.symmetric(
                    horizontal: 16 * SizeConfig.widthMultiplier(context)),
                child: SingleChildScrollView(
                  child: ref
                      .watch(breedingEventListProvider(widget.animalId))
                      .when(
                          error: (error, trace) => Text('Error: $error'),
                          loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          data: (events) {
                            var breedingEvent = events.firstWhereOrNull(
                                (event) => event.id == widget.eventId);
                            if (breedingEvent == null) {
                              return Text('Event not found'.tr);
                            }
                            _breedingEventNumberController ??=
                                TextEditingController(
                                    text: breedingEvent.eventNumber);
                            _breedingDateController ??= TextEditingController(
                                text: breedingEvent.breedingDate != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(breedingEvent.breedingDate!)
                                    : '');
                            _deliveryDateController ??= TextEditingController(
                                text: breedingEvent.deliveryDate != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(breedingEvent.deliveryDate!)
                                    : '');
                            _breedingEventNotesController ??=
                                TextEditingController(
                                    text: breedingEvent.notes);
                            _layingEggsDateController ??= TextEditingController(
                                text: breedingEvent.layingEggsDate != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(breedingEvent.layingEggsDate!)
                                    : '');
                            _eggsNumberController ??= TextEditingController(
                                text: '${breedingEvent.eggsNumber ?? ''}');
                            _incubationDateController ??= TextEditingController(
                                text: breedingEvent.incubationDate != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(breedingEvent.incubationDate!)
                                    : '');
                            _hatchingDateController ??= TextEditingController(
                                text: breedingEvent.hatchingDate != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(breedingEvent.hatchingDate!)
                                    : '');
                            breedPartner ??= breedingEvent.partner;
                            if (breedPartner?.animalId == widget.animalId) {
                              breedPartner = breedingEvent.sire?.animalId ==
                                      widget.animalId
                                  ? BreedingPartner(
                                      animalId: breedingEvent.dam!.animalId,
                                      animalName: breedingEvent.dam!.animalName,
                                      selectedOviImage:
                                          breedingEvent.dam!.selectedOviImage,
                                      selectedOviGender:
                                          breedingEvent.dam!.selectedOviGender)
                                  : BreedingPartner(
                                      animalId: breedingEvent.sire!.animalId,
                                      animalName:
                                          breedingEvent.sire!.animalName,
                                      selectedOviImage:
                                          breedingEvent.sire!.selectedOviImage,
                                      selectedOviGender: breedingEvent
                                          .sire!.selectedOviGender);
                            }
                            selectedChildren ??= breedingEvent.children;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  breedingEvent.eventNumber,
                                  style: AppFonts.title3(
                                    color: AppColors.grayscale90,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      24 * SizeConfig.heightMultiplier(context),
                                ),
                                PrimaryTextField(
                                  controller: _breedingEventNumberController!,
                                  hintText: 'Edit Breeding Event'.tr,
                                  labelText: 'Breeding Event'.tr,
                                ),
                                SizedBox(
                                  height:
                                      26 * SizeConfig.heightMultiplier(context),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Breeding ID'.tr,
                                      style: AppFonts.body2(
                                          color: AppColors.grayscale70),
                                    ),
                                    Text(
                                      breedingEvent.id?.toString() ?? '',
                                      style: AppFonts.body2(
                                          color: AppColors.grayscale90),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      26 * SizeConfig.heightMultiplier(context),
                                ),
                                PrimaryDateField(
                                  labelText: 'Breeding Date'.tr,
                                  hintText: "DD/MM/YYYY",
                                  controller: _breedingDateController!,
                                ),
                                SizedBox(
                                  height:
                                      20 * SizeConfig.heightMultiplier(context),
                                ),
                                if (animal.selectedAnimalType == 'Mammal')
                                  PrimaryDateField(
                                    labelText: 'Delivery Date'.tr,
                                    hintText: "DD/MM/YYYY",
                                    controller: _deliveryDateController!,
                                  ),
                                if (animal.selectedAnimalType == 'Oviparous')
                                  Column(
                                    children: [
                                      PrimaryDateField(
                                        controller: _layingEggsDateController!,
                                        labelText: 'Date of laying eggs'.tr,
                                        hintText: 'DD/MM/YYYY',
                                      ),
                                      PrimaryTextField(
                                        controller: _eggsNumberController!,
                                        keyboardType: TextInputType.number,
                                        labelText: 'Number of eggs'.tr,
                                        hintText: '0',
                                      ),
                                      PrimaryDateField(
                                        controller: _incubationDateController!,
                                        labelText: 'Incubation date'.tr,
                                        hintText: 'DD/MM/YYYY',
                                      ),
                                      PrimaryDateField(
                                        controller: _hatchingDateController!,
                                        labelText: 'Hatching date'.tr,
                                        hintText: 'DD/MM/YYYY',
                                      ),
                                    ],
                                  ),
                                SizedBox(
                                  height:
                                      20 * SizeConfig.heightMultiplier(context),
                                ),
                                const Divider(),
                                SizedBox(
                                  height:
                                      10 * SizeConfig.heightMultiplier(context),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Breeding Partner'.tr,
                                      style: AppFonts.title5(
                                          color: AppColors.grayscale90),
                                    ),
                                    PrimaryTextButton(
                                      status: TextStatus.idle,
                                      text:
                                          breedPartner?.animalName ?? 'Add'.tr,
                                      onPressed: () {
                                        _showBreedPartnerSelectionSheet(
                                            context, animal);
                                      },
                                      position: TextButtonPosition.right,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      16 * SizeConfig.heightMultiplier(context),
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
                                        radius: SizeConfig.widthMultiplier(
                                                context) *
                                            24,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            partner.selectedOviImage,
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
                                        style: AppFonts.headline3(
                                            color: AppColors.grayscale90),
                                      ),
                                      subtitle: Text(
                                        partner.selectedOviGender,
                                        style: AppFonts.body2(
                                            color: AppColors.grayscale70),
                                      ),
                                      trailing: Text(
                                        'ID#${partner.animalId}',
                                        style: AppFonts.body2(
                                            color: AppColors.grayscale70),
                                      ),
                                    );
                                  },
                                ),
                                const Divider(),
                                SizedBox(
                                  height:
                                      6 * SizeConfig.heightMultiplier(context),
                                ),
                                Text(
                                  "Children".tr,
                                  style: AppFonts.title5(
                                      color: AppColors.grayscale90),
                                ),
                                SizedBox(
                                  height:
                                      16 * SizeConfig.heightMultiplier(context),
                                ),
                                selectedChildren == null ||
                                        selectedChildren!.isEmpty
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 8 *
                                                SizeConfig.heightMultiplier(
                                                    context),
                                          ),
                                          Center(
                                              child: Image.asset(
                                                  'assets/illustrations/cow_child.png')),
                                        ],
                                      )
                                    : ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: selectedChildren!.length,
                                        itemBuilder: (context, index) {
                                          final child =
                                              selectedChildren![index];
                                          return ListTile(
                                            onTap: () {},
                                            contentPadding: EdgeInsets.zero,
                                            leading: CircleAvatar(
                                              radius:
                                                  SizeConfig.widthMultiplier(
                                                          context) *
                                                      24,
                                              backgroundColor:
                                                  Colors.transparent,
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
                                            subtitle: Text(
                                              child.selectedOviGender,
                                              style: AppFonts.body2(
                                                  color: AppColors.grayscale70),
                                            ),
                                            trailing: Text(
                                              'ID#${child.animalId}',
                                              style: AppFonts.body2(
                                                  color: AppColors.grayscale70),
                                            ),
                                          );
                                        },
                                      ),
                                InkWell(
                                  onTap: () {
                                    _showBreedChildrenSelectionSheet(
                                        context, animal);
                                  },
                                  child: Row(
                                    children: [
                                      PrimaryTextButton(
                                        status: TextStatus.idle,
                                        text: 'Add Children'.tr,
                                      ),
                                      SizedBox(
                                        width: 8 *
                                            SizeConfig.widthMultiplier(context),
                                      ),
                                      Icon(
                                        Icons.add_rounded,
                                        color: AppColors.primary40,
                                        size: 20 *
                                            SizeConfig.widthMultiplier(context),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(),
                                SizedBox(
                                  height:
                                      24 * SizeConfig.heightMultiplier(context),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Notes".tr,
                                      style: AppFonts.title5(
                                          color: AppColors.grayscale90),
                                    ),
                                    InkWell(
                                        onTap: () {},
                                        child: Image.asset(
                                            'assets/icons/frame/24px/24_Edit.png'))
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      16 * SizeConfig.heightMultiplier(context),
                                ),
                                ParagraphTextField(
                                  controller: _breedingEventNotesController,
                                  hintText: 'Add Notes'.tr,
                                  maxLines: 6,
                                ),
                                SizedBox(
                                  height: 100 *
                                      SizeConfig.heightMultiplier(context),
                                ),
                                SizedBox(
                                  height:
                                      52 * SizeConfig.heightMultiplier(context),
                                  width:
                                      343 * SizeConfig.widthMultiplier(context),
                                  child: PrimaryButton(
                                    text: 'Save Changes'.tr,
                                    onPressed: () {
                                      MainAnimalSire? sire;
                                      MainAnimalDam? dam;
                                      if (animal.selectedOviGender == 'Male') {
                                        sire = MainAnimalSire(
                                            animalId: animal.id!,
                                            animalName: animal.animalName,
                                            selectedOviImage:
                                                animal.selectedOviImage,
                                            selectedOviGender:
                                                animal.selectedOviGender);
                                        if (breedPartner != null) {
                                          dam = MainAnimalDam(
                                              animalId: breedPartner!.animalId,
                                              animalName:
                                                  breedPartner!.animalName,
                                              selectedOviImage: breedPartner!
                                                  .selectedOviImage,
                                              selectedOviGender: breedPartner!
                                                  .selectedOviGender);
                                        }
                                      } else {
                                        if (breedPartner != null) {
                                          sire = MainAnimalSire(
                                              animalId: breedPartner!.animalId,
                                              animalName:
                                                  breedPartner!.animalName,
                                              selectedOviImage: breedPartner!
                                                  .selectedOviImage,
                                              selectedOviGender: breedPartner!
                                                  .selectedOviGender);
                                        }
                                        dam = MainAnimalDam(
                                            animalId: animal.id!,
                                            animalName: animal.animalName,
                                            selectedOviImage:
                                                animal.selectedOviImage,
                                            selectedOviGender:
                                                animal.selectedOviGender);
                                      }

                                      final updatedBreedingEventDetails = breedingEvent.copyWith(
                                          eventNumber: _breedingEventNumberController!
                                              .text,
                                          breedingDate: _breedingDateController!.text.isNotEmpty
                                              ? DateFormat('dd/MM/yyyy').parse(
                                                  _breedingDateController!.text)
                                              : null,
                                          deliveryDate: _deliveryDateController!.text.isNotEmpty
                                              ? DateFormat('dd/MM/yyyy').parse(
                                                  _deliveryDateController!.text)
                                              : null,
                                          layingEggsDate: _layingEggsDateController!
                                                  .text.isNotEmpty
                                              ? DateFormat('dd/MM/yyyy').parse(
                                                  _layingEggsDateController!
                                                      .text)
                                              : null,
                                          eggsNumber: _eggsNumberController!.text.isNum
                                              ? int.parse(_eggsNumberController!.text)
                                              : null,
                                          incubationDate: _incubationDateController!.text.isNotEmpty ? DateFormat('dd/MM/yyyy').parse(_incubationDateController!.text) : null,
                                          hatchingDate: _hatchingDateController!.text.isNotEmpty ? DateFormat('dd/MM/yyyy').parse(_hatchingDateController!.text) : null,
                                          partner: breedPartner,
                                          children: selectedChildren,
                                          notes: _breedingEventNotesController!.text,
                                          sire: sire,
                                          dam: dam);
                                      ref
                                          .read(breedingEventListProvider(
                                                  widget.animalId)
                                              .notifier)
                                          .updateEvent(
                                              updatedBreedingEventDetails);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      8 * SizeConfig.heightMultiplier(context),
                                ),
                                SizedBox(
                                  height:
                                      52 * SizeConfig.heightMultiplier(context),
                                  width:
                                      343 * SizeConfig.widthMultiplier(context),
                                  child: NavigateButton(
                                    text: 'Delete Event'.tr,
                                    onPressed: () =>
                                        _deleteEvent(breedingEvent.id),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      16 * SizeConfig.heightMultiplier(context),
                                ),
                              ],
                            );
                          }),
                ),
              ),
            );
          }),
    );
  }

  void _showBreedChildrenSelectionSheet(BuildContext context, animal) async {
    final newSelectedChildren = await showModalBottomSheet(
      context: context,
      showDragHandle: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AnimalChildrenModal(
          selectedAnimal: animal,
          selectedFather: animal.selectedOviSire,
          selectedMother: animal.selectedOviDam,
          selectedChildren: selectedChildren ?? [],
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

  void _showBreedPartnerSelectionSheet(BuildContext context, animal) async {
    final newPartner = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimalPartnerModal(
          selectedPartner: breedPartner,
          selectedAnimal: animal,
          selectedFather: animal.selectedOviSire,
          selectedMother: animal.selectedOviDam,
          selectedChildren: selectedChildren ?? [],
        );
      },
    );
    if (newPartner != null) {
      setState(() {
        breedPartner = newPartner;
      });
    }
  }

  void _deleteEvent(id) {
    ref
        .read(breedingEventListProvider(widget.animalId).notifier)
        .removeEvent(id);

    Navigator.pop(context, {'eventDeleted': true});
  }
}
