import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/helpers/breeding_helper.dart';

import '../../data/classes/breed_child_item.dart';
import '../../data/classes/breeding_partner.dart';
import '../../data/classes/main_animal_dam.dart';
import '../../data/classes/main_animal_sire.dart';
import '../../data/classes/ovi_variables.dart';
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
  late final BreedingHelper _breedingHelper;

  @override
  void initState() {
    super.initState();
    selectedChildren = widget.selectedChildren;
    _breedingHelper = BreedingHelper(ref);
  }

  @override
  Widget build(BuildContext context) {
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
                            decoration: InputDecoration(
                                hintText: "Search By Name Or ID".tr,
                                prefixIcon: const Icon(Icons.search),
                                border: InputBorder.none,
                                hintStyle: const TextStyle(
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
                              final oviDetails = animals[index];
                              final bool isSelected = selectedChildren.any(
                                  (child) =>
                                      child.animalName ==
                                      oviDetails.animalName);

                              if (!oviDetails.animalName
                                      .toLowerCase()
                                      .contains(searchQuery) &&
                                  !oviDetails.selectedAnimalType
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
                                        oviDetails.selectedOviImage,
                                    child: oviDetails.selectedOviImage == null
                                        ? const Icon(
                                            Icons.camera_alt_outlined,
                                            size: 50,
                                            color: Colors.grey,
                                          )
                                        : null,
                                  ),
                                  title: Text(oviDetails.animalName),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Gender:'.trParams({
                                        'gender': oviDetails.selectedOviGender
                                      })),
                                      Text('Mother:'.trParams({
                                        'mother':
                                            oviDetails.selectedOviDam != null
                                                ? oviDetails
                                                    .selectedOviDam!.animalName
                                                : 'Unknown'.tr
                                      })),
                                      if (oviDetails.selectedOviDam != null &&
                                          oviDetails.selectedOviDam!.father !=
                                              null)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Maternal Father:'.trParams({
                                              'father': oviDetails
                                                  .selectedOviDam!
                                                  .father!
                                                  .animalName
                                            })),
                                            if (oviDetails
                                                    .selectedOviDam!.mother !=
                                                null)
                                              Text('Maternal Mother:'.trParams({
                                                'mother': oviDetails
                                                    .selectedOviDam!
                                                    .mother!
                                                    .animalName
                                              })),
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
                                              oviDetails.animalName,
                                        );
                                      } else {
                                        // Use a default image (icon) if selectedOviImage is null
                                        final ImageProvider? oviImage =
                                            oviDetails.selectedOviImage;

                                        selectedChildren.add(BreedChildItem(
                                            animalId: oviDetails.id!,
                                            animalName: oviDetails.animalName,
                                            selectedOviImage: oviImage,
                                            selectedOviGender: oviDetails
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
                        onPressed: () => Navigator.pop(context, selectedChildren)
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
