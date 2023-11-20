// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import 'package:sulala_upgrade/src/screens/create_animal/sar_listofanimals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import 'edit_breeding_event_detail.dart';
import 'list_of_breeding_events.dart';

class BreedingEventDetails extends StatefulWidget {
  final BreedingEventVariables
      breedingEvent; // Event selected in the SecondPage
  final OviVariables OviDetails;

  const BreedingEventDetails({
    super.key,
    required this.breedingEvent,
    required this.OviDetails,
  });

  @override
  State<BreedingEventDetails> createState() => _BreedingEventDetailsState();
}

class _BreedingEventDetailsState extends State<BreedingEventDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditBreedingEventDetails(
                      breedingEvent: widget.breedingEvent,
                    ),
                  ),
                );
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
          padding:
              EdgeInsets.symmetric(horizontal: 16 * globals.widthMediaQuery),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.breedingEvent.eventNumber,
                  style: AppFonts.title3(
                    color: AppColors.grayscale90,
                  ),
                ),
                SizedBox(
                  height: 24 * globals.heightMediaQuery,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breeding ID',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    Text(
                      '001-1',
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                  ],
                ),

                SizedBox(
                  height: 6 * globals.heightMediaQuery,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sire (Father)',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    PrimaryTextButton(
                      text: '${widget.breedingEvent.sire} (ID Needed)',
                      onPressed: () {},
                      position: TextButtonPosition.right,
                      status: TextStatus.idle,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dam (Mother)',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    PrimaryTextButton(
                      text: '${widget.breedingEvent.dam} (ID Needed)',
                      onPressed: () {},
                      position: TextButtonPosition.right,
                      status: TextStatus.idle,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breeding Partner',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    PrimaryTextButton(
                      text: '${widget.breedingEvent.partner} (ID Needed)',
                      onPressed: () {},
                      position: TextButtonPosition.right,
                      status: TextStatus.idle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 6 * globals.heightMediaQuery,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breeding Date',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    widget.breedingEvent.breedingDate.isEmpty
                        ? Text(
                            'No Date Added',
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          )
                        : Text(
                            widget.breedingEvent.breedingDate,
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                  ],
                ),
                SizedBox(
                  height: 20 * globals.heightMediaQuery,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Date',
                      style: AppFonts.body2(color: AppColors.grayscale70),
                    ),
                    widget.breedingEvent.deliveryDate.isEmpty
                        ? Text(
                            'No Date Added',
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          )
                        : Text(
                            widget.breedingEvent.deliveryDate,
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                  ],
                ),
                SizedBox(
                  height: 34 * globals.heightMediaQuery,
                ),
                Text(
                  "Children",
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: 16 * globals.heightMediaQuery,
                ),
                // widget.breedingEvent.children.isEmpty
                //     ? Column(
                //         children: [
                //           SizedBox(
                //             height: 8 * globals.heightMediaQuery,
                //           ),
                //           Center(
                //               child: Image.asset(
                //                   'assets/illustrations/cow_childx.png')),
                //         ],
                //       )
                //     :
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.breedingEvent.children.length,
                  itemBuilder: (context, index) {
                    final child = widget.breedingEvent.children[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[100],
                          backgroundImage: FileImage(child.selectedOviImage)

                          // child: child.selectedOviImage == null
                          //     ? const Icon(
                          //         Icons.camera_alt_outlined,
                          //         size: 50,
                          //         color: Colors.grey,
                          //       )
                          //     : null,
                          ),
                      title: Text(
                        child.animalName,
                        style: AppFonts.headline3(color: AppColors.grayscale90),
                      ),
                      subtitle: Text(
                        child.selectedOviGender,
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                      trailing: Text(
                        'ID#131340',
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                    );
                  },
                ),

                SizedBox(
                  height: 24 * globals.heightMediaQuery,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Notes",
                      style: AppFonts.title5(color: AppColors.grayscale90),
                    ),
                    InkWell(
                        onTap: () {},
                        child:
                            Image.asset('assets/icons/frame/24px/24_Edit.png'))
                  ],
                ),
                SizedBox(
                  height: 16 * globals.heightMediaQuery,
                ),
                Text(
                  'Max had twins in this breeding event',
                  // (widget.breedingEvent.notes),
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
