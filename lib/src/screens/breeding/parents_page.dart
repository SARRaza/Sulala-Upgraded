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

import '../../widgets/animal_info_modal_sheets.dart/animal_dam_modal.dart';
import '../../widgets/animal_info_modal_sheets.dart/animal_sire_modal.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/other/parents_item.dart';

class ParentsPage extends ConsumerStatefulWidget {
  final String selectedOviSire;
  final String selectedMammalSire;
  final String selectedOviDam;
  final String selectedMammalDam;
  final OviVariables oviDetails;

  const ParentsPage({
    super.key,
    required this.selectedOviSire,
    required this.oviDetails,
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
    super.initState();
    father = ref.read(oviAnimalsProvider).firstWhereOrNull((animal) =>
        widget.oviDetails.selectedOviSire != null &&
        animal.animalName == widget.oviDetails.selectedOviSire!.animalName);
    mother = ref.read(oviAnimalsProvider).firstWhereOrNull((animal) =>
        widget.oviDetails.selectedOviDam != null &&
        animal.animalName == widget.oviDetails.selectedOviDam!.animalName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: Text(
          widget.oviDetails.animalName,
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
              'Parents '.tr,
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
                        Image.asset('assets/illustrations/cow_x_child.png'),
                        SizedBox(
                            height: 32 * SizeConfig.heightMultiplier(context)),
                        Text(
                          'No Parents '.tr,
                          style:
                              AppFonts.headline3(color: AppColors.grayscale90),
                        ),
                        SizedBox(
                          height: 8 * SizeConfig.heightMultiplier(context),
                        ),
                        Text(
                          "This Animal Doesn't Have Parents.".tr,
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                        Text(
                          "Add Parent By Pressing The Button Below.".tr,
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                        SizedBox(
                          height: 125 * SizeConfig.heightMultiplier(context),
                        ),
                        SizedBox(
                          width: 130 * SizeConfig.widthMultiplier(context),
                          height: 52 * SizeConfig.heightMultiplier(context),
                          child: PrimaryButton(
                            text: 'Add Parents'.tr,
                            onPressed: _addParents,
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
                                sex: 'Male'.tr,
                                age: '1 year'.trPlural('numYears', father!.age,
                                    [father!.age.toString()]),
                                imageFile: father!.selectedOviImage,
                                OviDetails: widget.oviDetails,
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OwnedAnimalDetailsRegMode(
                                                imagePath: '',
                                                title: '',
                                                genInfo: '',
                                                oviDetails: father!,
                                                breedingEvents: const []))),
                              ),
                            ],
                          ),
                          SizedBox(
                              width: 55 * SizeConfig.widthMultiplier(context)),
                          ParentsItem(
                            id: mother!.id.toString(),
                            name: mother!.animalName,
                            sex: 'Female'.tr,
                            age: '1 year'.trPlural('numYears', mother!.age,
                                [mother!.age.toString()]),
                            imageFile: mother!.selectedOviImage,
                            OviDetails: widget.oviDetails,
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OwnedAnimalDetailsRegMode(
                                            imagePath: '',
                                            title: '',
                                            genInfo: '',
                                            oviDetails: mother!,
                                            breedingEvents: const []))),
                            // imageUrl:'https://www.ghorse.com/sites/default/files/img_0682.jpg',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24 * SizeConfig.heightMultiplier(context),
                      ),
                      SizedBox(
                        height: 120 * SizeConfig.heightMultiplier(context),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _addParents() async {
    var selectedFather = father != null
        ? MainAnimalSire(father!.animalName, father!.selectedOviImage, 'Male')
        : null;
    var selectedMother = mother != null
        ? MainAnimalDam(mother!.animalName, mother!.selectedOviImage, 'Female')
        : null;

    final selectedChildren = ref
        .read(oviAnimalsProvider)
        .where((animal) =>
            (animal.selectedOviSire != null &&
                animal.selectedOviSire!.id == widget.oviDetails.id) ||
            (animal.selectedOviDam != null &&
                animal.selectedOviDam!.id == widget.oviDetails.id))
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
            selectedAnimal: widget.oviDetails,
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
            selectedAnimal: widget.oviDetails,
            selectedFather: selectedFather,
            selectedMother: selectedMother,
            selectedChildren: selectedChildren,
          );
        },
      );
    }

    final oviDetails = widget.oviDetails;
    oviDetails.copyWith(
        selectedOviSire: selectedFather, selectedOviDam: selectedMother);

    ref.read(oviAnimalsProvider.notifier).update((state) {
      final index = state
          .indexWhere((animal) => animal.animalName == oviDetails.animalName);
      state[index] = oviDetails;
      return state;
    });
    setState(() {
      if (selectedFather != null) {
        father ??= ref.read(oviAnimalsProvider).firstWhereOrNull(
            (animal) => animal.animalName == selectedFather!.animalName);
      }

      if (selectedMother != null) {
        mother ??= ref.read(oviAnimalsProvider).firstWhereOrNull(
            (animal) => animal.animalName == selectedMother!.animalName);
      }
    });
  }
}
