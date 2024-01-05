// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import 'package:sulala_upgrade/src/screens/create_animal/owned_animal_detail_reg_mode.dart';
import '../../data/classes.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'edit_breeding_event_detail.dart';
import 'list_of_childrens.dart';

class BreedingEventDetails extends ConsumerStatefulWidget {
  final List<BreedingEventVariables> breedingEvents;
  final BreedingEventVariables breedingEvent;
  final OviVariables OviDetails;

  const BreedingEventDetails({
    super.key,
    required this.breedingEvents,
    required this.OviDetails,
    required this.breedingEvent,
  });

  @override
  ConsumerState<BreedingEventDetails> createState() => _BreedingEventDetailsState();
}

class _BreedingEventDetailsState extends ConsumerState<BreedingEventDetails> {
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
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditBreedingEventDetails(
                      breedingEvents: widget.breedingEvents,
                      OviDetails: widget.OviDetails,
                      breedingEvent: widget.breedingEvent,
                    ),
                  ),
                );
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
          padding:
              EdgeInsets.symmetric(horizontal: 16 * globals.widthMediaQuery),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.breedingEvent.eventNumber,
                  style: AppFonts.title3(
                    color: AppColors.grayscale90,
                  ),
                ),
                SizedBox(
                  height: 24 * globals.heightMediaQuery,
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
                  height: 20 * globals.heightMediaQuery,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breeding Date',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    widget.breedingEvent.breedingDate.isEmpty
                        ? Text(
                            'No Date Added',
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          )
                        : Text(
                            widget.breedingEvent.breedingDate,
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                  ],
                ),
                SizedBox(
                  height: 20 * globals.heightMediaQuery,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Date',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    widget.breedingEvent.deliveryDate == null || widget.breedingEvent.deliveryDate!.isEmpty
                        ? Text(
                            'No Date Added',
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          )
                        : Text(
                            widget.breedingEvent.deliveryDate!,
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                  ],
                ),
                SizedBox(
                  height: 10 * globals.heightMediaQuery,
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
                  ],
                ),
                SizedBox(
                  height: 16 * globals.heightMediaQuery,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.breedingEvent.partner.length,
                  itemBuilder: (context, index) {
                    final parent = widget.breedingEvent.partner[index];
                    return ListTile(
                      onTap: () {
                        final childOviDetails = ref.read(ovianimalsProvider)
                            .firstWhere((animal) => animal.animalName == parent
                            .animalName);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OwnedAnimalDetailsRegMode(
                                imagePath: '', title: '', geninfo: '',
                                OviDetails: childOviDetails,
                                breedingEvents: const [])
                          ),
                        );
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: globals.widthMediaQuery * 24,
                        backgroundColor: Colors.transparent,
                        backgroundImage: parent.selectedOviImage != null
                            ? FileImage(parent.selectedOviImage!)
                            : null,
                        child: parent.selectedOviImage == null
                            ? const Icon(
                                Icons.camera_alt_outlined,
                                size: 50,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      title: Text(
                        parent.animalName,
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      ),
                      subtitle: Text(
                        parent.selectedOviGender,
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                      trailing: Text(
                        'ID#131340',
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
                widget.breedingEvent.children.isEmpty
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
                        itemCount: widget.breedingEvent.children.length,
                        itemBuilder: (context, index) {
                          final child = widget.breedingEvent.children[index];
                          return ListTile(
                            onTap: () {
                              final childOviDetails = ref.read(ovianimalsProvider)
                                  .firstWhere((animal) => animal.animalName == child
                                  .animalName);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => OwnedAnimalDetailsRegMode(
                                        imagePath: '', title: '', geninfo: '',
                                        OviDetails: childOviDetails,
                                        breedingEvents: const [])
                                ),
                              );
                            },
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: globals.widthMediaQuery * 24,
                              backgroundColor: Colors.transparent,
                              backgroundImage: child.selectedOviImage != null
                                  ? FileImage(child.selectedOviImage!)
                                  : null,
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
                              'ID#131340',
                              style:
                                  AppFonts.body2(color: AppColors.grayscale70),
                            ),
                          );
                        },
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
                Text(
                  widget.breedingEvent.notes,
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
}
