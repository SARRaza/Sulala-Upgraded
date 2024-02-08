import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/globals.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';

import 'dart:io';

import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_text_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import '../../widgets/pages/main_widgets/navigation_bar_reg_mode.dart';

class AddSomeDetailsPage extends ConsumerStatefulWidget {
  const AddSomeDetailsPage({super.key});

  @override
  ConsumerState<AddSomeDetailsPage> createState() => _AddSomeDetailsPageState();
}

class _AddSomeDetailsPageState extends ConsumerState<AddSomeDetailsPage> {
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  void _showFilterModalSheet(BuildContext context) async {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: DrawUpWidget(
            heightFactor: 0.22,
            content: Column(
              children: [
                ListTile(
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.grayscale50,
                  ),
                  title: Text('Gallery'.tr),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedImage =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      ref
                          .read(profilePictureProvider.notifier)
                          .update((state) => File(pickedImage.path));
                      setState(() {});
                    }
                  },
                ),
                Container(
                  height: 1,
                  width: SizeConfig.widthMultiplier(context) * 343,
                  color: AppColors.grayscale20,
                ),
                ListTile(
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.grayscale50,
                  ),
                  title: Text('Camera'.tr),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedImage =
                        await _picker.pickImage(source: ImageSource.camera);
                    if (pickedImage != null) {
                      ref
                          .read(profilePictureProvider.notifier)
                          .update((state) => File(pickedImage.path));
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profilePicture = ref.watch(profilePictureProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
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
                      builder: (context) => const NavigationBarRegMode()),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.widthMultiplier(context) * 16,
                right: SizeConfig.widthMultiplier(context) * 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Some Details'.tr,
                  style: AppFonts.title3(color: AppColors.grayscale90),
                ),
                SizedBox(height: SizeConfig.heightMultiplier(context) * 40),
                Text('Add Profile Photo'.tr,
                    style: AppFonts.headline3(color: AppColors.grayscale90)),
                SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
                Center(
                  child: GestureDetector(
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.16,
                      backgroundColor: AppColors.grayscale10,
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
                SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
                Center(
                  child: PrimaryTextButton(
                    onPressed: () {
                      _showFilterModalSheet(context);
                    },
                    status: TextStatus.idle,
                    text: 'Add Photo'.tr,
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier(context) * 40),
                Text(
                  "What's your farm address?".tr,
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                SizedBox(height: SizeConfig.heightMultiplier(context) * 24),
                PrimaryTextField(
                  controller: _countryController,
                  hintText: 'Country'.tr,
                  onChanged: (value) {
                    ref.read(countryProvider.notifier).update((state) => value);
                  },
                ),
                SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
                PrimaryTextField(
                  controller: _cityController,
                  hintText: 'City'.tr,
                  onChanged: (value) {
                    ref.read(cityProvider.notifier).update((state) => value);
                  },
                ),
                SizedBox(height: SizeConfig.heightMultiplier(context) * 122),
                SizedBox(
                  width: SizeConfig.widthMultiplier(context) * 343,
                  height: SizeConfig.heightMultiplier(context) * 52,
                  child: PrimaryButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NavigationBarRegMode()),
                      );
                    },
                    text: 'Save'.tr,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
