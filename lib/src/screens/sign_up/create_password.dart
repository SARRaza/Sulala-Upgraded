import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import 'package:sulala_upgrade/src/screens/account_set_up/add_personal_information.dart';

import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/password_fields/password_field.dart';

class CreatePassword extends ConsumerStatefulWidget {
  const CreatePassword({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends ConsumerState<CreatePassword> {
  String errorMessage = "";
  bool isPasswordValid = false;
  bool doesPasswordMatch = false;
  PrimaryButtonStatus buttonStatus = PrimaryButtonStatus.idle;

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
              top: SizeConfig.heightMultiplier(context) * 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Password".tr,
                style: AppFonts.title2(color: AppColors.grayscale90),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier(context) * 40,
              ),
              PasswordField(
                hintText: 'Password'.tr,
                errorMessage: doesPasswordMatch
                    ? 'Passwords do not match'.tr
                    : isPasswordValid
                        ? 'Password should be at least 8 characters long and contain at least one number'
                            .tr
                        : null,
                onChanged: (value) {
                  ref.read(passwordProvider.notifier).update((state) => value);
                  setState(() {
                    // enteredPassword = value;
                    isPasswordValid = false;
                    doesPasswordMatch = false;
                  });
                },
              ),
              PasswordField(
                hintText: 'Confirm Password'.tr,
                errorMessage: doesPasswordMatch
                    ? 'Passwords do not match'.tr
                    : isPasswordValid
                        ? 'Password should be at least 8 characters long and contain at least one number'
                            .tr
                        : null,
                onChanged: (value) {
                  ref
                      .read(passwordConfirmProvider.notifier)
                      .update((state) => value);
                  setState(() {
                    // enteredConfirmPassword = value;
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
          height: SizeConfig.heightMultiplier(context) * 52,
          child: Column(
            children: [
              SizedBox(
                  height: SizeConfig.heightMultiplier(context) * 52,
                  width: SizeConfig.widthMultiplier(context) * 343,
                  child: Consumer(
                    builder: (context, ref, _) {
                      final isPasswordValid =
                          ref.watch(passwordValidationProvider);
                      return PrimaryButton(
                        text: "Confirm".tr,
                        status: isPasswordValid
                            ? PrimaryButtonStatus.idle
                            : PrimaryButtonStatus.disabled,
                        onPressed: () =>
                            isPasswordValid ? _onConfirmPressed() : null,
                      );
                    },
                  )),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  void _onConfirmPressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddPersonalInfoPage(),
        ));
  }
}
