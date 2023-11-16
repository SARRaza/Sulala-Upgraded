import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/tags/tags.dart';
import '../../widgets/controls_and_buttons/toggles/toggle_active.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;

typedef PermissionsCallback = void Function({
  bool isViewOnlySelected,
  bool isCanEditSelected,
  bool isWorkerSelected,
  bool isGeneralInfoSelected,
  bool isBreedingInfoSelected,
  bool isMedicalInfoSelected,
});

class ManagePermissions extends StatefulWidget {
  final PermissionsCallback onPermissionsChanged;
  const ManagePermissions({
    super.key,
    required this.onPermissionsChanged,
  });

  @override
  State<ManagePermissions> createState() => _ManagePermissionsState();
}

class _ManagePermissionsState extends State<ManagePermissions> {
  bool isHelperSelected = false;
  bool isWorkerSelected = false;
  bool isViewOnlySelected = true;
  bool isCanEditSelected = false;
  bool showList = false;
  bool isGeneralInfoSelected = false;
  bool isBreedingInfoSelected = false;
  bool isMedicalInfoSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0.0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.grayscale10,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.grayscale90,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.only(
                left: 16 * globals.widthMediaQuery,
                right: 16 * globals.widthMediaQuery),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manage Permissions',
                  style: AppFonts.title3(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: 32 * globals.heightMediaQuery,
                ),
                Text(
                  'Role',
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: 8 * globals.heightMediaQuery,
                ),
                Text(
                  'When the staff member is given permission to edit, they can add/edit data',
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
                SizedBox(height: 16 * globals.heightMediaQuery),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Tags(
                      text: 'Viewer',
                      onPress: () {
                        setState(() {
                          isViewOnlySelected = true;
                          isCanEditSelected = false;
                          isWorkerSelected = false;
                          showList = false;
                          isGeneralInfoSelected = false;
                          isBreedingInfoSelected = false;
                          isMedicalInfoSelected = false;
                        });
                      },
                      status: isViewOnlySelected
                          ? TagStatus.active
                          : TagStatus.disabled,
                    ),
                    const SizedBox(width: 10),
                    Tags(
                      text: 'Helper',
                      onPress: () {
                        setState(() {
                          isViewOnlySelected = false;
                          isCanEditSelected = true;
                          isWorkerSelected = false;
                          showList = true;
                          isGeneralInfoSelected = false;
                          isBreedingInfoSelected = false;
                          isMedicalInfoSelected = false;
                        });
                      },
                      status: isCanEditSelected
                          ? TagStatus.active
                          : TagStatus.disabled,
                    ),
                    const SizedBox(width: 10),
                    Tags(
                      text: 'Worker',
                      onPress: () {
                        setState(() {
                          isViewOnlySelected = false;
                          isCanEditSelected = false;
                          isWorkerSelected = true;
                          showList = true;
                          isGeneralInfoSelected = false;
                          isBreedingInfoSelected = false;
                          isMedicalInfoSelected = false;
                        });
                      },
                      status: isWorkerSelected
                          ? TagStatus.active
                          : TagStatus.disabled,
                    ),
                  ],
                ),
                if (showList) ...[
                  SizedBox(height: 32 * globals.heightMediaQuery),
                  Text(
                    'What Info Can This Member Edit?',
                    style: AppFonts.headline3(color: AppColors.grayscale90),
                  ),
                  SizedBox(
                    height: 16 * globals.heightMediaQuery,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'General Informations',
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                        ToggleActive(
                          value: isGeneralInfoSelected,
                          onChanged: (value) {
                            setState(() {
                              isGeneralInfoSelected = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Breeding Info',
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                        ToggleActive(
                          value: isBreedingInfoSelected,
                          onChanged: (value) {
                            setState(() {
                              isBreedingInfoSelected = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Medical Info',
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                        ToggleActive(
                          value: isMedicalInfoSelected,
                          onChanged: (value) {
                            setState(() {
                              isMedicalInfoSelected = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          floatingActionButton: SizedBox(
            width: 343 * globals.widthMediaQuery,
            height: 52 * globals.heightMediaQuery,
            child: PrimaryButton(
              onPressed: () {
                widget.onPermissionsChanged(
                  isViewOnlySelected: isViewOnlySelected,
                  isCanEditSelected: isCanEditSelected,
                  isWorkerSelected: isWorkerSelected,
                  isGeneralInfoSelected: isGeneralInfoSelected,
                  isBreedingInfoSelected: isBreedingInfoSelected,
                  isMedicalInfoSelected: isMedicalInfoSelected,
                );

                Navigator.pop(context);
              },
              text: 'Save Changes',
            ),
          )),
    );
  }
}
