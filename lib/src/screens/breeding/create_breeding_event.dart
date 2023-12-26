// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../data/classes.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/paragraph_text_fields/paragraph_text_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
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
  final TextEditingController _breedingnotesController =
      TextEditingController();
  final TextEditingController _breedingeventnumberController =
      TextEditingController();
  String selectedBreedDam = 'Add';
  String selectedBreedPartner = 'Add';
  String selectedBreedingDate = '';
  String selectedDeliveryDate = '';
  List<BreedChildItem> selectedChildren = [];
  List<BreedingPartner> breedPartners = [];

  void setBreedingSelectedDate(DateTime breedingDate) {
    setState(() {
      ref.read(breedingDateProvider.notifier).update((state) {
        // Format the date as needed before updating the state
        state = DateFormat('dd/MM/yyyy').format(breedingDate);
        return state;
      });
    });
  }

  void setDeliverySelectedDate(DateTime Deliverydate) {
    setState(() {
      ref.read(deliveryDateProvider.notifier).update((state) {
        // Format the date as needed before updating the state
        state = DateFormat('dd/MM/yyyy').format(Deliverydate);
        return state;
      });
    });
  }

  void _showBreedChildrenSelectionSheet(BuildContext context) async {
    // Initialize an empty list
    final ovianimals = ref.watch(ovianimalsProvider);

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
                              backgroundImage:
                                  OviDetails.selectedOviImage != null
                                      ? FileImage(OviDetails.selectedOviImage!)
                                      : null,
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
                                  final File? oviImage =
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
                      "Select Partner",
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
                              breedPartners.contains(OviDetails.animalName);

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
                              backgroundImage:
                                  OviDetails.selectedOviImage != null
                                      ? FileImage(OviDetails.selectedOviImage!)
                                      : null,
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
                                  breedPartners.removeWhere(
                                    (child) =>
                                        child.animalName ==
                                        OviDetails.animalName,
                                  );
                                } else {
                                  // Use a default image (icon) if selectedOviImage is null
                                  final File? oviImage =
                                      OviDetails.selectedOviImage;

                                  breedPartners.add(BreedingPartner(
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
                            .read(breedingPartnerProvider.notifier)
                            .update((state) => breedPartners);
                        Navigator.pop(context);
                        // Append the selected children to the existing list
                        final List<BreedingPartner> existingSelectedChildren =
                            ref.read(breedingPartnerProvider);
                        existingSelectedChildren.addAll(breedPartners);
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
  @override
  Widget build(BuildContext context) {
    final selectedbreedPartner = ref.watch(breedingPartnerDetailsProvider);
    final image = ref.watch(breedingChildrenDetailsProvider);
    final partner = ref.watch(breedingPartnerProvider);

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
                left: 16.0 * globals.widthMediaQuery,
                right: 16.0 * globals.widthMediaQuery),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Event',
                  style: AppFonts.title3(color: AppColors.grayscale90),
                ),
                SizedBox(height: 24 * globals.heightMediaQuery),
                PrimaryTextField(
                  onChanged: (value) {
                    ref
                        .read(breedingEventNumberProvider.notifier)
                        .update((state) => value);
                  },
                  controller: _breedingeventnumberController,
                  hintText: 'Enter Breeding Number',
                  labelText: 'Breeding Number',
                ),
                SizedBox(height: 16 * globals.heightMediaQuery),
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
                  height: 10 * globals.heightMediaQuery,
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
                      text: selectedbreedPartner,
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
                SizedBox(height: 10 * globals.heightMediaQuery),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: partner.length,
                  itemBuilder: (context, index) {
                    final BreedingPartner child = partner[index];
                    return ListTile(
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
                        style: AppFonts.headline4(color: AppColors.grayscale90),
                      ),
                      subtitle: Text(
                        child.selectedOviGender,
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                      trailing: Text(
                        'ID#131340',
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                    );
                  },
                ),
                PrimaryDateField(
                  labelText: 'Breeding Date',
                  hintText: 'DD/MM/YYYY',
                  onChanged: (value) {
                    // Assuming value is a DateTime
                    setBreedingSelectedDate(value);
                  },
                ),
                SizedBox(height: 20 * globals.heightMediaQuery),
                PrimaryDateField(
                  labelText: 'Delivery Date',
                  hintText: 'DD/MM/YYYY',
                  onChanged: (value) {
                    // Assuming value is a DateTime
                    setDeliverySelectedDate(value);
                  },
                ),
                SizedBox(height: 34 * globals.heightMediaQuery),
                Text(
                  "Children",
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                SizedBox(height: 16 * globals.heightMediaQuery),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: image.length,
                  itemBuilder: (context, index) {
                    final BreedChildItem child = image[index];
                    return ListTile(
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
                        style: AppFonts.headline4(color: AppColors.grayscale90),
                      ),
                      subtitle: Text(
                        child.selectedOviGender,
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                      trailing: Text(
                        'ID#131340',
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const SearchChildren(),
                        //     ));
                        _showBreedChildrenSelectionSheet(context);
                      },
                      child: Text(
                        "Add Children",
                        style: AppFonts.body1(color: AppColors.primary40),
                      ),
                    ),
                    const Icon(Icons.add, color: AppColors.primary40),
                  ],
                ),
                SizedBox(height: 24 * globals.heightMediaQuery),
                Text(
                  "Notes",
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                SizedBox(height: 20 * globals.heightMediaQuery),
                ParagraphTextField(
                  hintText: 'Add Notes',
                  maxLines: 6,
                  onChanged: (value) {
                    ref
                        .read(breedingnotesProvider.notifier)
                        .update((state) => value);
                  },
                ),
                SizedBox(height: 85 * globals.heightMediaQuery),
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          height: 52 * globals.heightMediaQuery,
          width: 343 * globals.widthMediaQuery,
          child: PrimaryButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListOfBreedingEvents(
                    shouldAddBreedEvent: true,
                    OviDetails: widget.OviDetails,
                    breedingEvents: widget.breedingEvents,
                    // breedingEventNumberController: TextEditingController(),
                  ),
                ),
              );
            },
            text: 'Create Event',
          ),
        ),
      ),
    );
  }
}
