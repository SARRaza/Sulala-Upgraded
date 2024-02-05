import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/helpers/breeding_helper.dart';

import '../../data/classes/breed_child_item.dart';
import '../../data/classes/breeding_partner.dart';
import '../../data/classes/main_animal_dam.dart';
import '../../data/classes/main_animal_sire.dart';
import '../../data/classes/ovi_variables.dart';
import '../../data/riverpod_globals.dart';
import '../controls_and_buttons/buttons/primary_button.dart';

class AnimalChildrenModal extends ConsumerStatefulWidget {
  const AnimalChildrenModal(
      {super.key,
      required this.selectedAnimal,
      required this.selectedFather,
      required this.selectedMother,
      required this.selectedChildren,
      this.selectedPartner});

  final OviVariables selectedAnimal;
  final MainAnimalSire? selectedFather;
  final MainAnimalDam? selectedMother;
  final List<BreedChildItem> selectedChildren;
  final BreedingPartner? selectedPartner;

  @override
  ConsumerState<AnimalChildrenModal> createState() =>
      _AnimalChildrenModalState();
}

class _AnimalChildrenModalState extends ConsumerState<AnimalChildrenModal> {
  String searchQuery = '';
  late List<BreedChildItem> selectedChildren;
  late List<OviVariables> animals;
  late BreedingHelper _breedingHelper;

  @override
  void initState() {
    selectedChildren = widget.selectedChildren;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _breedingHelper = BreedingHelper(ref);
    animals = _breedingHelper.getPossibleChildren(widget.selectedAnimal
        .copyWith(
            selectedOviSire: widget.selectedFather,
            selectedOviDam: widget.selectedMother,
            breedChildren: selectedChildren,
            breedPartner: widget.selectedPartner));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 35,
          height: 4,
          decoration: ShapeDecoration(
            color: const Color(0xFFE3E5E7),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: animals.length,
                            itemBuilder: (context, index) {
                              final OviDetails = animals[index];
                              final bool isSelected = selectedChildren.any(
                                  (child) =>
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
                                              BorderRadius.circular(50.0),
                                        )
                                      : null,
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.grey[100],
                                    backgroundImage:
                                        OviDetails.selectedOviImage,
                                    child: OviDetails.selectedOviImage == null
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
                                          'Mother: ${OviDetails.selectedOviDam != null ? OviDetails.selectedOviDam!.animalName : 'Unknown'.tr}'),
                                      if (OviDetails.selectedOviDam != null &&
                                          OviDetails.selectedOviDam!.father !=
                                              null)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Maternal Father: ${OviDetails.selectedOviDam!.father!.animalName}'),
                                            if (OviDetails
                                                    .selectedOviDam!.mother !=
                                                null)
                                              Text(
                                                  'Maternal Mother: ${OviDetails.selectedOviDam!.mother!.animalName}'),
                                          ],
                                        ),
                                    ],
                                  ),
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
                                        MainAnimalDam? mother =
                                            OviDetails.selectedOviDam;

                                        MainAnimalSire? father =
                                            OviDetails.selectedOviSire;

                                        selectedChildren.add(BreedChildItem(
                                            OviDetails.animalName,
                                            oviImage,
                                            OviDetails.selectedOviGender));
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
                          Navigator.pop(context, selectedChildren);
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
