import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../data/classes/breed_child_item.dart';
import '../../data/classes/breeding_partner.dart';
import '../../data/classes/main_animal_dam.dart';
import '../../data/classes/main_animal_sire.dart';
import '../../data/classes/ovi_variables.dart';
import '../../helpers/breeding_helper.dart';

class AnimalPartnerModal extends ConsumerStatefulWidget {
  const AnimalPartnerModal({
    super.key,
    required this.selectedPartner,
    required this.selectedAnimal,
    required this.selectedFather,
    required this.selectedMother,
    required this.selectedChildren,
  });

  final BreedingPartner? selectedPartner;
  final OviVariables selectedAnimal;
  final MainAnimalSire? selectedFather;
  final MainAnimalDam? selectedMother;
  final List<BreedChildItem> selectedChildren;

  @override
  ConsumerState<AnimalPartnerModal> createState() => _AnimalPartnerModalState();
}

class _AnimalPartnerModalState extends ConsumerState<AnimalPartnerModal> {
  String searchQuery = '';
  BreedingPartner? selectedPartner;
  late List<OviVariables> animals;
  late BreedingHelper _breedingHelper;

  @override
  void initState() {
    super.initState();
    selectedPartner = widget.selectedPartner;
    _breedingHelper = BreedingHelper(ref);
    animals = _breedingHelper.getPossiblePartners(widget.selectedAnimal
        .copyWith(
            selectedOviSire: widget.selectedFather,
            selectedOviDam: widget.selectedMother,
            breedChildren: widget.selectedChildren));
  }

  @override
  Widget build(BuildContext context) {
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
            Text(
              "Select Partner".tr,
              style: const TextStyle(
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
                      decoration: InputDecoration(
                        hintText: "Search By Name Or ID".tr,
                        prefixIcon: const Icon(Icons.search),
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
                itemCount: animals.length,
                itemBuilder: (context, index) {
                  final oviDetails = animals[index];
                  final isSelected = oviDetails.id == selectedPartner?.id;
                  // Apply the filter here
                  if (!oviDetails.animalName
                          .toLowerCase()
                          .contains(searchQuery) &&
                      !oviDetails.selectedAnimalType
                          .toLowerCase()
                          .contains(searchQuery)) {
                    return Container(); // Skip this item if it doesn't match the search query
                  }

                  return ListTile(
                    tileColor:
                        isSelected ? Colors.green.withOpacity(0.5) : null,
                    shape: isSelected
                        ? RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )
                        : null,
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey[100],
                      backgroundImage: oviDetails.selectedOviImage,
                      child: oviDetails.selectedOviImage == null
                          ? const Icon(
                              Icons.camera_alt_outlined,
                              size: 50,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                    title: Text(oviDetails.animalName),
                    subtitle: Text(oviDetails.selectedAnimalType),
                    onTap: () {
                      setState(() {
                        selectedPartner = BreedingPartner(
                            oviDetails.animalName,
                            oviDetails.selectedOviImage,
                            oviDetails.selectedOviGender);
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selectedPartner);
              },
              child: Text("Done".tr),
            ),
          ],
        ),
      ),
    );
  }
}
