import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';

import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_text_button.dart';
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
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _farmNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  String? savedPhoneNumber;
  String? savedEmail;
  bool emailHasError = false;
  bool phoneHasError = false;
  PrimaryButtonStatus buttonStatus = PrimaryButtonStatus.idle;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with widget values
    _farmNameController.text = ref.read(whatIsTheNameOfYourFarmProvider);
    _ownerNameController.text = ref.read(whoOwnTheFarmProvider);
    _phoneController.text = ref.read(phoneNumberProvider);
    _emailController.text = ref.read(emailAddressProvider);
  }

  String? _isValidEmail(String? email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return email == null || email.isEmpty || emailRegExp.hasMatch(email) ? null
        : 'Invalid email address'.tr;
  }

  String? _isValidPhoneNumber(String? phoneNumber) {
    final phoneRegExp = RegExp(r'^[0-9]+$');
    return phoneNumber == null || phoneNumber.isEmpty || phoneRegExp.hasMatch(
        phoneNumber) ? null : "Phone numbers can't have text".tr;
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
              padding: EdgeInsets.all(SizeConfig.widthMultiplier(context) * 6),
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
                text: 'Skip For Now'.tr,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddSomeDetailsPage()),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.widthMultiplier(context) * 16,
              right: SizeConfig.widthMultiplier(context) * 16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Personal Information'.tr,
                    style: AppFonts.title3(color: AppColors.grayscale90),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 40),
                  Text("What's your name?".tr,
                      style: AppFonts.headline3(color: AppColors.grayscale90)),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
                  PrimaryTextField(
                    controller: _nameController,
                    hintText: "Enter First Name".tr,
                    onChanged: (value) {
                      ref
                          .read(firstNameProvider.notifier)
                          .update((state) => value);
                    },
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
                  PrimaryTextField(
                    controller: _lastNameController,
                    hintText: "Enter Last Name".tr,
                    onChanged: (value) {
                      ref
                          .read(lastNameProvider.notifier)
                          .update((state) => value);
                    },
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 40),
                  Text('What Is The Name Of Your Farm?'.tr,
                      style: AppFonts.headline3(color: AppColors.grayscale90)),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
                  PrimaryTextField(
                    controller: _farmNameController,
                    hintText: 'Farm Name'.tr,
                    onChanged: (value) {
                      ref
                          .read(whatIsTheNameOfYourFarmProvider.notifier)
                          .update((state) => value);
                    },
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 40),
                  Text("Who owns the farm?".tr,
                      style: AppFonts.headline3(color: AppColors.grayscale90)),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
                  PrimaryTextField(
                    controller: _ownerNameController,
                    hintText: "Owner name".tr,
                    onChanged: (value) {
                      ref
                          .read(whoOwnTheFarmProvider.notifier)
                          .update((state) => value);
                    },
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 40),
                  Text('Contacts'.tr,
                      style: AppFonts.headline3(color: AppColors.grayscale90)),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 8),
                  Text(
                      'Add contact details to help other people contact you for collaboration'
                          .tr,
                      style: AppFonts.body2(color: AppColors.grayscale70)),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
                  PhoneNumberField(
                    controller: _phoneController,
                    validator: _isValidPhoneNumber,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 20),
                  const SizedBox(height: 8),
                  PrimaryTextField(
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Enter Email'.tr,
                    controller: _emailController,
                    validator: _isValidEmail,
                    onChanged: (value) {
                      ref
                          .read(emailAddressProvider.notifier)
                          .update((state) => value);
                    },
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 40),
                  SizedBox(
                    width: double.infinity,
                    height: SizeConfig.heightMultiplier(context) * 52,
                    child: PrimaryButton(
                      status: buttonStatus,
                      text: 'Continue'.tr,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          buttonStatus = PrimaryButtonStatus.loading;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddSomeDetailsPage()),
                          ).then((value) {
                            setState(() {
                              buttonStatus = PrimaryButtonStatus.idle;
                            });
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier(context) * 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
