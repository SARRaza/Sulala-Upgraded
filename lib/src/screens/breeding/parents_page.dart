// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import 'package:sulala_upgrade/src/screens/create_animal/owned_animal_detail_reg_mode.dart';

import '../../data/classes.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

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
    father = ref.read(ovianimalsProvider).firstWhereOrNull((animal) => animal
        .animalName == widget.OviDetails.selectedOviSire.first.animalName);
    mother = ref.read(ovianimalsProvider).firstWhereOrNull((animal) => animal
        .animalName == widget.OviDetails.selectedOviDam.first.animalName);
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
            right: 16 * globals.widthMediaQuery,
            left: 16 * globals.widthMediaQuery),
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
                          height: 151 * globals.heightMediaQuery,
                        ),
                        Image.asset('assets/illustrations/cowx_child.png'),
                        SizedBox(height: 32 * globals.heightMediaQuery),
                        Text(
                          'No Parents ',
                          style:
                              AppFonts.headline3(color: AppColors.grayscale90),
                        ),
                        SizedBox(
                          height: 8 * globals.heightMediaQuery,
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
                          height: 125 * globals.heightMediaQuery,
                        ),
                        SizedBox(
                          width: 130 * globals.widthMediaQuery,
                          height: 52 * globals.heightMediaQuery,
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
                        height: 24 * globals.heightMediaQuery,
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
                                onTap: () => Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                        OwnedAnimalDetailsRegMode(imagePath: '',
                                            title: '', geninfo: '',
                                            OviDetails: father!,
                                            breedingEvents: const []))),
                              ),
                            ],
                          ),
                          SizedBox(width: 55 * globals.widthMediaQuery),
                          ParentsItem(
                            id: mother!.id.toString(),
                            name: mother!.animalName,
                            sex: 'Female',
                            age: '1 year'.trPlural('numYears', mother!.age,
                                [mother!.age.toString()]),
                            imageFile: mother!.selectedOviImage,
                            OviDetails: widget.OviDetails,
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    OwnedAnimalDetailsRegMode(imagePath: '',
                                        title: '', geninfo: '',
                                        OviDetails: mother!,
                                        breedingEvents: const []))),
                            // imageUrl:'https://www.ghorse.com/sites/default/files/img_0682.jpg',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24 * globals.heightMediaQuery,
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
                      //     SizedBox(width: 55 * globals.widthMediaQuery),
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
                        height: 120 * globals.heightMediaQuery,
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
    final ovianimals = ref.read(ovianimalsProvider).where((animal) => animal.id
        != widget.OviDetails.id).toList();
    final selectedFather = <MainAnimalSire>[];
    final selectedMother = <MainAnimalDam>[];
    List<MainAnimalSire> selectedSire = [];
    List<MainAnimalDam> selectedDam = [];

    if(father == null) {
      await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        showDragHandle: false,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AnimalSireModal(
              ovianimals: ovianimals,
              selectedSire: selectedSire,
              selectedFather: selectedFather,
              selectedMother: selectedMother,
              ref: ref,
              selectedDam: selectedDam);
        },
      );
    }

    if(mounted && mother == null) {
      await showModalBottomSheet(
        context: context,
        showDragHandle: false,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AnimalDamModal(
              ovianimals: ovianimals,
              selectedDam: selectedDam,
              selectedFather: selectedFather,
              selectedMother: selectedMother,
              ref: ref);
        },
      );
    }

    final selectedOviSire = ref.read(animalSireDetailsProvider).first;
    final selectedOviDam = ref.read(animalDamDetailsProvider).first;
    final oviDetails = widget.OviDetails;
    oviDetails.selectedOviSire[0] = selectedOviSire;
    oviDetails.selectedOviDam[0] = selectedOviDam;
    ref.read(ovianimalsProvider.notifier).update((state) {
      final index = state.indexWhere((animal) => animal.animalName == oviDetails.animalName);
      state[index] = oviDetails;
      return state;
    });
    setState(() {
      father ??= ref.read(ovianimalsProvider).firstWhereOrNull((animal) => animal
            .animalName == selectedOviSire.animalName);

      mother ??= ref.read(ovianimalsProvider).firstWhereOrNull((animal) => animal
          .animalName == selectedOviDam.animalName);
    });
  }
}
