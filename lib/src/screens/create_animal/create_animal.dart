import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../breeding/list_of_breeding_events.dart';
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
    'Monkey',
    'Bear',
  ];

  List<String> oviparousSpeciesList = [
    'Duck',
    'Chicken',
    'Turtle',
    'Snake',
    'Frog',
    'Fish',
  ];

  Map<String, List<String>> speciesToBreedsMap = {
    'Dog': ['Labrador', 'German Shepherd', 'Golden Retriever'],
    'Cat': ['Siamese', 'Persian', 'Maine Coon'],
    'Elephant': ['African Elephant', 'Asian Elephant'],
    'Lion': ['African Lion', 'Asiatic Lion'],
    'Monkey': ['Chimpanzee', 'Gorilla', 'Orangutan'],
    'Bear': ['Grizzly Bear', 'Polar Bear', 'Black Bear'],
    'Duck': ['Mallard', 'Pekin', 'Khaki Campbell'],
    'Chicken': ['Rhode Island Red', 'Leghorn', 'Plymouth Rock'],
    'Turtle': ['Red-eared Slider', 'Snapping Turtle', 'Painted Turtle'],
    'Snake': ['Python', 'Cobra', 'Anaconda'],
    'Frog': ['Bullfrog', 'Tree Frog', 'Poison Dart Frog'],
    'Fish': ['Goldfish', 'Guppy', 'Betta'],
    'Tiger': ['Bengal Tiger', 'Siberian Tiger', 'Indochinese Tiger'],
    'Giraffe': ['Masai Giraffe', 'Reticulated Giraffe'],
    'Kangaroo': ['Red Kangaroo', 'Eastern Grey Kangaroo'],
    'Horse': ['Thoroughbred', 'Quarter Horse', 'Arabian Horse'],
    'Zebra': ['Plains Zebra', 'Grevy\'s Zebra'],
    'Panda': ['Giant Panda', 'Red Panda'],
    'Hippopotamus': ['Common Hippopotamus', 'Pygmy Hippopotamus'],
    'Gorilla': ['Western Gorilla', 'Eastern Gorilla'],
    'Cheetah': ['African Cheetah', 'Asian Cheetah'],
    'Raccoon': ['Common Raccoon', 'Procyon lotor'],
    'Squirrel': ['Eastern Gray Squirrel', 'Red Squirrel'],
    'Koala': ['Queensland Koala', 'New South Wales Koala'],
    'Penguin': ['Emperor Penguin', 'Adelie Penguin', 'King Penguin'],
    'Crocodile': ['Nile Crocodile', 'Saltwater Crocodile', 'Gharial'],
    'Eagle': ['Bald Eagle', 'Golden Eagle', 'Harpy Eagle'],
    'Alligator': ['American Alligator', 'Chinese Alligator'],
    'Salmon': ['Atlantic Salmon', 'Chinook Salmon', 'Coho Salmon'],
    'Gecko': ['Leopard Gecko', 'Crested Gecko', 'Tokay Gecko'],
    'Chameleon': [
      'Veiled Chameleon',
      'Panther Chameleon',
      'Jackson\'s Chameleon'
    ],
    'Toad': ['Common Toad', 'American Toad', 'Cane Toad'],
    'Iguana': ['Green Iguana', 'Rhino Iguana', 'Blue Iguana'],
    'Parrot': ['African Grey Parrot', 'Cockatiel', 'Macaw'],
    'Lizard': ['Bearded Dragon', 'Anole Lizard', 'Skink'],
    'Salamander': ['Fire Salamander', 'Tiger Salamander', 'Axolotl'],
    'Tortoise': ['Aldabra Tortoise', 'Russian Tortoise', 'Galapagos Tortoise'],
  };

  List<String> modalMammalSpeciesList = [
    'Tiger',
    'Giraffe',
    'Kangaroo',
    'Horse',
    'Zebra',
    'Panda',
    'Hippopotamus',
    'Gorilla',
    'Cheetah',
    'Raccoon',
    'Squirrel',
    'Koala',
    'Penguin'
  ];
  List<String> modalOviSpeciesList = [
    'Crocodile',
    'Eagle',
    'Penguin',
    'Alligator',
    'Salmon',
    'Gecko',
    'Chameleon',
    'Toad',
    'Iguana',
    'Parrot',
    'Lizard',
    'Salamander',
    'Tortoise'
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
                      text: 'Show More',
                    ),
                  ],
                ),
              if (showAnimalBreedsSection)
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
