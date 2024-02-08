import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_text_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/inputs/phone_number_field.dart/phone_number_field.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import '../../widgets/other/custom_snack_bar.dart';

class EditProfileInformation extends ConsumerStatefulWidget {
  const EditProfileInformation({super.key});

  @override
  ConsumerState<EditProfileInformation> createState() =>
      _EditProfileInformation();
}

class _EditProfileInformation extends ConsumerState<EditProfileInformation> {
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneNumController = TextEditingController();
  final _cityController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _countryController = TextEditingController();
  final _farmNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  File? photo;

  @override
  void initState() {
    super.initState();
    _firstnameController.text = ref.read(firstNameProvider);
    _lastnameController.text = ref.read(lastNameProvider);
    _phoneNumController.text = ref.read(phoneNumberProvider);
    _cityController.text = ref.read(cityProvider);

    _emailController.text = ref.read(emailAddressProvider);

    _addressController.text = ref.read(farmAddressProvider);

    _countryController.text = ref.read(countryProvider);
    _farmNameController.text = ref.read(whatIsTheNameOfYourFarmProvider);
    _ownerNameController.text = ref.read(whoOwnTheFarmProvider);
    photo = ref.read(profilePictureProvider);
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneNumController.dispose();
    _cityController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  final ImagePicker _picker = ImagePicker();

  void _deleteAvatar() {
    setState(() {
      photo = null;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.all(6 * SizeConfig.widthMultiplier(context)),
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
                left: (16 * SizeConfig.widthMultiplier(context)),
                right: (16 * SizeConfig.widthMultiplier(context))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40 * SizeConfig.heightMultiplier(context),
                ),
                Center(
                  child: GestureDetector(
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.grey[100],
                      backgroundImage: photo != null ? FileImage(photo!) : null,
                      child: photo == null
                          ? const Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                Center(
                  child: PrimaryTextButton(
                    onPressed: () {
                      _showImagePicker(context);
                    },
                    text: 'Change Photo'.tr,
                    status: TextStatus.idle,
                  ),
                ),
                SizedBox(height: 32 * SizeConfig.heightMultiplier(context)),
                Text(
                  "General Info".tr,
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                PrimaryTextField(
                    hintText: 'Enter Your First Name'.tr,
                    controller: _firstnameController,
                    labelText: 'First Name'.tr),
                SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                PrimaryTextField(
                    hintText: 'Enter Your Last Name'.tr,
                    controller: _lastnameController,
                    labelText: 'Last Name'.tr),
                SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                Text(
                  "Farm Name".tr,
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                PrimaryTextField(
                  hintText: 'Enter Your Farm Name'.tr,
                  controller: _farmNameController,
                ),
                SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                Text(
                  "Farm Owner".tr,
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                PrimaryTextField(
                  hintText: 'Enter Farm Owner Name'.tr,
                  controller: _ownerNameController,
                ),
                SizedBox(height: 32 * SizeConfig.heightMultiplier(context)),
                Text("Contact Details".tr,
                    style: AppFonts.headline3(color: AppColors.grayscale90)),
                SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                const PhoneNumberField(),
                SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                PrimaryTextField(
                  hintText: 'Enter Your Email Address'.tr,
                  controller: _emailController,
                  labelText: 'Email Address'.tr,
                ),
                SizedBox(height: 32 * SizeConfig.heightMultiplier(context)),
                Text("Farm Address".tr,
                    style: AppFonts.headline3(color: AppColors.grayscale90)),
                SizedBox(height: 24 * SizeConfig.heightMultiplier(context)),
                PrimaryTextField(
                  hintText: 'Enter Address'.tr,
                  controller: _addressController,
                ),
                SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                PrimaryTextField(
                  hintText: 'Enter Your City'.tr,
                  controller: _cityController,
                ),
                SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                PrimaryTextField(
                  hintText: 'Enter Your Country'.tr,
                  controller: _countryController,
                ),
                SizedBox(height: 100 * SizeConfig.heightMultiplier(context)),
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          height: 52 * SizeConfig.heightMultiplier(context),
          width: 343 * SizeConfig.widthMultiplier(context),
          child: PrimaryButton(
            onPressed: () {
              //Save information
              ref
                  .read(profilePictureProvider.notifier)
                  .update((state) => photo);
              ref
                  .read(firstNameProvider.notifier)
                  .update((state) => _firstnameController.text);
              ref
                  .read(lastNameProvider.notifier)
                  .update((state) => _lastnameController.text);
              ref
                  .read(whatIsTheNameOfYourFarmProvider.notifier)
                  .update((state) => _farmNameController.text);
              ref
                  .read(whoOwnTheFarmProvider.notifier)
                  .update((state) => _ownerNameController.text);
              ref
                  .read(phoneNumberProvider.notifier)
                  .update((state) => _phoneNumController.text);
              ref
                  .read(emailAddressProvider.notifier)
                  .update((state) => _emailController.text);
              ref
                  .read(farmAddressProvider.notifier)
                  .update((state) => _addressController.text);
              ref
                  .read(cityProvider.notifier)
                  .update((state) => _cityController.text);
              ref
                  .read(countryProvider.notifier)
                  .update((state) => _countryController.text);
              Navigator.pop(context);

              CustomSnackBar.show(
                context,
                'Information Updated'.tr,
                Icons.check_circle_rounded,
                80 * SizeConfig.heightMultiplier(context),
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
        return DrawUpWidget(
          content: Column(
            mainAxisSize: MainAxisSize.min,
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
                    setState(() {
                      photo = File(pickedImage.path);
                    });
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
                    setState(() {
                      photo = File(pickedImage.path);
                    });
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
