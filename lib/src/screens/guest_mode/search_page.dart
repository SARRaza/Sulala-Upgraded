import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/icon_buttons/secondary_icon_button.dart';
import '../../widgets/inputs/search_bars/search_bar.dart';
import '../../widgets/lists/animal_list/animal_list_widget.dart';
import '../../widgets/lists/staff_text/staff_list_widget.dart';
import 'animal_details.dart';
import 'user_details.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> farms = [
    {
      'imagePath': 'assets/avatars/120px/Staff1.png',
      'title': 'Paul Rivera',
      'subtitle': 'Viewer',
      'email': 'paul@example.com',
      'phoneNumber': '+1 234 567 890',
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Rebecca Wilson',
      'subtitle': 'Helper',
      'email': 'paul@example.com',
      'phoneNumber': '+1 234 567 890',
    },
    {
      'imagePath': 'assets/avatars/120px/Staff1.png',
      'title': 'Patricia Williams',
      'subtitle': 'Helper',
      'email': 'paul@example.com',
      'phoneNumber': '+1 234 567 890',
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Scott Simmons',
      'subtitle': 'Worker',
      'email': 'paul@example.com',
      'phoneNumber': '+1 234 567 890',
    },
    {
      'imagePath': 'assets/avatars/120px/Staff1.png',
      'title': 'Lee Hall',
      'subtitle': 'Worker',
      'email': 'paul@example.com',
      'phoneNumber': '+1 234 567 890',
    },
    // Your data here
  ];
  List<Map<String, dynamic>> animals = [
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Horse',
      'geninfo':
          'The horse is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Cow',
      'geninfo':
          'The cow is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Ox',
      'geninfo':
          'The ox is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Sheep',
      'geninfo':
          'The sheep is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'geninfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'geninfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'geninfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'geninfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    {
      'imagePath': 'assets/avatars/120px/Staff3.png',
      'title': 'Bull',
      'geninfo':
          'The bull is a domesticated, one-toed, hoofed mammal. It belongs to the taxonomic family Equidae and is one of two extant subspecies of Equus ferus. The horse has evolved over the past 45 to 55 million years from a small multi-toed creature, close to Eohippus, into the large, single-toed animal of today. Humans began domesticating horses around 4000 BCE, and their domestication is believed to have been widespread by 3000 BC'
    },
    // Add more data here if needed
  ];

  List<Map<String, dynamic>> filteredOptions = [];
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredAnimals = [];

  @override
  void initState() {
    super.initState();
    filteredOptions = farms;
    filteredAnimals = animals;
    // Initialize filteredOptions with all options
  }

  void filterOptions(String searchText) {
    setState(() {
      filteredOptions = farms
          .where((option) =>
              option['title'].toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      filteredAnimals = animals
          .where((option) =>
              option['title'].toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void navigateToUserDetailsPage(Map<String, dynamic> option) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetails(
          imagePath: option['imagePath'],
          title: option['title'],
          subtitle: option['subtitle'],
          email: option['email'],
          phoneNumber: option['phoneNumber'],
        ),
      ),
    );
  }

  void navigateToAnimalDetailsPage(Map<String, dynamic> option) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimalDetails(
          imagePath: option['imagePath'],
          title: option['title'],
          geninfo: option['geninfo'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  globals.widthMediaQuery * 16,
                  globals.widthMediaQuery * 4,
                  globals.widthMediaQuery * 16,
                  globals.widthMediaQuery * 4,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: globals.heightMediaQuery * 40,
                        child: PrimarySearchBar(
                          onChange: filterOptions,
                          hintText: "Search Staff",
                          controller: _searchController,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: globals.widthMediaQuery * 4,
                    ),
                    SizedBox(
                      height: globals.heightMediaQuery * 40,
                      child: SecondaryIconButton(
                        status: SecondaryIconButtonStatus.idle,
                        icon: Icons.clear,
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            filterOptions('');
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: globals.heightMediaQuery * 24),
              if (filteredOptions.isNotEmpty)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    globals.widthMediaQuery * 16,
                    globals.widthMediaQuery * 4,
                    globals.widthMediaQuery * 16,
                    globals.widthMediaQuery * 4,
                  ),
                  child: Text(
                    'Farms',
                    style: AppFonts.caption1(color: AppColors.grayscale80),
                  ),
                ),
              if (filteredOptions.isNotEmpty)
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredOptions.length,
                    itemBuilder: (context, index) {
                      final option = filteredOptions[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          top: globals.widthMediaQuery * 10,
                        ),
                        child: StaffListWidget(
                          imagePath: option['imagePath'],
                          textHead: option['title'],
                          textBody: option['subtitle'],
                          avatarRadius: globals.widthMediaQuery * 24,
                          onPressed: () => navigateToUserDetailsPage(option),
                        ),
                      );
                    }),
              SizedBox(height: globals.heightMediaQuery * 24),
              if (filteredAnimals.isNotEmpty)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    globals.widthMediaQuery * 16,
                    globals.widthMediaQuery * 4,
                    globals.widthMediaQuery * 16,
                    globals.widthMediaQuery * 4,
                  ),
                  child: Text(
                    'Animals',
                    style: AppFonts.caption1(color: AppColors.grayscale80),
                  ),
                ),
              if (filteredAnimals.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          filteredAnimals.length, //change it later please
                      itemBuilder: (context, index) {
                        final option = filteredAnimals[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            top: globals.widthMediaQuery * 10,
                          ),
                          child: AnimalListWidget(
                            avatarRadius: globals.widthMediaQuery * 24,
                            imagePath: option['imagePath'],
                            textHead: option['title'],
                            textBody: option['geninfo'],
                            onPressed: () {
                              navigateToAnimalDetailsPage(option);
                            },
                          ),
                        );
                      }),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
