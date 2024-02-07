import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/apple_button.dart';
import '../../widgets/controls_and_buttons/buttons/google_button.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_text_button.dart';
import '../../widgets/inputs/phone_number_field.dart/phone_number_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import 'confirm_otp_page.dart';
import 'enter_password.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  PrimaryButtonStatus buttonStatus = PrimaryButtonStatus.idle;
  AppleButtonStatus appleButtonStatus = AppleButtonStatus.idle;
  GoogleButtonStatus googleButtonStatus = GoogleButtonStatus.idle;
  TextStatus textStatus = TextStatus.idle;
  bool showEmailField = false;
  bool emailHasError = false;
  String? savedEmailAddress;
  String? savedPhoneNumber;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  void _navigateToPhoneOTPPage(Map<String, dynamic> option) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmOTPPage(
          phoneNumber: savedPhoneNumber.toString(),
        ),
      ),
    );
  }

  void _navigateToEnterPasswordPage(Map<String, dynamic> option) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnterPassword(
          emailAddress: savedEmailAddress.toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: SizeConfig.widthMultiplier(context) * 375,
                child: Image.asset(
                  "assets/graphic/Animal_p.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier(context) * 185,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          SizeConfig.widthMultiplier(context) * 32,
                        ),
                        topRight: Radius.circular(
                          SizeConfig.widthMultiplier(context) * 32,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        SizeConfig.widthMultiplier(context) * 15,
                        0,
                        SizeConfig.widthMultiplier(context) * 15,
                        MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  SizeConfig.heightMultiplier(context) * 41),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Text(
                                  "Welcome to Sulala!".tr,
                                  style: AppFonts.title2(
                                    color: AppColors.grayscale90,
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        SizeConfig.heightMultiplier(context) *
                                            41),
                                if (showEmailField)
                                  _buildEmailFormField()
                                else
                                  PhoneNumberField(
                                    onSave: (value) {
                                      setState(() {
                                        savedPhoneNumber = value;
                                      });
                                    },
                                  ),
                                SizedBox(
                                    height:
                                        SizeConfig.heightMultiplier(context) *
                                            24),
                                SizedBox(
                                  height:
                                      SizeConfig.heightMultiplier(context) * 52,
                                  width: double.infinity,
                                  child: PrimaryButton(
                                      status: buttonStatus,
                                      text: "Continue".tr,
                                      onPressed: _trySubmitForm),
                                ),
                                SizedBox(
                                    height:
                                        SizeConfig.heightMultiplier(context) *
                                            41),
                                const Divider(
                                  color: AppColors.grayscale20,
                                  thickness: 1,
                                ),
                                SizedBox(
                                    height:
                                        SizeConfig.heightMultiplier(context) *
                                            41),
                                SizedBox(
                                  height:
                                      SizeConfig.heightMultiplier(context) * 52,
                                  width: double.infinity,
                                  child: AppleButton(
                                    status: appleButtonStatus,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        SizeConfig.heightMultiplier(context) *
                                            12),
                                SizedBox(
                                  height:
                                      SizeConfig.heightMultiplier(context) * 52,
                                  width: double.infinity,
                                  child: GoogleButton(
                                    status: googleButtonStatus,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        SizeConfig.heightMultiplier(context) *
                                            12),
                                PrimaryTextButton(
                                  status: textStatus,
                                  text: showEmailField == false
                                      ? 'Use email address'.tr
                                      : 'Use phone number'.tr,
                                  onPressed: () {
                                    setState(
                                      () {
                                        showEmailField =
                                            !showEmailField; // Toggle the flag
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _trySubmitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      _formKey.currentState?.save();
      // Proceed with submission logic
      buttonStatus = PrimaryButtonStatus.loading;
      if (showEmailField == false) {
        _navigateToPhoneOTPPage(
          {
            "phoneNumber": savedPhoneNumber,
            "emailAddress": null,
          },
        );
      } else {
        _navigateToEnterPasswordPage(
          {
            "emailAddress": savedEmailAddress,
            "phoneNumber": null,
          },
        );
      }
    }
    return isValid;
  }

  Widget _buildEmailFormField() {
    return PrimaryTextField(
      controller: _emailController,
      hintText: 'Enter your username'.tr,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty || !_isValidEmail(value)) {
          return 'Please enter a valid email address'.tr;
        }
        return null;
      },
    );
  }
}
