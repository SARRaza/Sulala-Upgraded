import 'package:flutter/material.dart';
import 'package:sulala_app/src/widgets/controls_and_buttons/buttons/primary_button.dart';
import 'package:sulala_app/src/screens/breeding/list_of_breeding_events.dart';
import 'package:sulala_app/src/screens/breeding/search_breeding_partner.dart';
import 'package:sulala_app/src/screens/breeding/search_children.dart';
import 'package:sulala_app/src/screens/breeding/search_father.dart';
import 'package:sulala_app/src/screens/breeding/search_mother.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/date_fields/primary_date_field.dart';
import '../../widgets/inputs/paragraph_text_fields/paragraph_text_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;

// ignore: depend_on_referenced_packages

class CreateBreedingEvents extends StatefulWidget {
  final String selectedAnimalType;
  final String selectedAnimalSpecies;
  final String selectedAnimalBreed;

  const CreateBreedingEvents(
      {super.key,
      required this.selectedAnimalType,
      required this.selectedAnimalSpecies,
      required this.selectedAnimalBreed});

  @override
  // ignore: library_private_types_in_public_api
  _CreateBreedingEvents createState() => _CreateBreedingEvents();
}

class _CreateBreedingEvents extends State<CreateBreedingEvents> {
  final TextEditingController _breedingnotesController =
      TextEditingController();
  final TextEditingController _breedingeventnumberController =
      TextEditingController();
  String selectedBreedSire = 'Add';
  String selectedBreedDam = 'Add';
  String selectedBreedPartner = 'Add';
  String selectedBreedChildren = '';
  String selectedBreedingDate = '';
  String selectedDeliveryDate = '';

  void setBreedingSelectedDate(String breedingdate) {
    setState(() {
      selectedBreedingDate = breedingdate;
    });
  }

  void setDeliverySelectedDate(String deliverydate) {
    setState(() {
      selectedDeliveryDate = deliverydate;
    });
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: 16.0 * globals.widthMediaQuery,
              right: 16.0 * globals.widthMediaQuery),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Event',
                style: AppFonts.title3(color: AppColors.grayscale90),
              ),
              SizedBox(height: 24 * globals.heightMediaQuery),
              PrimaryTextField(
                controller: _breedingeventnumberController,
                hintText: 'Enter Breeding Number',
                labelText: 'Breeding Number',
              ),
              SizedBox(height: 16 * globals.heightMediaQuery),
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
                height: 10 * globals.heightMediaQuery,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sire (Father)',
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  ),
                  PrimaryTextButton(
                    status: TextStatus.idle,
                    text: selectedBreedSire,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchFather(),
                          ));
                    },
                    position: TextButtonPosition.right,
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
                    status: TextStatus.idle,
                    text: selectedBreedDam,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchMother(),
                          ));

                      // _showBreedDamSelectionSheet(context);
                    },
                    position: TextButtonPosition.right,
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
                    status: TextStatus.idle,
                    text: selectedBreedPartner,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchBreedingPartner(),
                          ));
                      // _showBreedPartnerSelectionSheet(context);
                    },
                    position: TextButtonPosition.right,
                  ),
                ],
              ),
              SizedBox(height: 10 * globals.heightMediaQuery),
              PrimaryDateField(
                labelText: 'Breeding Date',
                hintText: 'DD/MM/YYYY',
                onChanged: (value) {
                  setState(() {
                    selectedBreedingDate = value.toString();
                  });
                },
              ),
              SizedBox(height: 20 * globals.heightMediaQuery),
              PrimaryDateField(
                labelText: 'Delivery Date',
                hintText: 'DD/MM/YYYY',
                onChanged: (value) {
                  setState(() {
                    selectedDeliveryDate = value.toString();
                  });
                },
              ),
              SizedBox(height: 34 * globals.heightMediaQuery),
              Text(
                "Children",
                style: AppFonts.title5(color: AppColors.grayscale90),
              ),
              SizedBox(height: 16 * globals.heightMediaQuery),
              if (selectedBreedChildren.isNotEmpty)
                Text(
                  selectedBreedChildren,
                  style: AppFonts.body1(color: AppColors.primary40),
                ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchChildren(),
                          ));
                      // _showBreedChildrenSelectionSheet(context);
                    },
                    child: Text(
                      "Add Children",
                      style: AppFonts.body1(color: AppColors.primary40),
                    ),
                  ),
                  const Icon(Icons.add, color: AppColors.primary40),
                ],
              ),
              SizedBox(height: 24 * globals.heightMediaQuery),
              Text(
                "Notes",
                style: AppFonts.title5(color: AppColors.grayscale90),
              ),
              SizedBox(height: 20 * globals.heightMediaQuery),
              ParagraphTextField(
                hintText: 'Add Notes',
                maxLines: 6,
                onChanged: (value) {
                  setState(() {
                    _breedingnotesController.text = value;
                  });
                },
              ),
              SizedBox(height: 85 * globals.heightMediaQuery),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 52 * globals.heightMediaQuery,
        width: 343 * globals.widthMediaQuery,
        child: PrimaryButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListOfBreedingEvents(
                  breedingNotesController: _breedingnotesController,
                  breedingEventNumberController: _breedingeventnumberController,
                  selectedBreedSire: selectedBreedSire,
                  selectedBreedDam: selectedBreedDam,
                  selectedBreedPartner: selectedBreedPartner,
                  selectedBreedChildren: selectedBreedChildren,
                  selectedBreedingDate: selectedBreedingDate,
                  selectedDeliveryDate: selectedDeliveryDate,
                ),
              ),
            );
          },
          text: 'Create Event',
        ),
      ),
    );
  }
}
