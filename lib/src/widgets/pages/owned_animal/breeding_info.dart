// ignore_for_file: dead_code, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/classes.dart';
import '../../../screens/breeding/family_tree/main.dart';
import '../../../screens/breeding/family_tree/person.dart';
import '../../../screens/breeding/list_of_breeding_events.dart';
import '../../../screens/breeding/list_of_mates.dart';

import '../../../screens/breeding/list_of_childrens.dart';
import '../../../screens/breeding/parents_page.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../other/one_information_block.dart';
import '../../other/two_information_block.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

class BreedingInfo extends ConsumerStatefulWidget {
  final OviVariables OviDetails;
  final List<BreedingEventVariables> breedingEvents;

  const BreedingInfo(
      {Key? key, required this.OviDetails, required this.breedingEvents})
      : super(key: key);

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
          if (widget.OviDetails.selectedOviGender == 'Female' &&
              widget.OviDetails.selectedAnimalType == 'Oviparous')
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
                          breedingEvents: widget.breedingEvents,
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
                        return ParentsPage(
                          selectedMammalDam: '',
                          selectedMammalSire: '',
                          selectedOviDam: '',
                          selectedOviSire: '',
                          OviDetails: widget.OviDetails,
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FamilyTreePage(
                          members: [
                            Person(
                              id: 100001,
                              name: widget.OviDetails.animalName,
                              image: widget.OviDetails.selectedOviImage != null
                                  ? FileImage(
                                      widget.OviDetails.selectedOviImage!)
                                  : null,
                              status: 'Borrowed',
                              gender: Gender.male,
                              fatherId: 100002,
                              motherId: 100004,
                            ),
                            Person(
                                id: 100002,
                                name: widget.OviDetails.selectedOviSire.first
                                    .animalName,
                                image: widget.OviDetails.selectedOviSire.first
                                            .selectedOviImage !=
                                        null
                                    ? FileImage(widget
                                        .OviDetails
                                        .selectedOviSire
                                        .first
                                        .selectedOviImage!)
                                    : null,
                                gender: Gender.male,
                                fatherId: 100003,
                                motherId: 100009,
                                status: 'Borrowed'),
                            Person(
                                id: 100003,
                                name: widget.OviDetails.selectedOviSire.first
                                    .father!.animalName,
                                gender: Gender.male,
                                image: widget.OviDetails.selectedOviSire.first
                                            .father!.selectedOviImage !=
                                        null
                                    ? FileImage(widget
                                        .OviDetails
                                        .selectedOviSire
                                        .first
                                        .father!
                                        .selectedOviImage!)
                                    : null,
                                status: 'Dead'),
                            Person(
                                id: 100011,
                                name: widget.OviDetails.selectedOviDam.first
                                    .mother!.animalName,
                                gender: Gender.female,
                                image: widget.OviDetails.selectedOviDam.first
                                            .mother!.selectedOviImage !=
                                        null
                                    ? FileImage(widget.OviDetails.selectedOviDam
                                        .first.mother!.selectedOviImage!)
                                    : null,
                                status: 'Dead'),
                            Person(
                              id: 100004,
                              name: widget
                                  .OviDetails.selectedOviDam.first.animalName,
                              image: widget.OviDetails.selectedOviDam.first
                                          .selectedOviImage !=
                                      null
                                  ? FileImage(widget.OviDetails.selectedOviDam
                                      .first.selectedOviImage!)
                                  : null,
                              gender: Gender.female,
                              status: 'Sold',
                              fatherId: 100010,
                              motherId: 100011,
                            ),
                            Person(
                                id: 100005,
                                name: 'Harry Jr.',
                                image: const AssetImage('images/harry.jpg'),
                                status: 'Borrowed',
                                gender: Gender.male,
                                fatherId: 100001),
                            Person(
                                id: 100006,
                                name: 'Harry Junior',
                                image: const AssetImage('images/harry.jpg'),
                                gender: Gender.male,
                                status: 'Borrowed',
                                fatherId: 100001),
                            Person(
                                id: 100007,
                                name: 'Tom',
                                gender: Gender.male,
                                image: const AssetImage('images/harry.jpg'),
                                status: 'Borrowed',
                                fatherId: 100001),
                            Person(
                                id: 100008,
                                name: 'Ruben',
                                gender: Gender.male,
                                image: const AssetImage('images/harry.jpg'),
                                status: 'Borrowed',
                                fatherId: 100001),
                            Person(
                                id: 100009,
                                name: widget.OviDetails.selectedOviSire.first
                                    .mother!.animalName,
                                gender: Gender.female,
                                image: widget.OviDetails.selectedOviSire.first
                                            .mother!.selectedOviImage !=
                                        null
                                    ? FileImage(widget
                                        .OviDetails
                                        .selectedOviSire
                                        .first
                                        .mother!
                                        .selectedOviImage!)
                                    : null,
                                status: 'Dead'),
                            Person(
                                id: 100010,
                                name: widget.OviDetails.selectedOviDam.first
                                    .father!.animalName,
                                gender: Gender.male,
                                image: widget.OviDetails.selectedOviDam.first
                                            .father!.selectedOviImage !=
                                        null
                                    ? FileImage(widget.OviDetails.selectedOviDam
                                        .first.father!.selectedOviImage!)
                                    : null,
                                status: 'Sold'),
                            Person(
                                id: 100013,
                                name: 'Jerry',
                                gender: Gender.male,
                                image: const AssetImage('images/harry.jpg'),
                                status: 'Borrowed',
                                fatherId: 100005),
                            Person(
                                id: 100014,
                                name: 'Carry',
                                gender: Gender.male,
                                image: const AssetImage('images/harry.jpg'),
                                status: 'Borrowed',
                                fatherId: 100005),
                            Person(
                                id: 100015,
                                name: 'Jacky',
                                gender: Gender.male,
                                image: const AssetImage('images/harry.jpg'),
                                status: 'Borrowed',
                                fatherId: 100006),
                            Person(
                                id: 100016,
                                name: 'Jessy',
                                gender: Gender.male,
                                image: const AssetImage('images/harry.jpg'),
                                status: 'Borrowed',
                                fatherId: 100006),
                            Person(
                                id: 100017,
                                name: 'Jessy',
                                gender: Gender.male,
                                image: const AssetImage('images/harry.jpg'),
                                status: 'Borrowed',
                                fatherId: 100007),
                            Person(
                                id: 100018,
                                name: 'Sweety',
                                gender: Gender.male,
                                image: const AssetImage('images/harry.jpg'),
                                status: 'Borrowed',
                                fatherId: 100007),
                            Person(
                                id: 100019,
                                name: 'Cassy',
                                gender: Gender.male,
                                image: const AssetImage('images/harry.jpg'),
                                status: 'Borrowed',
                                fatherId: 100008),
                            Person(
                                id: 100018,
                                name: 'Lewis',
                                gender: Gender.male,
                                image: const AssetImage('images/harry.jpg'),
                                status: 'Borrowed',
                                fatherId: 100008),
                          ],
                          selectedPersonId: 100001,
                        );
                      },
                    ),
                  );
                },
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
                        return ListOfBreedingMates(
                          // selectedBreedChildren: 'fff',
                          // selectedBreedDam: 'dd',
                          // selectedBreedSire: 'xx',
                          // selectedDeliveryDate: '2222',
                          // selectedBreedingDate: '321',
                          // selectedBreedPartner: 'fsdsdf',
                          // breedingEventNumberController:
                          //     TextEditingController(),
                          // breedingNotesController: TextEditingController(),
                          // shouldAddBreedEvent: false,
                          OviDetails: widget.OviDetails,
                          // breedingEvents: widget.breedingEvents,
                        );
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
                        return BreedingEventChildrenList(
                          // selectedBreedChildren: 'fff',
                          // selectedBreedDam: 'dd',
                          // selectedBreedSire: 'xx',
                          // selectedDeliveryDate: '2222',
                          // selectedBreedingDate: '321',
                          // selectedBreedPartner: 'fsdsdf',
                          // breedingEventNumberController:
                          //     TextEditingController(),
                          // breedingNotesController: TextEditingController(),
                          // shouldAddBreedEvent: false,
                          OviDetails: widget.OviDetails,
                          // breedingEvents: widget.breedingEvents,
                        );
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
