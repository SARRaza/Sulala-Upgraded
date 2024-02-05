// import 'package:flutter/material.dart';

// import 'package:sulala_upgrade/src/data/globals.dart';
// import 'package:sulala_upgrade/src/screens/create_animal/sar_listofanimals.dart';

// import '../../theme/colors/colors.dart';
// import '../../theme/fonts/fonts.dart';
// import '../../widgets/controls_and_buttons/tags/tags.dart';
// import '../../widgets/pages/owned_animal/breeding_info.dart';
// import '../../widgets/pages/owned_animal/general_info_animal_widget.dart';
// import '../breeding/list_of_breeding_events.dart';
// import '../medical/mammals_medical.dart';

// class OwnedAnimalDetails extends StatefulWidget {
//   final String imagePath;
//   final String title;
//   final String geninfo;
//   // ignore: non_constant_identifier_names
//   final OviVariables OviDetails;
//   final List<BreedingEventVariables> breedingEvents;

//   const OwnedAnimalDetails(
//       {Key? key,
//       required this.imagePath,
//       required this.title,
//       required this.geninfo,
//       // ignore: non_constant_identifier_names
//       required this.OviDetails,
//       required this.breedingEvents})
//       : super(key: key);

//   @override
//   State<OwnedAnimalDetails> createState() => _OwnedAnimalDetailsState();
// }

// class _OwnedAnimalDetailsState extends State<OwnedAnimalDetails>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           scrolledUnderElevation: 0.0,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white,
//               ),
//               child: IconButton(
//                 icon: const Icon(
//                   Icons.arrow_back,
//                   color: Colors.black,
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//           ),
//         ),
//         body: Stack(
//           children: [
//             Align(
//               alignment: Alignment.topCenter,
//               child: SizedBox(
//                 width: SizeConfig.widthMultiplier(context) * 375,
//                 child: Image.asset(
//                   "assets/graphic/Animal_p.png",
//                   fit: BoxFit.fitWidth,
//                 ),
//               ),
//             ),
//             Positioned(
//               top: SizeConfig.heightMultiplier(context) * 185,
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(
//                       SizeConfig.heightMultiplier(context) * 32,
//                     ),
//                     topRight: Radius.circular(SizeConfig.widthMultiplier(context) * 32),
//                   ),
//                 ),
//                 child: const SizedBox(), // Add your content here
//               ),
//             ),
//             Center(
//               child: FractionalTranslation(
//                 translation: Offset(0, SizeConfig.heightMultiplier(context) * 0.15),
//                 child: Expanded(
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: Colors.transparent,
//                         radius: SizeConfig.widthMultiplier(context) * 60,
//                         backgroundImage: AssetImage(widget.imagePath),
//                       ),
//                       SizedBox(
//                         height: SizeConfig.heightMultiplier(context) * 16,
//                       ),
//                       Text(
//                         widget.title,
//                         style: AppFonts.title4(color: AppColors.grayscale90),
//                       ),
//                       Text(
//                         "ID #${widget.title}",
//                         style: AppFonts.body2(color: AppColors.grayscale70),
//                       ),
//                       SizedBox(
//                         height: SizeConfig.heightMultiplier(context) * 16,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: SizeConfig.widthMultiplier(context) * 16,
//                             right: SizeConfig.widthMultiplier(context) * 16),
//                         child: Column(
//                           children: [
//                             IntrinsicWidth(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Tags(
//                                     text: 'Mammal',
//                                     icon: null,
//                                     onPress: () {
//                                       // Handle tag click
//                                     },
//                                     status: TagStatus.active,
//                                   ),
//                                   SizedBox(
//                                     width: SizeConfig.widthMultiplier(context) * 8,
//                                   ),
//                                   Tags(
//                                     text: 'Herbivore',
//                                     icon: null,
//                                     onPress: () {
//                                       // Handle tag click
//                                     },
//                                     status: TagStatus.active,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: SizeConfig.heightMultiplier(context) * 32,
//                             ),
//                             Container(
//                               height: SizeConfig.heightMultiplier(context) * 44,
//                               decoration: BoxDecoration(
//                                 color: AppColors.grayscale10,
//                                 borderRadius: BorderRadius.circular(24),
//                               ),
//                               child: TabBar(
//                                 controller: _tabController,
//                                 indicator: BoxDecoration(
//                                   color: AppColors.primary50,
//                                   borderRadius: BorderRadius.circular(24),
//                                 ),
//                                 dividerColor: Colors.transparent,
//                                 indicatorSize: TabBarIndicatorSize.tab,
//                                 indicatorColor: Colors.transparent,
//                                 labelColor: AppColors.grayscale0,
//                                 unselectedLabelColor: AppColors.grayscale60,
//                                 labelStyle:
//                                     AppFonts.body2(color: AppColors.grayscale0),
//                                 tabs: const [
//                                   Tab(text: 'General'),
//                                   Tab(text: 'Breeding'),
//                                   Tab(text: 'Medical'),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: SizeConfig.heightMultiplier(context) * 24,
//                             ),
//                             SizedBox(
//                               height: SizeConfig.heightMultiplier(context) * 325,
//                               width: SizeConfig.widthMultiplier(context) * 341,
//                               child: TabBarView(
//                                 controller: _tabController,
//                                 children: [
//                                   // Content for the 'General' tab
//                                   GeneralInfoAnimalWidget(
//                                     onDateOfBirthPressed: () {},
//                                     onDateOfDeathPressed: () {},
//                                     onDateOfMatingPressed: () {},
//                                     onDateOfSalePressed: () {},
//                                     onDateOfWeaningPressed: () {},
//                                     age: "3 years",
//                                     type: "Mammal",
//                                     sex: "Female",
//                                     OviDetails: widget.OviDetails,
//                                   ),

//                                   // Content for the 'Breeding' tab
//                                   BreedingInfo(
//                                     OviDetails: widget.OviDetails,
//                                     breedingEvents: widget.breedingEvents,
//                                   ),

//                                   // Content for the 'Medical' tab
//                                   const MammalsMedical(),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
