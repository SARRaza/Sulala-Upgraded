import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/apple_button.dart';
import '../../widgets/controls_and_buttons/buttons/google_button.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_text_button.dart';
import '../../widgets/inputs/phone_number_field.dart/phone_number_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import 'otp_page.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp>
    with SingleTickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  PrimaryButtonStatus buttonStatus = PrimaryButtonStatus.idle;
  AppleButtonStatus appleButtonStatus = AppleButtonStatus.idle;
  GoogleButtonStatus googleButtonStatus = GoogleButtonStatus.idle;
  TextStatus textStatus = TextStatus.idle;
  bool showEmailField = false;
  bool emailHasError = false;

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
        builder: (context) => const OTPPage(),
      ),
    );
  }

  void _navigateToEmailOTPPage(Map<String, dynamic> option) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OTPPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumber = ref.watch(phoneNumberProvider);
    final email = ref.watch(emailAddressProvider);
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
                        SizeConfig.widthMultiplier(context) * 16,
                        0,
                        SizeConfig.widthMultiplier(context) * 16,
                        MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.heightMultiplier(context) * 41,
                          ),
                          Column(
                            children: [
                              Text(
                                "Welcome to Sulala!".tr,
                                style: AppFonts.title2(
                                  color: AppColors.grayscale90,
                                ),
                              ),
                              SizedBox(
                                height:
                                    8 * SizeConfig.heightMultiplier(context),
                              ),
                              showEmailField
                                  ? Text(
                                      "Enter your Email Address, and we will send you confirmation code"
                                          .tr,
                                      style: AppFonts.headline4(
                                        color: AppColors.grayscale90,
                                      ),
                                    )
                                  : Text(
                                      "Enter your Phone Number, and we will send you confirmation code"
                                          .tr,
                                      style: AppFonts.headline4(
                                        color: AppColors.grayscale90,
                                      ),
                                    ),
                              SizedBox(
                                height:
                                    40 * SizeConfig.heightMultiplier(context),
                              ),
                              if (showEmailField)
                                PrimaryTextField(
                                  controller: _emailController,
                                  hintText: 'Enter Email'.tr,
                                  errorMessage: emailHasError == true
                                      ? 'Invalid email address'.tr
                                      : null,
                                  onChanged: (value) {
                                    ref
                                        .read(emailAddressProvider.notifier)
                                        .update((state) => value);
                                  },
                                  onErrorChanged: (hasError) {
                                    setState(() {
                                      emailHasError !=
                                          hasError; // Update the error state
                                    });
                                  },
                                )
                              else
                                const PhoneNumberField(),
                              SizedBox(
                                height:
                                    SizeConfig.heightMultiplier(context) * 24,
                              ),
                              SizedBox(
                                height:
                                    SizeConfig.heightMultiplier(context) * 52,
                                width: double.infinity,
                                child: PrimaryButton(
                                  status: buttonStatus,
                                  text: "Continue".tr,
                                  onPressed: () {
                                    setState(() {
                                      if (showEmailField == false) {
                                        if (phoneNumber.isEmpty) {
                                          PrimaryButtonStatus.idle;
                                        } else {
                                          buttonStatus =
                                              PrimaryButtonStatus.loading;
                                          _navigateToPhoneOTPPage(
                                            {},
                                          );
                                        }
                                      } else {
                                        if (_isValidEmail(email) == true) {
                                          emailHasError = false;
                                          buttonStatus =
                                              PrimaryButtonStatus.loading;
                                          _navigateToEmailOTPPage(
                                            {},
                                          );
                                        } else {
                                          emailHasError = true;
                                          buttonStatus =
                                              PrimaryButtonStatus.idle;
                                        }
                                      }
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height:
                                    SizeConfig.heightMultiplier(context) * 41,
                              ),
                              const Divider(
                                color: AppColors.grayscale20,
                                thickness: 1,
                              ),
                              SizedBox(
                                height:
                                    SizeConfig.heightMultiplier(context) * 41,
                              ),
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
                                    SizeConfig.heightMultiplier(context) * 12,
                              ),
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
                                    SizeConfig.heightMultiplier(context) * 12,
                              ),
                              PrimaryTextButton(
                                status: textStatus,
                                text: showEmailField == false
                                    ? 'Use Email Address'.tr
                                    : 'Use Phone Number'.tr,
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
}