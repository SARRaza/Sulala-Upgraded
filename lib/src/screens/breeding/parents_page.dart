import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/screens/create_animal/owned_animal_detail_reg_mode.dart';

import '../../data/classes/breed_child_item.dart';
import '../../data/classes/main_animal_dam.dart';
import '../../data/classes/main_animal_sire.dart';
import '../../data/classes/ovi_variables.dart';
import '../../data/globals.dart';
import '../../data/providers/animal_providers.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';

import '../../widgets/animal_info_modal_sheets.dart/animal_dam_modal.dart';
import '../../widgets/animal_info_modal_sheets.dart/animal_sire_modal.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/other/parents_item.dart';

class ParentsPage extends ConsumerStatefulWidget {
  final int animalId;

  const ParentsPage({
    super.key,
    required this.animalId,
  });
  @override
  ConsumerState<ParentsPage> createState() => _ParentsPageState();
}

class _ParentsPageState extends ConsumerState<ParentsPage> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(animalListProvider).when(
        error: (error, trace) => Scaffold(
              body: Center(
                child: Text('Error $error'),
              ),
            ),
        loading: () => const CircularProgressIndicator(),
        data: (animals) {
          final selectedAnimal = animals
              .firstWhereOrNull((animal) => animal.id == widget.animalId);
          if (selectedAnimal == null) {
            return Scaffold(
              body: Center(
                child: Text('Animal not found'.tr),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0.0,
              centerTitle: true,
              title: Text(
                selectedAnimal.animalName,
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
              child: ref.watch(animalListProvider).when(
                  data: (animals) {
                    final father = animals.firstWhereOrNull((animal) =>
                        animal.id == selectedAnimal.selectedOviSire?.animalId);
                    final mother = animals.firstWhereOrNull((animal) =>
                        animal.id == selectedAnimal.selectedOviDam?.animalId);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Parents '.tr,
                          style: AppFonts.title3(color: AppColors.grayscale90),
                        ),
                        father == null && mother == null
                            ? Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 151 *
                                          SizeConfig.heightMultiplier(context),
                                    ),
                                    Image.asset(
                                        'assets/illustrations/cow_x_child.png'),
                                    SizedBox(
                                        height: 32 *
                                            SizeConfig.heightMultiplier(
                                                context)),
                                    Text(
                                      'No Parents '.tr,
                                      style: AppFonts.headline3(
                                          color: AppColors.grayscale90),
                                    ),
                                    SizedBox(
                                      height: 8 *
                                          SizeConfig.heightMultiplier(context),
                                    ),
                                    Text(
                                      "This Animal Doesn't Have Parents.".tr,
                                      style: AppFonts.body2(
                                          color: AppColors.grayscale70),
                                    ),
                                    Text(
                                      "Add Parent By Pressing The Button Below."
                                          .tr,
                                      style: AppFonts.body2(
                                          color: AppColors.grayscale70),
                                    ),
                                    SizedBox(
                                      height: 125 *
                                          SizeConfig.heightMultiplier(context),
                                    ),
                                    SizedBox(
                                      width: 130 *
                                          SizeConfig.widthMultiplier(context),
                                      height: 52 *
                                          SizeConfig.heightMultiplier(context),
                                      child: PrimaryButton(
                                        text: 'Add Parents'.tr,
                                        onPressed: () => _addParents(
                                            selectedAnimal, father, mother),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 24 *
                                        SizeConfig.heightMultiplier(context),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          if (father != null)
                                            ParentsItem(
                                              oviDetails: father,
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OwnedAnimalDetailsRegMode(
                                                            animalId:
                                                                father.id!,
                                                          ))),
                                            ),
                                        ],
                                      ),
                                      SizedBox(
                                          width: 55 *
                                              SizeConfig.widthMultiplier(
                                                  context)),
                                      if (mother != null)
                                        ParentsItem(
                                          oviDetails: mother,
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OwnedAnimalDetailsRegMode(
                                                        animalId: mother.id!,
                                                      ))),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24 *
                                        SizeConfig.heightMultiplier(context),
                                  ),
                                  SizedBox(
                                    height: 120 *
                                        SizeConfig.heightMultiplier(context),
                                  ),
                                ],
                              ),
                      ],
                    );
                  },
                  error: (Object error, StackTrace stackTrace) =>
                      Text(error.toString()),
                  loading: () => const CircularProgressIndicator()),
            ),
          );
        });
  }

  Future<void> _addParents(OviVariables selectedAnimal, OviVariables? father,
      OviVariables? mother) async {
    var selectedFather = father != null
        ? MainAnimalSire(
            animalId: father.id!,
            animalName: father.animalName,
            selectedOviImage: father.selectedOviImage,
            selectedOviGender: 'Male')
        : null;
    var selectedMother = mother != null
        ? MainAnimalDam(
            animalId: mother.id!,
            animalName: mother.animalName,
            selectedOviImage: mother.selectedOviImage,
            selectedOviGender: 'Female')
        : null;

    final selectedChildren = ref
            .read(animalListProvider)
            .value
            ?.where((animal) =>
                (animal.selectedOviSire?.animalId == selectedAnimal.id) ||
                (animal.selectedOviDam?.animalId == selectedAnimal.id))
            .toList()
            .map((animal) => BreedChildItem(
                animalId: animal.id!,
                animalName: animal.animalName,
                selectedOviImage: animal.selectedOviImage,
                selectedOviGender: animal.selectedOviGender))
            .toList() ??
        [];

    if (father == null) {
      selectedFather = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        showDragHandle: false,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AnimalSireModal(
            selectedAnimal: selectedAnimal,
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
            selectedAnimal: selectedAnimal,
            selectedFather: selectedFather,
            selectedMother: selectedMother,
            selectedChildren: selectedChildren,
          );
        },
      );
    }

    ref.read(animalListProvider.notifier).updateAnimal(selectedAnimal.copyWith(
        selectedOviSire: selectedFather, selectedOviDam: selectedMother));
  }
}
