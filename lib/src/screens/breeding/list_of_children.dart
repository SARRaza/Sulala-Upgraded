// import 'package:flutter/material.dart';
// import 'package:sulala_upgrade/src/data/globals.dart' as globals;
// import '../../theme/colors/colors.dart';
// import '../../theme/fonts/fonts.dart';
// import '../../widgets/controls_and_buttons/buttons/primary_button.dart';

// class ListOfChildren extends StatefulWidget {
//   const ListOfChildren({super.key});

//   @override
//   State<ListOfChildren> createState() => _ListOfChildrenState();
// }

// class _ListOfChildrenState extends State<ListOfChildren> {
//   final List<Map<String, dynamic>> children = [
//     {
//       'heading': 'Breeding Event 1',
//       'date': '02.09.2023',
//       'children': [
//         {
//           'title': 'Willie',
//           'subtitle': 'Male, 0.5 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Cat.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         // Add more children for Breeding Event 1 if needed
//       ],
//     },
//     {
//       'heading': 'Breeding Event 2',
//       'date': '02.09.2023',
//       'children': [
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Horse.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Cat.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         // Add more children for Breeding Event 2 if needed
//       ],
//     },
//     {
//       'heading': 'Breeding Event 3',
//       'date': '02.09.2023',
//       'children': [
//         {
//           'title': 'Shirley',
//           'subtitle': 'Male, 0.5 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Cat.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         // Add more children for Breeding Event 3 if needed
//       ],
//     },
//     {
//       'heading': 'Breeding Event 4',
//       'date': '02.09.2023',
//       'children': [
//         {
//           'title': 'Shirley',
//           'subtitle': 'Male, 0.5 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Cat.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         {
//           'title': 'Nancy',
//           'subtitle': 'Female, 1 Year',
//           'trailing': 'ID #13542',
//           'avatarImage': 'assets/avatars/120px/Dog.png',
//         },
//         // Add more children for Breeding Event 3 if needed
//       ],
//     },
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
//             right: 16 * globals.widthMediaQuery,
//             left: 16 * globals.widthMediaQuery),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'List Of Children',
//               style: AppFonts.title3(color: AppColors.grayscale90),
//             ),
//             SizedBox(
//               height: 16 * globals.heightMediaQuery,
//             ),
//             Expanded(
//               child: children.isEmpty
//                   ? Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             height: 151 * globals.heightMediaQuery,
//                           ),
//                           Image.asset('assets/illustrations/cow_childx.png'),
//                           SizedBox(height: 32 * globals.heightMediaQuery),
//                           Text(
//                             'No Children',
//                             style: AppFonts.headline3(
//                                 color: AppColors.grayscale90),
//                           ),
//                           SizedBox(
//                             height: 8 * globals.heightMediaQuery,
//                           ),
//                           Text(
//                             "This animal doesn’t have children.",
//                             style: AppFonts.body2(color: AppColors.grayscale70),
//                           ),
//                           Text(
//                             "Add a child to see it here.",
//                             style: AppFonts.body2(color: AppColors.grayscale70),
//                           ),
//                           SizedBox(
//                             height: 125 * globals.heightMediaQuery,
//                           ),
//                           SizedBox(
//                             width: 130 * globals.widthMediaQuery,
//                             height: 52 * globals.heightMediaQuery,
//                             child: PrimaryButton(
//                               text: 'Add Children',
//                               onPressed: () {
//                                 // Implement the logic to add children here
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: children.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         final breedingEvent = children[index];

//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   breedingEvent['heading'],
//                                   style: AppFonts.caption1(
//                                       color: AppColors.grayscale80),
//                                 ),
//                                 Text(
//                                   breedingEvent['date'],
//                                   style: AppFonts.caption2(
//                                       color: AppColors.grayscale80),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 8 * globals.heightMediaQuery,
//                             ),
//                             ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: breedingEvent['children'].length,
//                               itemBuilder:
//                                   (BuildContext context, int childIndex) {
//                                 final child =
//                                     breedingEvent['children'][childIndex];

//                                 return ListTile(
//                                   contentPadding: EdgeInsets.zero,
//                                   leading: CircleAvatar(
//                                     radius: 24 * globals.widthMediaQuery,
//                                     backgroundColor: Colors.transparent,
//                                     backgroundImage:
//                                         AssetImage(child['avatarImage']),
//                                   ),
//                                   title: Text(
//                                     child['title'],
//                                     style: AppFonts.headline3(
//                                         color: AppColors.grayscale90),
//                                   ),
//                                   subtitle: Text(
//                                     child['subtitle'],
//                                     style: AppFonts.body2(
//                                         color: AppColors.grayscale70),
//                                   ),
//                                   trailing: Text(
//                                     child['trailing'],
//                                     style: AppFonts.body2(
//                                         color: AppColors.grayscale90),
//                                   ),
//                                 );
//                               },
//                             ),
//                             SizedBox(
//                               height: 16 * globals.heightMediaQuery,
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
import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

import 'list_of_breeding_events.dart';
// import 'path_to_breeding_event_file.dart';

class BreedingEventChildrenLists extends StatelessWidget {
  final List<BreedingEventVariables> breedingEvents;
  final BreedingEventVariables breedingEvent;

  const BreedingEventChildrenLists(
      {Key? key, required this.breedingEvent, required this.breedingEvents})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: Text(
          'Harry',
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
            right: 16 * globals.widthMediaQuery,
            left: 16 * globals.widthMediaQuery),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'List Of Children',
              style: AppFonts.title3(color: AppColors.grayscale90),
            ),
            SizedBox(
              height: 16 * globals.heightMediaQuery,
            ),
            ListView.builder(
              itemCount: breedingEvents.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final breedingEvent = breedingEvents[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Event Number: ${breedingEvent.eventNumber}',
                          style:
                              AppFonts.caption1(color: AppColors.grayscale80),
                        ),
                        Text(
                          '09/09/2023',
                          style:
                              AppFonts.caption2(color: AppColors.grayscale80),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8 * globals.heightMediaQuery,
                    ),

                    // Display the list of children
                    // Display the list of children
                    if (breedingEvent.children.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: breedingEvent.children.length,
                        itemBuilder: (context, index) {
                          final child = breedingEvent.children[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 24 * globals.widthMediaQuery,
                              backgroundColor: Colors.transparent,
                              backgroundImage: child.selectedOviImage != null
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
                              style:
                                  AppFonts.body2(color: AppColors.grayscale90),
                            ),
                            // Add more information about the child as needed
                            // Example: subtitle: Text('DOB: ${child.dateOfBirth}'),
                          );
                        },
                      )
                    else
                      const Text(
                          'No children recorded for this breeding event.'),

                    SizedBox(
                      height: 16 * globals.heightMediaQuery,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
