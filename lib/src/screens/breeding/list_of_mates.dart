// import 'package:flutter/material.dart';
// import 'package:sulala_upgrade/src/data/globals.dart' as globals;
// import '../../theme/colors/colors.dart';
// import '../../theme/fonts/fonts.dart';
// import '../../widgets/controls_and_buttons/buttons/primary_button.dart';

// class ListOfMates extends StatefulWidget {
//   const ListOfMates({super.key});

//   @override
//   State<ListOfMates> createState() => _ListOfMatesState();
// }

// class _ListOfMatesState extends State<ListOfMates> {
//   final List<Map<String, dynamic>> partners = [
//     // {
//     //   'heading': 'Breeding Event 1',
//     //   'date': '02.09.2023',
//     //   'title': 'Loyce',
//     //   'subtitle': 'Male, 1 Year',
//     //   'trailing': 'ID #13542',
//     //   'avatarImage': 'assets/avatars/120px/Cat.png',
//     // },
//     // {
//     //   'heading': 'Breeding Event 2',
//     //   'date': '02.09.2023',
//     //   'title': 'Joyce',
//     //   'subtitle': 'Male, 3 Years',
//     //   'trailing': 'ID #13542',
//     //   'avatarImage': 'assets/avatars/120px/Cat.png',
//     // },
//     // {
//     //   'heading': 'Breeding Event 3',
//     //   'date': '02.09.2023',
//     //   'title': 'Angel',
//     //   'subtitle': 'Male, 3.5 Years',
//     //   'trailing': 'ID #13542',
//     //   'avatarImage': 'assets/avatars/120px/Cat.png',
//     // },
//     // Your list of partners data goes here
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         scrolledUnderElevation: 0.0,
//         centerTitle: true,
//         title: Text(
//           'Harry',
//           style: AppFonts.headline3(color: AppColors.grayscale90),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: AppColors.grayscale10,
//             ),
//             child: IconButton(
//               icon: const Icon(
//                 Icons.arrow_back,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.only(
//             left: 16 * globals.widthMediaQuery,
//             right: 16 * globals.widthMediaQuery),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'List of Mates',
//               style: AppFonts.title3(color: AppColors.grayscale90),
//             ),
//             Expanded(
//               child: partners.isEmpty
//                   ? Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             height: 151 * globals.heightMediaQuery,
//                           ),
//                           Image.asset(
//                               'assets/illustrations/cow_broke_adult.png'),
//                           SizedBox(height: 32 * globals.heightMediaQuery),
//                           Text(
//                             'No Mates Yet',
//                             style: AppFonts.headline3(
//                                 color: AppColors.grayscale90),
//                           ),
//                           SizedBox(
//                             height: 8 * globals.heightMediaQuery,
//                           ),
//                           Text(
//                             "This animal hasn’t been mated yet.",
//                             style: AppFonts.body2(color: AppColors.grayscale70),
//                           ),
//                           SizedBox(
//                             height: 125 * globals.heightMediaQuery,
//                           ),
//                           SizedBox(
//                             width: 130 * globals.widthMediaQuery,
//                             height: 52 * globals.heightMediaQuery,
//                             child: PrimaryButton(
//                               text: 'Add Mate',
//                               onPressed: () {
//                                 // Implement the logic to add children here
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: partners.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         final partner = partners[index];
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   partner['heading'],
//                                   style: AppFonts.caption1(
//                                       color: AppColors.grayscale80),
//                                 ),
//                                 Text(
//                                   partner['date'],
//                                   style: AppFonts.caption2(
//                                       color: AppColors.grayscale80),
//                                 ),
//                               ],
//                             ),
//                             ListTile(
//                               contentPadding: EdgeInsets.only(
//                                   top: 8 * globals.heightMediaQuery,
//                                   bottom: 16 * globals.heightMediaQuery),
//                               leading: CircleAvatar(
//                                 radius: 24 * globals.widthMediaQuery,
//                                 backgroundColor: Colors.transparent,
//                                 backgroundImage:
//                                     AssetImage(partner['avatarImage']),
//                               ),
//                               title: Text(
//                                 partner['title'],
//                                 style: AppFonts.headline3(
//                                     color: AppColors.grayscale90),
//                               ),
//                               subtitle: Text(
//                                 partner['subtitle'],
//                                 style: AppFonts.body2(
//                                     color: AppColors.grayscale70),
//                               ),
//                               trailing: Text(
//                                 partner['trailing'],
//                                 style: AppFonts.body2(
//                                     color: AppColors.grayscale70),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../../data/classes.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../create_animal/owned_animal_detail_reg_mode.dart';
import 'breeding_event_detail.dart';

class ListOfBreedingMates extends ConsumerStatefulWidget {
  final OviVariables OviDetails;

  const ListOfBreedingMates({
    super.key,
    required this.OviDetails,
  });

  @override
  ConsumerState<ListOfBreedingMates> createState() => _ListOfBreedingMates();
}

class _ListOfBreedingMates extends ConsumerState<ListOfBreedingMates> {
  String filterQuery = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final animalIndex = ref.read(ovianimalsProvider).indexWhere(
        (animal) => animal.animalName == widget.OviDetails.animalName);

    if (animalIndex == -1) {
      // Animal not found, you can show an error message or handle it accordingly
      return const Center(
        child: Text('Animal not found.'),
      );
    }

    final breedingEvents = ref
            .read(ovianimalsProvider)[animalIndex]
            .breedingEvents[widget.OviDetails.animalName] ??
        [];

    // Filter the breeding events based on the query
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OwnedAnimalDetailsRegMode(
                      OviDetails: widget.OviDetails,
                      imagePath: '',
                      title: '',
                      geninfo: '',
                      breedingEvents: const [],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: 16 * globals.widthMediaQuery,
          left: 16 * globals.widthMediaQuery,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('List Of Mates',
                style: AppFonts.title3(color: AppColors.grayscale90)),
            SizedBox(
              height: 16 * globals.heightMediaQuery,
            ),
            breedingEvents.isEmpty
                ? Expanded(
                    child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 151 * globals.heightMediaQuery,
                        ),
                        Image.asset('assets/illustrations/cow_broke_adult.png'),
                        SizedBox(height: 32 * globals.heightMediaQuery),
                        Text(
                          'No Mates Yet',
                          style:
                              AppFonts.headline3(color: AppColors.grayscale90),
                        ),
                        SizedBox(
                          height: 8 * globals.heightMediaQuery,
                        ),
                        Text(
                          "This animal hasn’t been mated yet.",
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                        SizedBox(
                          height: 125 * globals.heightMediaQuery,
                        ),
                        SizedBox(
                          width: 130 * globals.widthMediaQuery,
                          height: 52 * globals.heightMediaQuery,
                          child: PrimaryButton(
                            text: 'Add Mate',
                            onPressed: () {
                              // Implement the logic to add children here
                            },
                          ),
                        ),
                      ],
                    ),
                  ))
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: breedingEvents.length,
                      itemBuilder: (context, index) {
                        final breedingEvent = breedingEvents[index];

                        return Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BreedingEventDetails(
                                      breedingEvents: breedingEvents,
                                      OviDetails: widget.OviDetails,
                                      breedingEvent: breedingEvent,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  breedingEvent.eventNumber.isEmpty
                                      ? const Text('New Event')
                                      : Text(
                                          breedingEvent.eventNumber,
                                          style: AppFonts.body2(
                                              color: AppColors.grayscale90),
                                        ),
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    color: AppColors.grayscale50,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                            if (breedingEvent.partner.isNotEmpty)
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: breedingEvent.partner.length,
                                itemBuilder: (context, index) {
                                  final child = breedingEvent.partner[index];
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      radius: 24 * globals.widthMediaQuery,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: child.selectedOviImage !=
                                              null
                                          ? FileImage(child.selectedOviImage!)
                                          : null,
                                      child: child.selectedOviImage == null
                                          ? const Icon(
                                              Icons.camera_alt_outlined,
                                              size: 50,
                                              color: Colors.grey,
                                            )
                                          : null,
                                    ),
                                    title: Text(
                                      child.animalName,
                                      style: AppFonts.headline3(
                                          color: AppColors.grayscale90),
                                    ),
                                    // ignore: unnecessary_null_comparison
                                    subtitle: child.selectedOviGender.isEmpty
                                        ? Text(
                                            'Gender Not Selected',
                                            style: AppFonts.body2(
                                                color: AppColors.grayscale70),
                                          )
                                        : Text(
                                            child.selectedOviGender,
                                            style: AppFonts.body2(
                                                color: AppColors.grayscale70),
                                          ),
                                    trailing: Text(
                                      'ID #13542',
                                      style: AppFonts.body2(
                                          color: AppColors.grayscale90),
                                    ),
                                    // Add more information about the child as needed
                                    // Example: subtitle: Text('DOB: ${child.dateOfBirth}'),
                                  );
                                },
                              ),
                            const Divider(
                              height: 25,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
