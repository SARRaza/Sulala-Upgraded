import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';

import 'package:sulala_upgrade/src/data/globals.dart' as globals;

import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/phone_number_field.dart/phone_number_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import 'add_some_details.dart';

class AddPersonalInfoPage extends ConsumerStatefulWidget {
  const AddPersonalInfoPage({super.key});

  @override
  ConsumerState<AddPersonalInfoPage> createState() =>
      _AddPersonalInfoPageState();
}

class _AddPersonalInfoPageState extends ConsumerState<AddPersonalInfoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController farmNameController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? savedPhoneNumber;
  String? savedEmail;
  bool emailHasError = false;

  PrimaryButtonStatus buttonStatus = PrimaryButtonStatus.idle;
  @override
  void initState() {
    super.initState();
    // Initialize text controllers with widget values
    farmNameController.text = ref.read(whatIsTheNameOfYourFarmProvider);
    ownerNameController.text = ref.read(whoOwnTheFarmProvider);
    phoneController.text = ref.read(phoneNumberProvider);
    emailController.text = ref.read(emailAdressProvider);
  }

  void saveEmailAddress(String emailAddress) {
    if (isValidEmail(emailAddress)) {
      setState(() {
        savedEmail = emailAddress;
      });
    }
  }

  void savePhoneNumber(String phoneNumber) {
    if (isValidPhoneNumber(phoneNumber)) {
      setState(() {
        savedPhoneNumber = phoneNumber;
      });
    }
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  bool isValidPhoneNumber(String phoneNumber) {
    final phoneRegExp = RegExp(r'^[0-9]+$');
    return phoneRegExp.hasMatch(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Container(
              padding: EdgeInsets.all(globals.widthMediaQuery * 6),
              decoration: BoxDecoration(
                color: AppColors.grayscale10,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              // Handle back button press
              // Add your code here
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: PrimaryTextButton(
                status: TextStatus.idle,
                text: "Skip for now",
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: globals.widthMediaQuery * 16,
              right: globals.widthMediaQuery * 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Personal Information',
                  style: AppFonts.title3(color: AppColors.grayscale90),
                ),
                SizedBox(height: globals.heightMediaQuery * 40),
                Text("What's your name?",
                    style: AppFonts.headline3(color: AppColors.grayscale90)),
                SizedBox(height: globals.heightMediaQuery * 24),
                PrimaryTextField(
                  controller: nameController,
                  hintText: "Enter First Name",
                  onChanged: (value) {
                    ref
                        .read(firstNameProvider.notifier)
                        .update((state) => value);
                  },
                ),
                SizedBox(height: globals.heightMediaQuery * 16),
                PrimaryTextField(
                  controller: lastNameController,
                  hintText: "Enter Last Name",
                  onChanged: (value) {
                    ref
                        .read(lastNameProvider.notifier)
                        .update((state) => value);
                  },
                ),
                SizedBox(height: globals.heightMediaQuery * 40),
                Text("What is the name of your farm?",
                    style: AppFonts.headline3(color: AppColors.grayscale90)),
                SizedBox(height: globals.heightMediaQuery * 24),
                PrimaryTextField(
                  controller: farmNameController,
                  hintText: 'Farm Name',
                  onChanged: (value) {
                    ref
                        .read(whatIsTheNameOfYourFarmProvider.notifier)
                        .update((state) => value);
                  },
                ),
                SizedBox(height: globals.heightMediaQuery * 40),
                Text("Who owns the farm?",
                    style: AppFonts.headline3(color: AppColors.grayscale90)),
                SizedBox(height: globals.heightMediaQuery * 24),
                PrimaryTextField(
                  controller: ownerNameController,
                  hintText: "Owner Name",
                  onChanged: (value) {
                    ref
                        .read(whoOwnTheFarmProvider.notifier)
                        .update((state) => value);
                  },
                ),
                SizedBox(height: globals.heightMediaQuery * 40),
                Text('Contacts',
                    style: AppFonts.headline3(color: AppColors.grayscale90)),
                SizedBox(height: globals.heightMediaQuery * 8),
                Text(
                    'Add contact details to help other people contact you for collaboration',
                    style: AppFonts.body2(color: AppColors.grayscale70)),
                SizedBox(height: globals.heightMediaQuery * 24),
                const PhoneNumberField(),
                SizedBox(height: globals.heightMediaQuery * 20),
                const SizedBox(height: 8),
                PrimaryTextField(
                  hintText: 'Enter Email',
                  controller: emailController,
                  // errorMessage:
                  //     emailHasError == true ? 'Invalid email address' : null,
                  onChanged: (value) {
                    setState(() {
                      ref
                          .read(emailAdressProvider.notifier)
                          .update((state) => value);

                      // emailHasError = false;
                    });
                  },
                  onErrorChanged: (hasError) {
                    setState(() {
                      emailHasError != hasError; // Update the error state
                    });
                  },
                ),
                SizedBox(height: globals.heightMediaQuery * 40),
                SizedBox(
                  width: double.infinity,
                  height: globals.heightMediaQuery * 52,
                  child: PrimaryButton(
                    status: buttonStatus,
                    text: 'Continue',
                    onPressed: () {
                      buttonStatus = PrimaryButtonStatus.loading;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddSomeDetailsPage()),
                      );
                    },
                  ),
                ),
                SizedBox(height: globals.heightMediaQuery * 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
