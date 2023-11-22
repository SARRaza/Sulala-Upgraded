import 'package:flutter/material.dart';

import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/navigate_button.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/paragraph_text_fields/paragraph_text_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

import 'list_of_breeding_events.dart';
import 'search_children.dart';

class EditBreedingEventDetails extends StatefulWidget {
  final List<BreedingEventVariables> breedingEvents;

  const EditBreedingEventDetails({
    super.key,
    required this.breedingEvents,
  });

  @override
  State<EditBreedingEventDetails> createState() =>
      _EditBreedingEventDetailsState();
}

class _EditBreedingEventDetailsState extends State<EditBreedingEventDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          padding:
              EdgeInsets.symmetric(horizontal: 16 * globals.widthMediaQuery),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.breedingEvents.first.eventNumber,
                  style: AppFonts.title3(
                    color: AppColors.grayscale90,
                  ),
                ),
                SizedBox(
                  height: 24 * globals.heightMediaQuery,
                ),
                PrimaryTextField(
                  controller: TextEditingController(
                      text: widget.breedingEvents.first.eventNumber),
                  hintText: 'Edit Breeding Event',
                  labelText: 'Breeding Event',
                ),
                SizedBox(
                  height: 26 * globals.heightMediaQuery,
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
                      text: '${widget.breedingEvents.first.sire} (ID Needed)',
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
                      text: '${widget.breedingEvents.first.sire} (ID Needed)',
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
                      text: '${widget.breedingEvents.first.sire} (ID Needed)',
                      onPressed: () {},
                      position: TextButtonPosition.right,
                      status: TextStatus.idle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 6 * globals.heightMediaQuery,
                ),
                PrimaryDateField(
                  labelText: 'Breeding Date',
                  hintText: widget.breedingEvents.first.breedingDate.isNotEmpty
                      ? widget.breedingEvents.first.breedingDate
                      : "DD/MM/YYYY",
                  onChanged: (value) {
                    setState(() {
                      widget.breedingEvents.first.breedingDate;
                    });
                  },
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
                    widget.breedingEvents.first.deliveryDate.isEmpty
                        ? Text(
                            'No Date Added',
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          )
                        : Text(
                            widget.breedingEvents.first.deliveryDate,
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
                widget.breedingEvents.first.children.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 8 * globals.heightMediaQuery,
                          ),
                          Center(
                              child: Image.asset(
                                  'assets/illustrations/cow_childx.png')),
                        ],
                      )
                    : ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          // Add your onPressed functionality here
                        },
                        leading: CircleAvatar(
                          radius: 24 * globals.widthMediaQuery,
                          backgroundColor: Colors.black,
                        ),
                        title: Text(
                          'Hello',
                          // widget.breedingEvent.children,
                          style:
                              AppFonts.headline3(color: AppColors.grayscale90),
                        ),
                        subtitle: Text(
                          'Age',
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                        trailing: Text(
                          'ID#090909',
                          style: AppFonts.body2(color: AppColors.grayscale90),
                        ),
                      ),
                SizedBox(height: 16 * globals.heightMediaQuery),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const SearchChildren()),
                    );
                  },
                  child: Row(
                    children: [
                      const PrimaryTextButton(
                        status: TextStatus.idle,
                        text: 'Add Children',
                      ),
                      SizedBox(
                        width: 8 * globals.widthMediaQuery,
                      ),
                      Icon(
                        Icons.add_rounded,
                        color: AppColors.primary40,
                        size: 20 * globals.widthMediaQuery,
                      )
                    ],
                  ),
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
                ParagraphTextField(
                  hintText: 'Add Notes',
                  maxLines: 6,
                  onChanged: (value) {
                    setState(() {
                      TextEditingController(text: 'the notes');
                    });
                  },
                ),
                SizedBox(
                  height: 100 * globals.heightMediaQuery,
                ),
                SizedBox(
                  height: 52 * globals.heightMediaQuery,
                  width: 343 * globals.widthMediaQuery,
                  child: PrimaryButton(
                    text: 'Save Changes',
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 8 * globals.heightMediaQuery,
                ),
                SizedBox(
                  height: 52 * globals.heightMediaQuery,
                  width: 343 * globals.widthMediaQuery,
                  child: NavigateButton(
                    text: 'Delete Event',
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 16 * globals.heightMediaQuery,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
