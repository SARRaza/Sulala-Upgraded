import 'package:flutter/material.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import 'drow_up_animal_breed.dart';
import 'drow_up_animal_species.dart';
import 'select_options.dart';

class CreateAnimalPage extends StatefulWidget {
  const CreateAnimalPage({Key? key}) : super(key: key);

  @override
  State<CreateAnimalPage> createState() => _CreateAnimalPageState();
}

class _CreateAnimalPageState extends State<CreateAnimalPage> {
  String selectedAnimalType = '';
  String selectedAnimalSpecies = '';
  String selectedAnimalBreed = '';
  bool showAnimalSpeciesSection = false;
  bool showAnimalBreedsSection = false;
  bool areAllOptionsSelected() {
    return selectedAnimalType.isNotEmpty &&
        selectedAnimalSpecies.isNotEmpty &&
        selectedAnimalBreed.isNotEmpty;
  }

  List<String> animalSpeciesList = ['Sheep', 'Cow', 'Horse'];
  List<String> modalAnimalSpeciesList = [
    'Tiger',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Elephant',
    'Giraffe'
  ];
  List<String> animalBreedsList = ['Bengal', 'African', 'Reticulated'];
  List<String> modalAnimalBreedsList = ['Bengali', 'Africani', 'Reticulatedii'];

  final Map<String, String> animalImages = {
    'Mammal': 'assets/avatars/120px/Horse_avatar.png',
    'Oviparous': 'assets/avatars/120px/Duck.png',
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            'Create Animal',
            style: AppFonts.headline3(color: AppColors.grayscale90),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Container(
                    width: globals.widthMediaQuery * 37.5,
                    height: globals.widthMediaQuery * 37.5,
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
                left: globals.widthMediaQuery * 16,
                right: globals.widthMediaQuery * 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Animal Type',
                  style: AppFonts.headline2(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: globals.heightMediaQuery * 24,
                ),
                Column(
                  children: [
                    _buildAnimalTypeOption('Mammal'),
                    _buildAnimalTypeOption('Oviparous'),
                  ],
                ),
                SizedBox(
                  height: globals.heightMediaQuery * 16,
                ),
                if (showAnimalSpeciesSection)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 1,
                          width: globals.widthMediaQuery * 343,
                          color: AppColors.grayscale20,
                        ),
                      ),
                      SizedBox(
                        height: globals.heightMediaQuery * 16,
                      ),
                      Text(
                        'Animal Species',
                        style: AppFonts.headline2(color: AppColors.grayscale90),
                      ),
                      for (String species in animalSpeciesList)
                        _buildAnimalSpeciesOption(species),
                      PrimaryTextButton(
                        status: TextStatus.idle,
                        position: TextButtonPosition.right,
                        onPressed: () {
                          _showAnimalSpecies('species', context);
                        },
                        text: 'Show More',
                      ),
                    ],
                  ),
                if (showAnimalBreedsSection)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: globals.heightMediaQuery * 6,
                        ),
                        Center(
                          child: Container(
                            height: 1,
                            width: globals.widthMediaQuery * 343,
                            color: AppColors.grayscale20,
                          ),
                        ),
                        SizedBox(
                          height: globals.heightMediaQuery * 16,
                        ),
                        Text(
                          'Animal Breeds',
                          style:
                              AppFonts.headline2(color: AppColors.grayscale90),
                        ),
                        for (String breed in animalBreedsList)
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
                      selectedAnimalType: selectedAnimalType,
                      selectedAnimalSpecies: selectedAnimalSpecies,
                      selectedAnimalBreed: selectedAnimalBreed,
                    ),
                  ),
                );
              }
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
      ),
    );
  }

  Widget _buildAnimalTypeOption(String animalType) {
    final imageAsset = animalImages[animalType]!;
    final isSelected = selectedAnimalType == animalType;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundImage: AssetImage(imageAsset),
        backgroundColor: Colors.transparent,
      ),
      title:
          Text(animalType, style: AppFonts.body2(color: AppColors.grayscale90)),
      trailing: Container(
        width: globals.widthMediaQuery * 24,
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
          selectedAnimalType = animalType;
        });
      },
    );
  }

  Widget _buildAnimalSpeciesOption(String optionText) {
    final isSelectedSpecies = selectedAnimalSpecies == optionText;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title:
          Text(optionText, style: AppFonts.body2(color: AppColors.grayscale90)),
      trailing: Container(
        width: globals.widthMediaQuery * 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color:
                isSelectedSpecies ? AppColors.primary20 : AppColors.grayscale30,
            width: isSelectedSpecies ? 6.0 : 1.0,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          selectedAnimalSpecies = isSelectedSpecies ? '' : optionText;
        });
      },
    );
  }

  Widget _buildAnimalBreedOption(String optionText) {
    final isSelectedBreed = selectedAnimalBreed == optionText;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        optionText,
        style: AppFonts.body2(color: AppColors.grayscale90),
      ),
      trailing: Container(
        width: globals.widthMediaQuery * 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color:
                isSelectedBreed ? AppColors.primary20 : AppColors.grayscale30,
            width: isSelectedBreed ? 6.0 : 1.0,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          selectedAnimalBreed = isSelectedBreed ? '' : optionText;
        });
      },
    );
  }

  void _showAnimalSpecies(String section, BuildContext context) async {
    List<String> filteredModalList = List.from(modalAnimalSpeciesList);
    TextEditingController searchValue = TextEditingController();

    DrowupAnimalSpecies drowupAnimalSpecies = DrowupAnimalSpecies(
      searchValue: searchValue,
      filteredModalList: filteredModalList,
      modalAnimalSpeciesList: modalAnimalSpeciesList,
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
        animalSpeciesList.remove(selectedSpeciesValue);
        animalSpeciesList.insert(0, selectedSpeciesValue);
        selectedAnimalSpecies = selectedSpeciesValue;
      });
    }
  }

  void _showAnimalBreed(String section, BuildContext context) async {
    List<String> filteredBreedList = List.from(modalAnimalBreedsList);
    TextEditingController searchValue = TextEditingController();

    DrowupAnimalBreed drowupAnimalBreed = DrowupAnimalBreed(
      searchValue: searchValue,
      filteredBreedList: filteredBreedList,
      modalAnimalBreedList: modalAnimalBreedsList,
      setState: setState,
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
        animalBreedsList.remove(selectedBreedValue);
        animalBreedsList.insert(0, selectedBreedValue);
        selectedAnimalBreed = selectedBreedValue;
      });
    }
  }
}
