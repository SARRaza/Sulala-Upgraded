import 'package:flutter/material.dart';
import '../../data/classes.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/navigate_button.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/paragraph_text_fields/paragraph_text_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import 'search_children.dart';

class EditBreedingEventDetails extends StatefulWidget {
  final List<BreedingEventVariables> breedingEvents;
  final OviVariables OviDetails;
  final BreedingDetails? breedingDetails;
  final BreedingEventVariables breedingEvent;
  const EditBreedingEventDetails(
      {super.key,
      required this.breedingEvents,
      required this.breedingEvent,
      this.breedingDetails,
      required this.OviDetails});

  @override
  State<EditBreedingEventDetails> createState() =>
      _EditBreedingEventDetailsState();
}

class _EditBreedingEventDetailsState extends State<EditBreedingEventDetails> {
  TextEditingController breedingEventNumberController = TextEditingController();
  TextEditingController breedingDateController = TextEditingController();
  TextEditingController deliveryDateController = TextEditingController();
  late final List<BreedingPartner> partner;
  @override
  void initState() {
    super.initState();
    breedingEventNumberController.text = widget.breedingEvent.eventNumber;
    if (widget.breedingDetails != null) {
      // Initialize text controller and date variables with selected vaccine details
      breedingDateController.text = widget.breedingDetails!.breedingDate;
      deliveryDateController.text = widget.breedingDetails!.breeddeliveryDate;
      breedingEventNumberController.text = widget.breedingEvent.eventNumber;
      partner = widget.breedingEvent.partner;
    }
  }

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
        ),
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16 * globals.widthMediaQuery),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  breedingEventNumberController.text,
                  style: AppFonts.title3(
                    color: AppColors.grayscale90,
                  ),
                ),
                SizedBox(
                  height: 24 * globals.heightMediaQuery,
                ),
                PrimaryTextField(
                  controller: breedingEventNumberController,
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
                  height: 26 * globals.heightMediaQuery,
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
                  height: 20 * globals.heightMediaQuery,
                ),
                Divider(),
                SizedBox(
                  height: 10 * globals.heightMediaQuery,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breeding Partner',
                      style: AppFonts.title5(color: AppColors.grayscale90),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16 * globals.heightMediaQuery,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.breedingEvent.partner.length,
                  itemBuilder: (context, index) {
                    final child = widget.breedingEvent.partner[index];
                    return ListTile(
                      onTap: () {},
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: globals.widthMediaQuery * 24,
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
                Divider(),
                SizedBox(
                  height: 6 * globals.heightMediaQuery,
                ),
                Text(
                  "Children",
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: 16 * globals.heightMediaQuery,
                ),
                widget.breedingEvent.children.isEmpty
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
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.breedingEvent.children.length,
                        itemBuilder: (context, index) {
                          final child = widget.breedingEvent.children[index];
                          return ListTile(
                            onTap: () {},
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: globals.widthMediaQuery * 24,
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
                            subtitle: Text(
                              child.selectedOviGender,
                              style:
                                  AppFonts.body2(color: AppColors.grayscale70),
                            ),
                            trailing: Text(
                              'ID#131340',
                              style:
                                  AppFonts.body2(color: AppColors.grayscale70),
                            ),
                          );
                        },
                      ),
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
                Divider(),
                SizedBox(
                  height: 24 * globals.heightMediaQuery,
                ),
                SizedBox(height: 16 * globals.heightMediaQuery),
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
