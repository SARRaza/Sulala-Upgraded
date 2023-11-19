// ignore_for_file: dead_code, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../screens/breeding/list_of_breeding_events.dart';
import '../../../screens/breeding/list_of_children.dart';
import '../../../screens/breeding/list_of_mates.dart';
import '../../../screens/breeding/parents_page.dart';
import '../../../screens/create_animal/sar_listofanimals.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../other/one_information_block.dart';
import '../../other/two_information_block.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

class BreedingInfo extends ConsumerStatefulWidget {
  final OviVariables OviDetails;

  const BreedingInfo({
    Key? key,
    required this.OviDetails,
  }) : super(key: key);

  @override
  ConsumerState<BreedingInfo> createState() => _BreedingInfoState();
}

class _BreedingInfoState extends ConsumerState<BreedingInfo> {
  @override
  Widget build(BuildContext context) {
    bool animalGender = true;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.OviDetails.selectedOviGender == 'Female')
            SizedBox(
              width: globals.widthMediaQuery * 343,
              child: const OneInformationBlock(
                  head1: 'Pregnant', subtitle1: 'Current State'),
            ),
          if (animalGender)
            SizedBox(
              height: globals.heightMediaQuery * 8,
            ),
          if (widget.OviDetails.selectedOviGender == 'Female')
            SizedBox(
              width: 343 * globals.widthMediaQuery,
              child: const TwoInformationBlock(
                head1: '12.02.2023',
                head2: '12.02.2023',
                subtitle1: "Last Breeding Date",
                subtitle2: 'Next Breeding Date',
              ),
            ),
          if (widget.OviDetails.selectedOviGender == 'Male')
            SizedBox(
              width: 343 * globals.widthMediaQuery,
              child: const TwoInformationBlock(
                head1: '12.02.2023',
                head2: '12.02.2023',
                subtitle1: "Date Of Mating",
                subtitle2: 'Next Date Of Mating Date',
              ),
            ),
          if (animalGender)
            SizedBox(
              height: globals.heightMediaQuery * 24,
            ),
          Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.only(right: 0, left: 0),
                leading:
                    Image.asset('assets/icons/frame/24px/breeding_history.png'),
                title: Text(
                  'Breeding History',
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                trailing: Icon(Icons.chevron_right_rounded,
                    size: 24 * globals.widthMediaQuery),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ListOfBreedingEvents(
                          selectedBreedChildren: 'fff',
                          selectedBreedDam: 'dd',
                          selectedBreedSire: 'xx',
                          selectedDeliveryDate: '2222',
                          selectedBreedingDate: '321',
                          selectedBreedPartner: 'fsdsdf',
                          breedingEventNumberController:
                              TextEditingController(),
                          breedingNotesController: TextEditingController(),
                          shouldAddBreedEvent: false,
                          OviDetails: widget.OviDetails,
                        );
                      },
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(right: 0, left: 0),
                leading: Image.asset('assets/icons/frame/24px/parents.png'),
                title: Text(
                  'Parents',
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                trailing: Icon(Icons.chevron_right_rounded,
                    size: 24 * globals.widthMediaQuery),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const ParentsPage(
                          selectedMammalDam: '',
                          selectedMammalSire: '',
                          selectedOviDam: '',
                          selectedOviSire: '',
                        );
                      },
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(right: 0, left: 0),
                leading: Image.asset('assets/icons/frame/24px/family_tree.png'),
                title: Text(
                  'Family Tree',
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                trailing: Icon(Icons.chevron_right_rounded,
                    size: 24 * globals.widthMediaQuery),
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(right: 0, left: 0),
                leading: animalGender
                    ? Image.asset('assets/icons/frame/24px/male_mates.png')
                    : Image.asset('assets/icons/frame/24px/female_mates.png'),
                title: animalGender
                    ? Text(
                        'Male Mates',
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      )
                    : Text(
                        'Female Mates',
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      ),
                trailing: Icon(Icons.chevron_right_rounded,
                    size: 24 * globals.widthMediaQuery),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const ListOfMates();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.only(
                    right: 0, left: 0, bottom: 32 * globals.heightMediaQuery),
                leading: Image.asset('assets/icons/frame/24px/children.png'),
                title: Text(
                  'Children',
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                trailing: Icon(Icons.chevron_right_rounded,
                    size: 24 * globals.widthMediaQuery),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const ListOfChildren();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
