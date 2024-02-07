import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
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

class _EnterPasswordState extends State<EnterPassword> {
  String? enteredPassword;
  String? enteredConfirmPassword;
  PrimaryButtonStatus buttonStatus = PrimaryButtonStatus.idle;
  final _formKey = GlobalKey<FormState>();

  void _navigateToEmailOTPPage(Map<String, dynamic> option) {
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
            left: SizeConfig.widthMultiplier(context) * 19,
            right: SizeConfig.widthMultiplier(context) * 19,
            top: SizeConfig.heightMultiplier(context) * 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Password".tr,
                style: AppFonts.title2(color: AppColors.grayscale90),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 40,
              ),
              _buildPasswordInputField(),
              _buildConfirmPasswordInputField(),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          height: SizeConfig.heightMultiplier(context) * 52,
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 52,
                width: SizeConfig.widthMultiplier(context) * 343,
                child: PrimaryButton(
                    text: "Confirm".tr,
                    status: buttonStatus,
                    onPressed: () {
                      if (_validateForm()) {
                        _navigateToEmailOTPPage(
                          {
                            "emailAddress": widget.emailAddress,
                          },
                        );
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

  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  Widget _buildPasswordInputField() {
    return PasswordField(
      hintText: 'Password'.tr,
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 8) {
          return 'Password must be at least 8 characters long'.tr;
        }
        if (!RegExp(r'[0-9]').hasMatch(value)) {
          return 'Password must contain at least one number'.tr;
        }
        return null;
      },
      onChanged: (value) => enteredPassword = value
    );
  }

  Widget _buildConfirmPasswordInputField() {
    return PasswordField(
      hintText: 'Confirm Password'.tr,
      validator: (value) {
        if (value != enteredPassword) {
          return 'Passwords do not match'.tr;
        }
        return null;
      },
    );
  }
}
