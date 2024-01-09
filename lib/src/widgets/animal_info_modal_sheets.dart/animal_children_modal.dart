import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../data/classes.dart';
import '../../data/riverpod_globals.dart';
import '../controls_and_buttons/buttons/primary_button.dart';

class AnimalChildrenModal extends StatefulWidget {
  const AnimalChildrenModal({
    super.key,
    required this.ovianimals,
    required this.selectedChildren,
    required this.ref,
  });

  final List<OviVariables> ovianimals;
  final List<BreedChildItem> selectedChildren;

  final WidgetRef ref;

  @override
  State<AnimalChildrenModal> createState() => _AnimalChildrenModalState();
}

class _AnimalChildrenModalState extends State<AnimalChildrenModal> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 35,
          height: 4,
          decoration: ShapeDecoration(
            color: const Color(0xFFE3E5E7),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.only(
            top: 40,
            bottom: 50,
          ),
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              SizedBox(
                width: 343,
                child: Text(
                  'Add children'.tr,
                  style: const TextStyle(
                    color: Color(0xFF232323),
                    fontSize: 34,
                    fontFamily: 'Source Serif Pro',
                    fontWeight: FontWeight.w600,
                    height: 0.03,
                    letterSpacing: 0.24,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFE3E5E7)),
                            borderRadius: BorderRadius.circular(24),
                          ),
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
                                hintStyle: TextStyle(
                                  color: Color(0xFFA2A6AC),
                                  fontSize: 14,
                                  fontFamily: 'IBM Plex Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 0.10,
                                ))),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.ovianimals.length,
                            itemBuilder: (context, index) {
                              final OviDetails = widget.ovianimals[index];
                              final bool isSelected =
                              widget.selectedChildren.any((child) =>
                              child.animalName ==
                                  OviDetails.animalName);

                              if (!OviDetails.animalName
                                  .toLowerCase()
                                  .contains(searchQuery) &&
                                  !OviDetails.selectedAnimalType
                                      .toLowerCase()
                                      .contains(searchQuery)) {
                                return Container(); // Skip this item if it doesn't match the search query
                              }

                              return Material(
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  selected: isSelected,
                                  selectedTileColor:
                                  Colors.green.withOpacity(0.5),
                                  shape: isSelected
                                      ? RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        50.0),
                                  )
                                      : null,
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.grey[100],
                                    backgroundImage:
                                    OviDetails.selectedOviImage !=
                                        null
                                        ? FileImage(OviDetails
                                        .selectedOviImage!)
                                        : null,
                                    child: OviDetails
                                        .selectedOviImage ==
                                        null
                                        ? const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 50,
                                      color: Colors.grey,
                                    )
                                        : null,
                                  ),
                                  title: Text(OviDetails.animalName),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Gender: ${OviDetails.selectedOviGender}'),
                                      Text(
                                          'Mother: ${OviDetails.selectedOviDam.first.animalName}'),
                                      if (OviDetails.selectedOviDam
                                          .first.mother !=
                                          null)
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Maternal Father: ${OviDetails.selectedOviDam.first.father!.animalName}'),
                                            if (OviDetails
                                                .selectedOviDam
                                                .first
                                                .mother !=
                                                null)
                                              Text(
                                                  'Maternal Mother: ${OviDetails.selectedOviDam.first.mother!.animalName}'),
                                          ],
                                        ),
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        widget.selectedChildren.removeWhere(
                                              (child) =>
                                          child.animalName ==
                                              OviDetails.animalName,
                                        );
                                      } else {
                                        // Use a default image (icon) if selectedOviImage is null
                                        final File? oviImage =
                                            OviDetails.selectedOviImage;
                                        MainAnimalDam mother =
                                            OviDetails
                                                .selectedOviDam.first;

                                        MainAnimalSire father =
                                            OviDetails
                                                .selectedOviSire.first;

                                        widget.selectedChildren.add(
                                            BreedChildItem(
                                                OviDetails.animalName,
                                                oviImage,
                                                OviDetails
                                                    .selectedOviGender));
                                      }
                                    });
                                  },
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x28CACBCD),
                            blurRadius: 8,
                            offset: Offset(0, -4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: PrimaryButton(
                        text: 'Confirm'.tr,
                        minimumSize: const Size(0, 52),
                        onPressed: () {
                          widget.ref
                              .read(breedingChildrenDetailsProvider
                              .notifier)
                              .update((state) => widget.selectedChildren);
                          Navigator.pop(context);
                          // Append the selected children to the existing list
                          // final List<MainAnimalDam>
                          // existingSelectedDam =
                          // ref.read(animalDamDetailsProvider);
                          // existingSelectedDam.addAll(selectedDam);
                          // existingSelectedDam.addAll(selectedMother);
                          //
                          // final List<MainAnimalSire>
                          // existingSelectedSire =
                          // ref.read(animalSireDetailsProvider);
                          // existingSelectedSire.addAll(selectedFather);

                          // for (MainAnimalDam dam in selectedDam) {
                          //   if (dam.mother != null) {
                          //     existingSelectedDam.add(dam.mother!);
                          //   }
                          // }
                        },
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
