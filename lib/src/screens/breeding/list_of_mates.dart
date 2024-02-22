import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:sulala_upgrade/src/data/globals.dart';
import '../../data/classes/breeding_partner.dart';
import '../../data/providers/animal_list_provider.dart';
import '../../data/providers/breeding_event_list_provider.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import 'breeding_event_detail.dart';

class ListOfBreedingMates extends ConsumerStatefulWidget {
  final int animalId;

  const ListOfBreedingMates({
    super.key,
    required this.animalId,
  });

  @override
  ConsumerState<ListOfBreedingMates> createState() => _ListOfBreedingMates();
}

class _ListOfBreedingMates extends ConsumerState<ListOfBreedingMates> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(animalListProvider).when(
        error: (error, trace) => Scaffold(
              body: Center(
                child: Text('Error: $error'),
              ),
            ),
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        data: (animals) {
          final animal = animals
              .firstWhereOrNull((animal) => animal.id == widget.animalId);
          if (animal == null) {
            return const Scaffold(
              body: Center(
                child: Text('Animal not found'),
              ),
            );
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
                left: 16 * SizeConfig.widthMultiplier(context),
              ),
              child: ref.watch(breedingEventListProvider(widget.animalId)).when(
                  error: (error, trace) => Text('Error: $error'),
                  loading: () => const CircularProgressIndicator(),
                  data: (events) {
                    final breedingEvents = events
                        .where((event) =>
                            event.sire?.animalId == widget.animalId ||
                            event.dam?.animalId == widget.animalId)
                        .map((event) {
                      if (event.partner?.animalId == widget.animalId) {
                        return event.copyWith(
                            partner: event.sire?.animalId == widget.animalId
                                ? BreedingPartner(
                                    animalId: event.dam!.animalId,
                                    animalName: event.dam!.animalName,
                                    selectedOviImage:
                                        event.dam!.selectedOviImage,
                                    selectedOviGender:
                                        event.dam!.selectedOviGender)
                                : BreedingPartner(
                                    animalId: event.sire!.animalId,
                                    animalName: event.sire!.animalName,
                                    selectedOviImage:
                                        event.sire!.selectedOviImage,
                                    selectedOviGender:
                                        event.sire!.selectedOviGender));
                      } else {
                        return event;
                      }
                    }).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('List Of Mates'.tr,
                            style:
                                AppFonts.title3(color: AppColors.grayscale90)),
                        SizedBox(
                          height: 16 * SizeConfig.heightMultiplier(context),
                        ),
                        breedingEvents.isEmpty
                            ? Expanded(
                                child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 151 *
                                          SizeConfig.heightMultiplier(context),
                                    ),
                                    Image.asset(
                                        'assets/illustrations/cow_broke_adult.png'),
                                    SizedBox(
                                        height: 32 *
                                            SizeConfig.heightMultiplier(
                                                context)),
                                    Text(
                                      'No Mates Yet'.tr,
                                      style: AppFonts.headline3(
                                          color: AppColors.grayscale90),
                                    ),
                                    SizedBox(
                                      height: 8 *
                                          SizeConfig.heightMultiplier(context),
                                    ),
                                    Text(
                                      "This animal hasn't been mated yet.".tr,
                                      style: AppFonts.body2(
                                          color: AppColors.grayscale70),
                                    ),
                                    SizedBox(
                                      height: 125 *
                                          SizeConfig.heightMultiplier(context),
                                    ),
                                    SizedBox(
                                      width: 130 *
                                          SizeConfig.widthMultiplier(context),
                                      height: 52 *
                                          SizeConfig.heightMultiplier(context),
                                      child: PrimaryButton(
                                        text: 'Add Mate'.tr,
                                        onPressed: () {
                                          // Implement the logic to add children here
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: breedingEvents.length,
                                  itemBuilder: (context, index) {
                                    final breedingEvent = breedingEvents[index];

                                    return Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BreedingEventDetails(
                                                  animalId: widget.animalId,
                                                  eventId: breedingEvent.id!,
                                                ),
                                              ),
                                            );
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
                                                          color: AppColors
                                                              .grayscale90),
                                                    ),
                                              const Icon(
                                                Icons.chevron_right_rounded,
                                                color: AppColors.grayscale50,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (breedingEvent.partner != null)
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: 1,
                                            itemBuilder: (context, index) {
                                              final partner =
                                                  breedingEvent.partner!;
                                              return ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                leading: CircleAvatar(
                                                  radius: 24 *
                                                      SizeConfig
                                                          .widthMultiplier(
                                                              context),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage:
                                                      partner.selectedOviImage,
                                                  child:
                                                      partner.selectedOviImage ==
                                                              null
                                                          ? const Icon(
                                                              Icons
                                                                  .camera_alt_outlined,
                                                              size: 50,
                                                              color:
                                                                  Colors.grey,
                                                            )
                                                          : null,
                                                ),
                                                title: Text(
                                                  partner.animalName,
                                                  style: AppFonts.headline3(
                                                      color: AppColors
                                                          .grayscale90),
                                                ),
                                                // ignore: unnecessary_null_comparison
                                                subtitle: partner
                                                        .selectedOviGender
                                                        .isEmpty
                                                    ? Text(
                                                        'Gender Not Selected'
                                                            .tr,
                                                        style: AppFonts.body2(
                                                            color: AppColors
                                                                .grayscale70),
                                                      )
                                                    : Text(
                                                        partner
                                                            .selectedOviGender,
                                                        style: AppFonts.body2(
                                                            color: AppColors
                                                                .grayscale70),
                                                      ),
                                                trailing: Text(
                                                  'ID #${partner.animalId}',
                                                  style: AppFonts.body2(
                                                      color: AppColors
                                                          .grayscale90),
                                                ),
                                                // Add more information about the child as needed
                                                // Example: subtitle: Text('DOB: ${child.dateOfBirth}'),
                                              );
                                            },
                                          ),
                                        const Divider(
                                          height: 25,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                      ],
                    );
                  }),
            ),
          );
        });
  }
}
