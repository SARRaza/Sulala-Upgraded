import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import '../../widgets/other/custom_snack_bar.dart';

class EditProfileInformation extends StatefulWidget {
  const EditProfileInformation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileInformation createState() => _EditProfileInformation();
}

class _EditProfileInformation extends State<EditProfileInformation> {
  String firstname = 'John';
  String secondname = 'Smith';
  String phonenum = '+12-345678';
  String city = 'New York';
  String email = 'johnsmith@example.com';
  String address = 'United Arab Emirates';
  String country = 'Abu Dhabi';

  final _firstnameController = TextEditingController();
  final _secondnameController = TextEditingController();
  final _phonenumController = TextEditingController();
  final _cityController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstnameController.text = firstname;
    _secondnameController.text = secondname;
    _phonenumController.text = phonenum;
    _cityController.text = city;
    _emailController.text = email;
    _addressController.text = address;
    _countryController.text = country;
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _secondnameController.dispose();
    _phonenumController.dispose();
    _cityController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

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
            'Edit Personal Information',
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
                GestureDetector(
                  child: Center(
                    child: CircleAvatar(
                      radius: 60 * globals.widthMediaQuery,
                      backgroundColor: AppColors.grayscale10,
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : null,
                      child: _selectedImage == null
                          ? const Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                              color: AppColors.grayscale90,
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
                    text: 'Change Photo',
                    status: TextStatus.idle,
                  ),
                ),
                SizedBox(height: 32 * globals.heightMediaQuery),
                Text(
                  "General Info",
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                SizedBox(height: 24 * globals.heightMediaQuery),
                PrimaryTextField(
                    hintText: 'Enter your first name',
                    controller: _firstnameController,
                    labelText: 'First Name'),
                SizedBox(height: 16 * globals.heightMediaQuery),
                PrimaryTextField(
                    hintText: 'Enter your first name',
                    controller: _secondnameController,
                    labelText: 'Second Name'),
                SizedBox(height: 24 * globals.heightMediaQuery),
                Text(
                  "Farm Name",
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                SizedBox(height: 24 * globals.heightMediaQuery),
                PrimaryTextField(
                  hintText: 'Enter your first name',
                  controller: _firstnameController,
                ),
                SizedBox(height: 24 * globals.heightMediaQuery),
                Text(
                  "Farm Owner",
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                SizedBox(height: 24 * globals.heightMediaQuery),
                PrimaryTextField(
                  hintText: 'Enter your first name',
                  controller: _firstnameController,
                ),
                SizedBox(height: 32 * globals.heightMediaQuery),
                Text("Contact Details",
                    style: AppFonts.headline3(color: AppColors.grayscale90)),
                SizedBox(height: 24 * globals.heightMediaQuery),
                PrimaryTextField(
                  hintText: 'Enter your first name',
                  controller: _phonenumController,
                  labelText: 'Phone Number',
                ),
                SizedBox(height: 16 * globals.heightMediaQuery),
                PrimaryTextField(
                  hintText: 'Enter your first name',
                  controller: _emailController,
                  labelText: 'Email Address',
                ),
                SizedBox(height: 32 * globals.heightMediaQuery),
                Text("Farm Address",
                    style: AppFonts.headline3(color: AppColors.grayscale90)),
                SizedBox(height: 24 * globals.heightMediaQuery),
                PrimaryTextField(
                  hintText: 'Enter Address',
                  controller: _addressController,
                ),
                SizedBox(height: 16 * globals.heightMediaQuery),
                PrimaryTextField(
                  hintText: 'Enter your first name',
                  controller: _cityController,
                ),
                SizedBox(height: 16 * globals.heightMediaQuery),
                PrimaryTextField(
                  hintText: 'Enter your first name',
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
                'Information Updated',
                Icons.check_circle_rounded,
                80 * globals.heightMediaQuery,
                color: AppColors.primary10,
              );
            },
            text: 'Save Changes',
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
                      'Camera',
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
                      _selectedImage = File(pickedImage.path);
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
                      'Gallery',
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
                      _selectedImage = File(pickedImage.path);
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
                      'Delete Photo',
                      style: AppFonts.body2(color: AppColors.error100),
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
                      _selectedImage = File(pickedImage.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
