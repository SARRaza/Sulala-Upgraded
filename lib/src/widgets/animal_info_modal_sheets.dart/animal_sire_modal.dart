import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../data/classes.dart';
import '../../data/riverpod_globals.dart';
import '../../helpers/breeding_helper.dart';
import '../controls_and_buttons/buttons/primary_button.dart';

class AnimalSireModal extends ConsumerStatefulWidget {
  const AnimalSireModal({
    super.key,
    required this.selectedAnimal,
    required this.selectedFather,
    required this.selectedMother,
    required this.selectedChildren,
  });
  final OviVariables selectedAnimal;
  final MainAnimalSire? selectedFather;
  final MainAnimalDam? selectedMother;
  final List<BreedChildItem> selectedChildren;

  @override
  ConsumerState<AnimalSireModal> createState() => _AnimalSireModalState();
}

class _AnimalSireModalState extends ConsumerState<AnimalSireModal> {
  String searchQuery = '';
  MainAnimalSire? selectedFather;
  late List<OviVariables> animals;
  late BreedingHelper _breedingHelper;

  @override
  void initState() {
    selectedFather = widget.selectedFather;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _breedingHelper = BreedingHelper(ref);
    animals = _breedingHelper.getPossibleFathers(widget.selectedAnimal
        .copyWith(selectedOviSire: selectedFather,
        selectedOviDam: widget.selectedMother, breedchildren: widget
            .selectedChildren)
    );

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
            // left: 16,
            // right: 16,
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
                  'Add father'.tr,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: animals.length,
                            itemBuilder: (context, index) {
                              final OviDetails = animals[index];
                              final bool isSelected = selectedFather != null &&
                                  selectedFather!.id == OviDetails.id;

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
                                    backgroundImage: OviDetails
                                        .selectedOviImage,
                                    child: OviDetails.selectedOviImage ==
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
                                          'Mother: ${OviDetails.selectedOviDam
                                              != null ? OviDetails.selectedOviDam!
                                              .animalName : 'Unknown'}'),
                                      if (OviDetails.selectedOviDam != null)
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Maternal Father: ${OviDetails
                                                    .selectedOviDam!.father !=
                                                    null ? OviDetails
                                                    .selectedOviDam!.father!
                                                    .animalName : 'Unknown'.tr}'
                                            ),
                                            if (OviDetails.selectedOviDam!
                                                .mother !=
                                                null)
                                              Text(
                                                  'Maternal Mother: ${OviDetails
                                                      .selectedOviDam!.mother !=
                                                      null ? OviDetails
                                                      .selectedOviDam!.mother!
                                                      .animalName : 'Unknown'.tr
                                                  }'),
                                          ],
                                        ),
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedFather = null;
                                      } else {
                                        // Use a default image (icon) if selectedOviImage is null
                                        final ImageProvider? oviImage =
                                            OviDetails.selectedOviImage;
                                        MainAnimalDam? mother = OviDetails
                                            .selectedOviDam;

                                        MainAnimalSire? father = OviDetails
                                            .selectedOviSire;

                                        selectedFather = MainAnimalSire(
                                            OviDetails.animalName,
                                            oviImage,
                                            OviDetails.selectedOviGender,
                                            mother: mother,
                                            father: father);

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
                          ref
                              .read(animalSireDetailsProvider.notifier)
                              .update((state) => selectedFather);
                          Navigator.pop(context);
                          // Append the selected children to the existing list
                          final List<MainAnimalDam> existingSelectedDam = [];
                          final animalDamDetails = ref.read(
                              animalDamDetailsProvider);
                          if(animalDamDetails != null) {
                            existingSelectedDam.add(animalDamDetails);
                          }

                          final List<MainAnimalSire> existingSelectedSire = [];
                          final animalSireDetails = ref.read(
                              animalSireDetailsProvider);
                          if(animalSireDetails != null) {
                            existingSelectedSire.add(animalSireDetails);
                          }
                          if(selectedFather != null) {
                            existingSelectedSire.add(selectedFather!);
                          }

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