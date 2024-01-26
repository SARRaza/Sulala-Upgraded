import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/inputs/phone_number_field.dart/phone_number_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import '../../widgets/other/custom_snack_bar.dart';

class EditProfileInformation extends ConsumerStatefulWidget {
  const EditProfileInformation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileInformation createState() => _EditProfileInformation();
}

class _EditProfileInformation extends ConsumerState<EditProfileInformation> {
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phonenumController = TextEditingController();
  final _cityController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _countryController = TextEditingController();

  TextEditingController farmNameController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstnameController.text = ref.read(firstNameProvider);
    _lastnameController.text = ref.read(lastNameProvider);
    _phonenumController.text = ref.read(phoneNumberProvider);
    _cityController.text = ref.read(cityProvider);

    _emailController.text = ref.read(emailAdressProvider);

    _addressController.text = ref.read(countryProvider);

    _countryController.text = ref.read(countryProvider);
    farmNameController.text = ref.read(whatIsTheNameOfYourFarmProvider);
    ownerNameController.text = ref.read(whoOwnTheFarmProvider);
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phonenumController.dispose();
    _cityController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  final ImagePicker _picker = ImagePicker();
  void _deleteAvatar() {
    // Implement the logic to delete/reset the avatar
    ref.read(proflePictureProvider.notifier).update((state) => null);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final profilePicture = ref.watch(proflePictureProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Container(
              padding: EdgeInsets.all(6 * globals.widthMediaQuery),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.grayscale10,
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  color: AppColors.grayscale90),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Edit Personal Information'.tr,
            style: AppFonts.headline3(color: AppColors.grayscale90),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: (16 * globals.widthMediaQuery),
                right: (16 * globals.widthMediaQuery)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40 * globals.heightMediaQuery,
                ),
                Center(
                  child: GestureDetector(
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.grey[100],
                      backgroundImage: profilePicture != null
                          ? FileImage(profilePicture)
                          : null,
                      child: profilePicture == null
                          ? const Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 16 * globals.heightMediaQuery),
                Center(
                  child: PrimaryTextButton(
                    onPressed: () {
                      _showImagePicker(context);
                    },
                    text: 'Change Photo'.tr,
                    status: TextStatus.idle,
                  ),
                ),
                SizedBox(height: 32 * globals.heightMediaQuery),
                Text(
                  "General Info".tr,
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                SizedBox(height: 24 * globals.heightMediaQuery),
                PrimaryTextField(
                    onChanged: (value) {
                      ref
                          .read(firstNameProvider.notifier)
                          .update((state) => value);
                    },
                    hintText: 'Enter Your First Name'.tr,
                    controller: _firstnameController,
                    labelText: 'First Name'.tr),
                SizedBox(height: 16 * globals.heightMediaQuery),
                PrimaryTextField(
                    onChanged: (value) {
                      ref
                          .read(lastNameProvider.notifier)
                          .update((state) => value);
                    },
                    hintText: 'Enter Your Last Name'.tr,
                    controller: _lastnameController,
                    labelText: 'Last Name'.tr),
                SizedBox(height: 24 * globals.heightMediaQuery),
                Text(
                  "Farm Name".tr,
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                SizedBox(height: 16 * globals.heightMediaQuery),
                PrimaryTextField(
                  onChanged: (value) {
                    ref
                        .read(whatIsTheNameOfYourFarmProvider.notifier)
                        .update((state) => value);
                  },
                  hintText: 'Enter Your Farm Name'.tr,
                  controller: farmNameController,
                ),
                SizedBox(height: 24 * globals.heightMediaQuery),
                Text(
                  "Farm Owner".tr,
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                SizedBox(height: 16 * globals.heightMediaQuery),
                PrimaryTextField(
                  onChanged: (value) {
                    ref
                        .read(whoOwnTheFarmProvider.notifier)
                        .update((state) => value);
                  },
                  hintText: 'Enter Farm Owner Name'.tr,
                  controller: ownerNameController,
                ),
                SizedBox(height: 32 * globals.heightMediaQuery),
                Text("Contact Details".tr,
                    style: AppFonts.headline3(color: AppColors.grayscale90)),
                SizedBox(height: 24 * globals.heightMediaQuery),
                PhoneNumberField(controller: TextEditingController(),),
                SizedBox(height: 16 * globals.heightMediaQuery),
                PrimaryTextField(
                  onChanged: (value) {
                    ref
                        .read(emailAdressProvider.notifier)
                        .update((state) => value);
                  },
                  hintText: 'Enter Your Email Address'.tr,
                  controller: _emailController,
                  labelText: 'Email Address'.tr,
                ),
                SizedBox(height: 32 * globals.heightMediaQuery),
                Text("Farm Address".tr,
                    style: AppFonts.headline3(color: AppColors.grayscale90)),
                SizedBox(height: 24 * globals.heightMediaQuery),
                PrimaryTextField(
                  onChanged: (value) {
                    ref.read(cityProvider.notifier).update((state) => value);
                  },
                  hintText: 'Enter Address'.tr,
                  controller: _addressController,
                ),
                SizedBox(height: 16 * globals.heightMediaQuery),
                PrimaryTextField(
                  onChanged: (value) {
                    ref.read(cityProvider.notifier).update((state) => value);
                  },
                  hintText: 'Enter Your City'.tr,
                  controller: _cityController,
                ),
                SizedBox(height: 16 * globals.heightMediaQuery),
                PrimaryTextField(
                  onChanged: (value) {
                    ref.read(countryProvider.notifier).update((state) => value);
                  },
                  hintText: 'Enter Your Country'.tr,
                  controller: _countryController,
                ),
                SizedBox(height: 100 * globals.heightMediaQuery),
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          height: 52 * globals.heightMediaQuery,
          width: 343 * globals.widthMediaQuery,
          child: PrimaryButton(
            onPressed: () {
              //Save informations
              Navigator.pop(context);

              CustomSnackBar.show(
                context,
                'Information Updated'.tr,
                Icons.check_circle_rounded,
                80 * globals.heightMediaQuery,
                color: AppColors.primary10,
              );
            },
            text: 'Save Changes'.tr,
          ),
        ),
      ),
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return DrowupWidget(
          heightFactor: 0.288,
          content: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Camera'.tr,
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.grayscale50,
                      size: 30,
                    )
                  ],
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedImage =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (pickedImage != null) {
                    ref
                        .read(proflePictureProvider.notifier)
                        .update((state) => File(pickedImage.path));
                    setState(() {});
                  }
                },
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Gallery'.tr,
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.grayscale50,
                      size: 30,
                    )
                  ],
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedImage =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    ref
                        .read(proflePictureProvider.notifier)
                        .update((state) => File(pickedImage.path));
                    setState(() {});
                  }
                },
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delete Photo'.tr,
                      style: AppFonts.body2(color: AppColors.error100),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.grayscale50,
                      size: 30,
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  _deleteAvatar(); // Call a function to delete the avatar
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
