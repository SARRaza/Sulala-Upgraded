import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import 'package:sulala_upgrade/src/screens/create_animal/owned_animal_detail_reg_mode.dart';
import '../../data/classes/breeding_event_variables.dart';
import '../../data/classes/breeding_partner.dart';
import '../../data/classes/ovi_variables.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'edit_breeding_event_detail.dart';

class BreedingEventDetails extends ConsumerStatefulWidget {
  final List<BreedingEventVariables> breedingEvents;
  final BreedingEventVariables breedingEvent;
  final OviVariables oviDetails;

  const BreedingEventDetails({
    super.key,
    required this.breedingEvents,
    required this.oviDetails,
    required this.breedingEvent,
  });

  @override
  ConsumerState<BreedingEventDetails> createState() =>
      _BreedingEventDetailsState();
}

class _BreedingEventDetailsState extends ConsumerState<BreedingEventDetails> {
  late BreedingEventVariables breedingEvent;

  @override
  Widget build(BuildContext context) {
    breedingEvent = ref.read(breedingEventsProvider).firstWhere((event) =>
        event.sire?.id == widget.oviDetails.id ||
        event.dam?.id == widget.oviDetails.id);
    if (breedingEvent.partner?.id == widget.oviDetails.id) {
      breedingEvent = breedingEvent.copyWith(
          partner: breedingEvent.sire?.id == widget.oviDetails.id
              ? BreedingPartner(
                  breedingEvent.dam!.animalName,
                  breedingEvent.dam!.selectedOviImage,
                  breedingEvent.dam!.selectedOviGender)
              : BreedingPartner(
                  breedingEvent.sire!.animalName,
                  breedingEvent.sire!.selectedOviImage,
                  breedingEvent.sire!.selectedOviGender));
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
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => EditBreedingEventDetails(
                      breedingEvents: widget.breedingEvents,
                      oviDetails: widget.oviDetails,
                      breedingEvent: breedingEvent,
                    ),
                  ),
                )
                    .then((result) {
                  if (result is Map &&
                      result['eventDeleted'] != null &&
                      result['eventDeleted'] == true) {
                    Navigator.pop(context);
                  } else {
                    setState(() {});
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grayscale10,
                  ),
                  child: const Image(
                    image: AssetImage(
                        'assets/icons/frame/24px/edit_icon_button.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 16 * SizeConfig.widthMultiplier(context)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  breedingEvent.eventNumber,
                  style: AppFonts.title3(
                    color: AppColors.grayscale90,
                  ),
                ),
                SizedBox(
                  height: 24 * SizeConfig.heightMultiplier(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breeding ID'.tr,
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    Text(
                      breedingEvent.id.toString(),
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20 * SizeConfig.heightMultiplier(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breeding Date'.tr,
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    breedingEvent.breedingDate == null
                        ? Text(
                            'No Date Added'.tr,
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          )
                        : Text(
                            DateFormat('dd/MM/yyyy')
                                .format(breedingEvent.breedingDate!),
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                  ],
                ),
                SizedBox(
                  height: 20 * SizeConfig.heightMultiplier(context),
                ),
                if (widget.oviDetails.selectedAnimalType == 'Mammal')
                  _buildDateRow('Delivery Date'.tr, breedingEvent.deliveryDate),
                if (widget.oviDetails.selectedAnimalType == 'Oviparous')
                  Column(
                    children: [
                      _buildDateRow('Date of laying eggs'.tr,
                          breedingEvent.layingEggsDate),
                      SizedBox(
                        height: 20 * SizeConfig.heightMultiplier(context),
                      ),
                      _buildNumberRow('Number of eggs'.tr,
                          breedingEvent.eggsNumber.toString()),
                      SizedBox(
                        height: 20 * SizeConfig.heightMultiplier(context),
                      ),
                      _buildDateRow(
                          'Incubation date'.tr, breedingEvent.incubationDate),
                      SizedBox(
                        height: 20 * SizeConfig.heightMultiplier(context),
                      ),
                      _buildDateRow(
                          'Hatching date'.tr, breedingEvent.hatchingDate)
                    ],
                  ),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier(context),
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
                  ],
                ),
                SizedBox(
                  height: 16 * SizeConfig.heightMultiplier(context),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: breedingEvent.partner != null ? 1 : 0,
                  itemBuilder: (context, index) {
                    final partner = breedingEvent.partner;
                    final partnerOviDetails = ref
                        .read(oviAnimalsProvider)
                        .firstWhere((animal) =>
                            animal.animalName == partner!.animalName);

                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => OwnedAnimalDetailsRegMode(
                                  imagePath: '',
                                  title: '',
                                  genInfo: '',
                                  oviDetails: partnerOviDetails,
                                  breedingEvents: const [])),
                        );
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: SizeConfig.widthMultiplier(context) * 24,
                        backgroundColor: Colors.transparent,
                        backgroundImage: partner!.selectedOviImage,
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
                        'ID#${partnerOviDetails.id}',
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
                breedingEvent.children.isEmpty
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
                        itemCount: breedingEvent.children.length,
                        itemBuilder: (context, index) {
                          final child = breedingEvent.children[index];
                          final childOviDetails = ref
                              .read(oviAnimalsProvider)
                              .firstWhere((animal) =>
                                  animal.animalName == child.animalName);

                          return ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OwnedAnimalDetailsRegMode(
                                            imagePath: '',
                                            title: '',
                                            genInfo: '',
                                            oviDetails: childOviDetails,
                                            breedingEvents: const [])),
                              );
                            },
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
                              'ID#${childOviDetails.id}',
                              style:
                                  AppFonts.body2(color: AppColors.grayscale70),
                            ),
                          );
                        },
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
                Text(
                  breedingEvent.notes,
                  // (widget.breedingEvent.notes),
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildDateRow(String label, DateTime? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppFonts.body2(color: AppColors.grayscale70),
        ),
        value == null
            ? Text(
                'No Date Added'.tr,
                style: AppFonts.body2(color: AppColors.grayscale90),
              )
            : Text(
                DateFormat('dd/MM/yyyy').format(value),
                style: AppFonts.body2(color: AppColors.grayscale90),
              ),
      ],
    );
  }

  Row _buildNumberRow(String label, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppFonts.body2(color: AppColors.grayscale70),
        ),
        value == null || value.isEmpty
            ? Text(
                '0',
                style: AppFonts.body2(color: AppColors.grayscale90),
              )
            : Text(
                value,
                style: AppFonts.body2(color: AppColors.grayscale90),
              ),
      ],
    );
  }
}
