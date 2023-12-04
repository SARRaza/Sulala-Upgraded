// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/screens/create_animal/sar_listofanimals.dart';

import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

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
  final List<Map<String, dynamic>> parents = [
    {
      'heading': 'Breeding Event 1',
      'date': '02.09.2023',
      'title': 'Loyce',
      'subtitle': 'Male, 1 Year',
      'trailing': 'ID #13542',
      'avatarImage': 'assets/avatar1.png',
    },
    {
      'heading': 'Breeding Event 2',
      'date': '02.09.2023',
      'title': 'Joyce',
      'subtitle': 'Male, 3 Years',
      'trailing': 'ID #13542',
      'avatarImage': 'assets/avatar2.png',
    },
    {
      'heading': 'Breeding Event 3',
      'date': '02.09.2023',
      'title': 'Angel',
      'subtitle': 'Male, 3.5 Years',
      'trailing': 'ID #13542',
      'avatarImage': 'assets/avatar3.png',
    },
    // Your list of children data goes here
  ];

  @override
  Widget build(BuildContext context) {
    // final image = ref.watch(breedingChildrenDetailsProvider);
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
        actions: [
          InkWell(
            onTap: () {
              // Handle edit button tap
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.grayscale10,
                ),
                child: const Image(
                  image: AssetImage(
                      'assets/icons/frame/24px/edit_icon_button.png'),
                ),
              ),
            ),
          ),
        ],
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
            parents.isEmpty
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
                            onPressed: () {
                              // Implement the logic to add children here
                            },
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
                                id: '2222',
                                name: widget.OviDetails.selectedOviSire.first
                                    .animalName,
                                sex: 'Male',
                                age: '7 years',
                                imageFile: (widget.OviDetails.selectedOviSire
                                    .first.selectedOviImage),
                                OviDetails: widget.OviDetails,
                              ),
                            ],
                          ),
                          SizedBox(width: 55 * globals.widthMediaQuery),
                          ParentsItem(
                            id: '2222',
                            name: widget
                                .OviDetails.selectedOviDam.first.animalName,
                            sex: 'Female',
                            age: '6 years',
                            imageFile: (widget.OviDetails.selectedOviDam.first
                                .selectedOviImage),
                            OviDetails: widget.OviDetails,
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
}
