import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import '../../data/classes/breeding_event_variables.dart';
import '../../data/globals.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import 'drow_up_animal_breed.dart';
import 'drow_up_animal_species.dart';
import 'select_options.dart';

class CreateAnimalPage extends ConsumerStatefulWidget {
  final List<BreedingEventVariables> breedingEvents;

  const CreateAnimalPage({super.key, required this.breedingEvents});

  @override
  ConsumerState<CreateAnimalPage> createState() => _CreateAnimalPageState();
}

class _CreateAnimalPageState extends ConsumerState<CreateAnimalPage> {
  String selectedAnimalType = '';
  String selectedAnimalSpecies = '';
  String selectedAnimalBreed = '';
  bool showAnimalSpeciesSection = false;
  bool showAnimalBreedsSection = false;
  bool areAllOptionsSelected() {
    final selectedAnimalType = ref.watch(selectedAnimalTypeProvider);
    return selectedAnimalType.isNotEmpty &&
        selectedAnimalSpecies.isNotEmpty &&
        selectedAnimalBreed.isNotEmpty;
  }

  List<String> mammalSpeciesList = [
    'Dog',
    'Cat',
    'Elephant',
    'Lion',
  ];

  List<String> oviparousSpeciesList = [
    'Duck',
    'Chicken',
    'Turtle',
    'Snake',
  ];

  List<String> modalMammalSpeciesList = [
    'Monkey',
    'Bear',
    'Tiger',
    'Giraffe',
    'Kangaroo',
    'Horse',
    'Zebra',
    'Panda',
  ];
  List<String> modalOviSpeciesList = [
    'Crocodile',
    'Eagle',
    'Frog',
    'Fish',
    'Penguin',
    'Alligator',
    'Salmon',
    'Gecko',
  ];

  List<String> modalAnimalBreedsList = ['Bengali', 'Africani', 'Reticulatedii'];

  final Map<String, String> animalImages = {
    'Mammal': 'assets/avatars/120px/Horse_avatar.png',
    'Oviparous': 'assets/avatars/120px/Duck.png',
  };

  @override
  Widget build(BuildContext context) {
    final selectedAnimalType = ref.watch(selectedAnimalTypeProvider);
    final selectedAnimalSpecies = ref.watch(selectedAnimalSpeciesProvider);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Create Animal'.tr,
          style: AppFonts.headline3(color: AppColors.grayscale90),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Container(
                  width: SizeConfig.widthMultiplier(context) * 37.5,
                  height: SizeConfig.widthMultiplier(context) * 37.5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grayscale10,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: AppColors.grayscale90,
                  )),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.widthMultiplier(context) * 16,
              right: SizeConfig.widthMultiplier(context) * 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Animal Type'.tr,
                style: AppFonts.headline2(color: AppColors.grayscale90),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 24,
              ),
              Column(
                children: [
                  _buildAnimalTypeOption('Mammal'),
                  _buildAnimalTypeOption('Oviparous'),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 16,
              ),
              if (showAnimalSpeciesSection)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 1,
                        width: SizeConfig.widthMultiplier(context) * 343,
                        color: AppColors.grayscale20,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier(context) * 16,
                    ),
                    Text(
                      'Animal Species'.tr,
                      style: AppFonts.headline2(color: AppColors.grayscale90),
                    ),
                    for (String species in selectedAnimalType == 'Mammal'
                        ? mammalSpeciesList
                        : oviparousSpeciesList)
                      _buildAnimalSpeciesOption(species),
                    PrimaryTextButton(
                      status: TextStatus.idle,
                      position: TextButtonPosition.right,
                      onPressed: () {
                        // Show different list based on selectedAnimalType
                        if (selectedAnimalType == 'Mammal') {
                          _showAnimalSpecies(
                              'species', context, modalMammalSpeciesList);
                        } else {
                          _showAnimalSpecies(
                              'species', context, modalOviSpeciesList);
                        }
                      },
                      text: 'Show More'.tr,
                    ),
                  ],
                ),
              if (showAnimalBreedsSection)
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier(context) * 6,
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: SizeConfig.widthMultiplier(context) * 343,
                      color: AppColors.grayscale20,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier(context) * 16,
                  ),
                  Text(
                    'Animal Breeds'.tr,
                    style: AppFonts.headline2(color: AppColors.grayscale90),
                  ),
                  for (String breed in selectedAnimalType == 'Mammal'
                      ? (mammalSpeciesList.contains(selectedAnimalSpecies)
                          ? speciesToBreedsMap[selectedAnimalSpecies] ?? []
                          : [])
                      : (oviparousSpeciesList.contains(selectedAnimalSpecies)
                          ? speciesToBreedsMap[selectedAnimalSpecies] ?? []
                          : []))
                    _buildAnimalBreedOption(breed),
                  PrimaryTextButton(
                    onPressed: () {
                      _showAnimalBreed('breeds', context);
                    },
                    text: 'Show More',
                    status: TextStatus.idle,
                    position: TextButtonPosition.right,
                  ),
                ]),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              showAnimalSpeciesSection = selectedAnimalType.isNotEmpty;
              showAnimalBreedsSection = selectedAnimalSpecies.isNotEmpty;
            });
            if (areAllOptionsSelected()) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectedOptionsPage(
                    breedingEvents: widget.breedingEvents,
                  ),
                ),
              );
            }
            // Handle "Continue" button press
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 36, 86, 38),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ));
  }

  Widget _buildAnimalTypeOption(String animalType) {
    final imageAsset = animalImages[animalType]!;
    final isSelected =
        ref.read(selectedAnimalTypeProvider.notifier).state == animalType;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundImage: AssetImage(imageAsset),
        backgroundColor: Colors.transparent,
      ),
      title:
          Text(animalType, style: AppFonts.body2(color: AppColors.grayscale90)),
      trailing: Container(
        width: SizeConfig.widthMultiplier(context) * 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.primary20 : AppColors.grayscale30,
            width: isSelected ? 6.0 : 1.0,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          ref
              .read(selectedAnimalTypeProvider.notifier)
              .update((state) => animalType);
        });
      },
    );
  }

  Widget _buildAnimalSpeciesOption(String optionText) {
    final isSelected = selectedAnimalSpecies == optionText;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title:
          Text(optionText, style: AppFonts.body2(color: AppColors.grayscale90)),
      trailing: Container(
        width: SizeConfig.widthMultiplier(context) * 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.primary20 : AppColors.grayscale30,
            width: isSelected ? 6.0 : 1.0,
          ),
        ),
      ),
      onTap: () {
        // setState(() {
        //   selectedAnimalSpecies = isSelected ? '' : optionText;
        // });
        setState(() {
          ref
              .read(selectedAnimalSpeciesProvider.notifier)
              .update((state) => optionText);
          selectedAnimalSpecies = isSelected ? '' : optionText;
        });
      },
    );
  }

  Widget _buildAnimalBreedOption(String optionText) {
    final isSelected = selectedAnimalBreed == optionText;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        optionText,
        style: AppFonts.body2(color: AppColors.grayscale90),
      ),
      trailing: Container(
        width: SizeConfig.widthMultiplier(context) * 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.primary20 : AppColors.grayscale30,
            width: isSelected ? 6.0 : 1.0,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          ref
              .read(selectedAnimalBreedsProvider.notifier)
              .update((state) => optionText);
          selectedAnimalBreed = isSelected ? '' : optionText;
        });
      },
    );
  }

  void _showAnimalSpecies(
      String section, BuildContext context, List<String> speciesList) async {
    List<String> filteredModalList = List.from(speciesList);
    TextEditingController searchValue = TextEditingController();

    DrowupAnimalSpecies drowupAnimalSpecies = DrowupAnimalSpecies(
      searchValue: searchValue,
      filteredModalList: filteredModalList,
      modalAnimalSpeciesList: speciesList,
      setState: setState,
    );

    drowupAnimalSpecies.resetSelection();

    final selectedSpeciesValue = await showModalBottomSheet<String>(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return drowupAnimalSpecies;
      },
    );

    if (selectedSpeciesValue != null) {
      setState(() {
        {
          mammalSpeciesList.remove(selectedSpeciesValue);
          mammalSpeciesList.insert(0, selectedSpeciesValue);
          selectedAnimalSpecies = selectedSpeciesValue;
        }
        {
          oviparousSpeciesList.remove(selectedSpeciesValue);
          oviparousSpeciesList.insert(0, selectedSpeciesValue);
          selectedAnimalSpecies = selectedSpeciesValue;
        }
      });
    }
  }

  void _showAnimalBreed(String section, BuildContext context) async {
    List<String> filteredBreedList =
        List.from(morespeciesToBreedsMap[selectedAnimalSpecies] ?? []);
    TextEditingController searchValue = TextEditingController();

    DrowupAnimalBreed drowupAnimalBreed = DrowupAnimalBreed(
      searchValue: searchValue,
      filteredBreedList: filteredBreedList,
      setState: setState,
      morespeciesToBreedsMap: morespeciesToBreedsMap,
      selectedAnimalSpecies: selectedAnimalSpecies,
    );

    drowupAnimalBreed.resetSelection();

    final selectedBreedValue = await showModalBottomSheet<String>(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return drowupAnimalBreed;
      },
    );

    if (selectedBreedValue != null) {
      setState(() {
        List<String> breedsList =
            speciesToBreedsMap[selectedAnimalSpecies] ?? [];
        breedsList.remove(selectedBreedValue);
        breedsList.insert(0, selectedBreedValue);
        speciesToBreedsMap[selectedAnimalSpecies] = breedsList;
        selectedAnimalBreed = selectedBreedValue;
      });
    }
  }
}
