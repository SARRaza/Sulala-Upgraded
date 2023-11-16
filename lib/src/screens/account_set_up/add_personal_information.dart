import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import 'package:sulala_app/src/theme/fonts/fonts.dart';
import 'package:sulala_app/src/widgets/controls_and_buttons/buttons/primary_button.dart';
import 'package:sulala_app/src/widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import 'package:sulala_app/src/widgets/inputs/phone_number_field.dart/phone_number_field.dart';
import 'package:sulala_app/src/widgets/inputs/text_fields/primary_text_field.dart';
import 'package:sulala_app/src/screens/account_set_up/add_some_details.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;

class AddPersonalInfoPage extends StatefulWidget {
  const AddPersonalInfoPage({super.key});

  @override
  State<AddPersonalInfoPage> createState() => _AddPersonalInfoPageState();
}

class _AddPersonalInfoPageState extends State<AddPersonalInfoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController farmNameController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? firstName;
  String? lastName;
  String? farmName;
  String? ownerName;
  String? savedPhoneNumber;
  String? savedEmail;
  bool emailHasError = false;

  PrimaryButtonStatus buttonStatus = PrimaryButtonStatus.idle;

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
                    setState(() {
                      firstName = value;
                    });
                  },
                ),
                SizedBox(height: globals.heightMediaQuery * 16),
                PrimaryTextField(
                  controller: lastNameController,
                  hintText: "Enter Last Name",
                  onChanged: (value) {
                    setState(() {
                      lastName = value;
                    });
                  },
                ),
                SizedBox(height: globals.heightMediaQuery * 40),
                Text("What is the name of your farm?",
                    style: AppFonts.headline3(color: AppColors.grayscale90)),
                SizedBox(height: globals.heightMediaQuery * 24),
                PrimaryTextField(
                  controller: farmNameController,
                  hintText: "Farm Name",
                  onChanged: (value) {
                    setState(() {
                      farmName = value;
                    });
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
                    setState(() {
                      ownerName = value;
                    });
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
                PhoneNumberField(
                  label: 'Phone Number',
                  onSave: (value) => savePhoneNumber,
                ),
                SizedBox(height: globals.heightMediaQuery * 20),
                const SizedBox(height: 8),
                PrimaryTextField(
                  hintText: 'Enter Email',
                  controller: emailController,
                  errorMessage:
                      emailHasError == true ? 'Invalid email address' : null,
                  onChanged: (value) {
                    setState(() {
                      savedEmail = value;
                      emailHasError = false;
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
                      setState(
                        () {
                          if (isValidEmail(savedEmail.toString()) == true ||
                              isValidPhoneNumber(savedPhoneNumber.toString()) ==
                                  true) {
                            emailHasError = false;
                            buttonStatus = PrimaryButtonStatus.loading;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddSomeDetailsPage()),
                            );
                          } else {
                            emailHasError = true;
                            buttonStatus = PrimaryButtonStatus.disabled;
                          }
                        },
                      );
                    },
                    // onPressed: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => AddSomeDetailsPage()),
                    //   );
                    //   // Add your continue button logic here
                    // },
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
