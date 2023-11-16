import 'package:flutter/material.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/password_fields/password_field.dart';
import 'confirm_otp_page.dart';

class EnterPassword extends StatefulWidget {
  final String emailAddress;
  const EnterPassword({
    Key? key,
    required this.emailAddress,
  }) : super(key: key);

  @override
  State<EnterPassword> createState() => _EnterPasswordState();
}

String? enteredPassword;
String? enteredConfirmPassword;
bool isPasswordValid = false;
bool doesPasswordMatch = false;
PrimaryButtonStatus buttonStatus = PrimaryButtonStatus.idle;

class _EnterPasswordState extends State<EnterPassword> {
  void navigateToEmailOTPPage(Map<String, dynamic> option) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmOTPPage(
          emailAddress: widget.emailAddress.toString(),
        ),
      ),
    );
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
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.grayscale90,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: globals.widthMediaQuery * 19,
            right: globals.widthMediaQuery * 19,
            top: globals.heightMediaQuery * 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Password",
                style: AppFonts.title2(color: AppColors.grayscale90),
              ),
              SizedBox(
                height: globals.heightMediaQuery * 40,
              ),
              PasswordField(
                hintText: 'Password',
                errorMessage: doesPasswordMatch
                    ? 'Passwords do not match'
                    : isPasswordValid
                        ? 'Password should be at least 8 characters long and contain at least one number'
                        : null,
                onChanged: (value) {
                  setState(() {
                    enteredPassword = value;
                    isPasswordValid = false;
                    doesPasswordMatch = false;
                  });
                },
              ),
              PasswordField(
                hintText: 'Confirm Password',
                errorMessage: doesPasswordMatch
                    ? 'Passwords do not match'
                    : isPasswordValid
                        ? 'Password should be at least 8 characters long and contain at least one number'
                        : null,
                onChanged: (value) {
                  setState(() {
                    enteredConfirmPassword = value;
                    isPasswordValid = false;
                    doesPasswordMatch = false;
                  });
                },
                onErrorChanged: (hasError) {
                  setState(() {
                    isPasswordValid = hasError; // Update the error state
                  });
                },
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          height: globals.heightMediaQuery * 52,
          child: Column(
            children: [
              SizedBox(
                height: globals.heightMediaQuery * 52,
                width: globals.widthMediaQuery * 343,
                child: PrimaryButton(
                    text: "Confirm",
                    status: buttonStatus,
                    onPressed: () {
                      if (enteredPassword != null) {
                        if (enteredPassword == enteredConfirmPassword) {
                          isPasswordValid = false;
                          // print("Passwords match");
                          if (enteredPassword!.length >= 8 &&
                              enteredPassword!.contains(RegExp(r'[0-9]'))) {
                            doesPasswordMatch = false;
                            // print("Password is valid");
                            setState(() {
                              buttonStatus = PrimaryButtonStatus.loading;
                            });
                            // Navigator.pushNamed(context, '/');
                            navigateToEmailOTPPage(
                              {
                                "emailAddress": widget.emailAddress,
                              },
                            );
                          } else {
                            setState(() {
                              isPasswordValid = true;
                            });
                          }
                        } else {
                          setState(() {
                            doesPasswordMatch = true;
                          });
                        }
                      }
                    }),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
