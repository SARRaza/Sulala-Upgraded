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
  PrimaryButtonStatus buttonStatus = PrimaryButtonStatus.idle;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

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
          child: Form(
            key: _formKey,
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
                  controller: _passwordController,
                  validator: (value) {
                    final password = value ?? '';
                    if(password.length < 8) {
                      return 'Password should be at least 8 characters long';
                    }
                    if (!password.contains(RegExp(r'[0-9]'))) {
                      return 'Password should contain at least one number'
                          .tr;
                    }
                    return null;
                  },
                  hintText: 'Password'.tr,
                  onChanged: (value) {
                    ref
                        .read(passwordProvider.notifier)
                        .update((state) => value);
                  },
                ),
                PasswordField(
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    if (_passwordController.text.isNotEmpty &&
                        _passwordController.text != value) {
                      return 'Passwords do not match'.tr;
                    }
                    return null;
                  },
                  hintText: 'Confirm Password'.tr,
                  onChanged: (value) {
                    ref
                        .read(passwordConfirmProvider.notifier)
                        .update((state) => value);
                  },
                ),
              ],
            ),
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
                      return PrimaryButton(
                        text: "Confirm".tr,
                        status: buttonStatus,
                        onPressed: () => _formKey.currentState!.validate()
                            ? _onConfirmPressed()
                            : null,
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
