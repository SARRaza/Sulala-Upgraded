// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import 'package:sulala_upgrade/src/screens/create_animal/owned_animal_detail_reg_mode.dart';

import '../../data/classes/breed_child_item.dart';
import '../../data/classes/main_animal_dam.dart';
import '../../data/classes/main_animal_sire.dart';
import '../../data/classes/ovi_variables.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

import '../../widgets/animal_info_modal_sheets.dart/animal_dam_modal.dart';
import '../../widgets/animal_info_modal_sheets.dart/animal_sire_modal.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/other/parents_item.dart';

class ParentsPage extends ConsumerStatefulWidget {
  final String selectedOviSire;
  final String selectedMammalSire;
  final String selectedOviDam;
  final String selectedMammalDam;
  final OviVariables OviDetails;

  const ParentsPage({
    super.key,
    required this.selectedOviSire,
    required this.OviDetails,
    required this.selectedMammalSire,
    required this.selectedOviDam,
    required this.selectedMammalDam,
  });
  @override
  ConsumerState<ParentsPage> createState() => _ParentsPageState();
}

class _ParentsPageState extends ConsumerState<ParentsPage> {
  late OviVariables? father;
  late OviVariables? mother;

  @override
  void initState() {
    father = ref.read(ovianimalsProvider).firstWhereOrNull((animal) =>
        widget.OviDetails.selectedOviSire != null &&
        animal.animalName == widget.OviDetails.selectedOviSire!.animalName);
    mother = ref.read(ovianimalsProvider).firstWhereOrNull((animal) =>
        widget.OviDetails.selectedOviDam != null &&
        animal.animalName == widget.OviDetails.selectedOviDam!.animalName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: EdgeInsets.only(
            right: 16 * SizeConfig.widthMultiplier(context),
            left: 16 * SizeConfig.widthMultiplier(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Parents ',
              style: AppFonts.title3(color: AppColors.grayscale90),
            ),
            father == null || mother == null
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 151 * SizeConfig.heightMultiplier(context),
                        ),
                        Image.asset('assets/illustrations/cowx_child.png'),
                        SizedBox(
                            height: 32 * SizeConfig.heightMultiplier(context)),
                        Text(
                          'No Parents ',
                          style:
                              AppFonts.headline3(color: AppColors.grayscale90),
                        ),
                        SizedBox(
                          height: 8 * SizeConfig.heightMultiplier(context),
                        ),
                        Text(
                          "This Animal Doesn't Have Parents.",
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                        Text(
                          "Add Parent By Pressing The Button Below.",
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                        SizedBox(
                          height: 125 * SizeConfig.heightMultiplier(context),
                        ),
                        SizedBox(
                          width: 130 * SizeConfig.widthMultiplier(context),
                          height: 52 * SizeConfig.heightMultiplier(context),
                          child: PrimaryButton(
                            text: 'Add Parents',
                            onPressed: addParents,
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 24 * SizeConfig.heightMultiplier(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              ParentsItem(
                                id: father!.id.toString(),
                                name: father!.animalName,
                                sex: 'Male',
                                age: '1 year'.trPlural('numYears', father!.age,
                                    [father!.age.toString()]),
                                imageFile: father!.selectedOviImage,
                                OviDetails: widget.OviDetails,
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OwnedAnimalDetailsRegMode(
                                                imagePath: '',
                                                title: '',
                                                geninfo: '',
                                                OviDetails: father!,
                                                breedingEvents: const []))),
                              ),
                            ],
                          ),
                          SizedBox(
                              width: 55 * SizeConfig.widthMultiplier(context)),
                          ParentsItem(
                            id: mother!.id.toString(),
                            name: mother!.animalName,
                            sex: 'Female',
                            age: '1 year'.trPlural('numYears', mother!.age,
                                [mother!.age.toString()]),
                            imageFile: mother!.selectedOviImage,
                            OviDetails: widget.OviDetails,
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OwnedAnimalDetailsRegMode(
                                            imagePath: '',
                                            title: '',
                                            geninfo: '',
                                            OviDetails: mother!,
                                            breedingEvents: const []))),
                            // imageUrl:'https://www.ghorse.com/sites/default/files/img_0682.jpg',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24 * SizeConfig.heightMultiplier(context),
                      ),
                      // const Text('Paternal Grand Parents'),
                      // if (widget.OviDetails.selectedOviSire.isNotEmpty &&
                      //     widget.OviDetails.selectedOviSire.first.father !=
                      //         null)
                      //   Text(
                      //     'Grandfather: ${widget.OviDetails.selectedOviSire.first.father!.animalName}',
                      //   ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Column(
                      //       children: [
                      //         ParentsItem(
                      //           id: '2222',
                      //           name: widget.OviDetails.selectedOviSire.first
                      //               .father!.animalName,
                      //           sex: 'Male',
                      //           age: '7 years',
                      //           imageFile: (widget.OviDetails.selectedOviSire
                      //               .first.father!.selectedOviImage),
                      //           OviDetails: widget.OviDetails,
                      //         ),
                      //       ],
                      //     ),
                      //     SizedBox(width: 55 * SizeConfig.widthMultiplier(context)),
                      //     ParentsItem(
                      //       id: '2222',
                      //       name: widget.OviDetails.selectedOviDam.first.mother!
                      //           .animalName,
                      //       sex: 'Female',
                      //       age: '6 years',
                      //       imageFile: (widget.OviDetails.selectedOviDam.first
                      //           .mother!.selectedOviImage),
                      //       OviDetails: widget.OviDetails,
                      //       // imageUrl:'https://www.ghorse.com/sites/default/files/img_0682.jpg',
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 120 * SizeConfig.heightMultiplier(context),
                      ),
                      // Image.asset('assets/illustrations/horse_love.png'),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<void> addParents() async {
    final ovianimals = ref
        .read(ovianimalsProvider)
        .where((animal) => animal.id != widget.OviDetails.id)
        .toList();
    var selectedFather = father != null
        ? MainAnimalSire(father!.animalName, father!.selectedOviImage, 'Male')
        : null;
    var selectedMother = mother != null
        ? MainAnimalDam(mother!.animalName, mother!.selectedOviImage, 'Female')
        : null;

    final selectedChildren = ref
        .read(ovianimalsProvider)
        .where((animal) =>
            (animal.selectedOviSire != null &&
                animal.selectedOviSire!.id == widget.OviDetails.id) ||
            (animal.selectedOviDam != null &&
                animal.selectedOviDam!.id == widget.OviDetails.id))
        .toList()
        .map((animal) => BreedChildItem(animal.animalName,
            animal.selectedOviImage, animal.selectedOviGender))
        .toList();

    if (father == null) {
      selectedFather = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        showDragHandle: false,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AnimalSireModal(
            selectedAnimal: widget.OviDetails,
            selectedFather: selectedFather,
            selectedMother: selectedMother,
            selectedChildren: selectedChildren,
          );
        },
      );
    }

    if (mounted && mother == null) {
      selectedMother = await showModalBottomSheet(
        context: context,
        showDragHandle: false,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AnimalDamModal(
            selectedAnimal: widget.OviDetails,
            selectedFather: selectedFather,
            selectedMother: selectedMother,
            selectedChildren: selectedChildren,
          );
        },
      );
    }

    final oviDetails = widget.OviDetails;
    oviDetails.copyWith(
        selectedOviSire: selectedFather, selectedOviDam: selectedMother);

    ref.read(ovianimalsProvider.notifier).update((state) {
      final index = state
          .indexWhere((animal) => animal.animalName == oviDetails.animalName);
      state[index] = oviDetails;
      return state;
    });
    setState(() {
      if (selectedFather != null) {
        father ??= ref.read(ovianimalsProvider).firstWhereOrNull(
            (animal) => animal.animalName == selectedFather!.animalName);
      }

      if (selectedMother != null) {
        mother ??= ref.read(ovianimalsProvider).firstWhereOrNull(
            (animal) => animal.animalName == selectedMother!.animalName);
      }
    });
  }
}
