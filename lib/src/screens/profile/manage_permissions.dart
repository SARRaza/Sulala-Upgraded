import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import '../../data/classes/staff_member.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/tags/tags.dart';
import '../../widgets/controls_and_buttons/toggles/toggle_active.dart';

typedef PermissionsCallback = void Function({
  bool isViewOnlySelected,
  bool isCanEditSelected,
  bool isWorkerSelected,
  bool isGeneralInfoSelected,
  bool isBreedingInfoSelected,
  bool isMedicalInfoSelected,
});

class ManagePermissions extends ConsumerStatefulWidget {
  final String staffMemberId;
  final PermissionsCallback onPermissionsChanged;
  const ManagePermissions({
    super.key,
    required this.staffMemberId,
    required this.onPermissionsChanged,
  });

  @override
  ConsumerState<ManagePermissions> createState() => _ManagePermissionsState();
}

class _ManagePermissionsState extends ConsumerState<ManagePermissions> {
  bool isHelperSelected = false;
  bool isWorkerSelected = false;
  bool isViewOnlySelected = false;
  bool isCanEditSelected = false;
  bool showList = false;
  bool isGeneralInfoSelected = false;
  bool isBreedingInfoSelected = false;
  bool isMedicalInfoSelected = false;

  @override
  void initState() {
    final staff = ref
        .read(staffProvider)
        .firstWhere((member) => member.id == widget.staffMemberId);
    switch (staff.role) {
      case 'Viewer':
        isViewOnlySelected = true;
        break;
      case 'Helper':
        isCanEditSelected = true;
        break;
      case 'Worker':
        isWorkerSelected = true;
        break;
    }
    super.initState();
  }

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
                left: 16 * SizeConfig.widthMultiplier(context),
                right: 16 * SizeConfig.widthMultiplier(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manage Permissions'.tr,
                  style: AppFonts.title3(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: 32 * SizeConfig.heightMultiplier(context),
                ),
                Text(
                  'Role'.tr,
                  style: AppFonts.headline3(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: 8 * SizeConfig.heightMultiplier(context),
                ),
                Text(
                  'When the staff member is given permission to edit, they can add/edit data'
                      .tr,
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
                SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Tags(
                      text: 'Viewer'.tr,
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
                      text: 'Helper'.tr,
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
                      text: 'Worker'.tr,
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
                  SizedBox(height: 32 * SizeConfig.heightMultiplier(context)),
                  Text(
                    'What Info Can This Member Edit?'.tr,
                    style: AppFonts.headline3(color: AppColors.grayscale90),
                  ),
                  SizedBox(
                    height: 16 * SizeConfig.heightMultiplier(context),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'General Information'.tr,
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
                          'Breeding Info'.tr,
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
                          'Medical Info'.tr,
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
            width: 343 * SizeConfig.widthMultiplier(context),
            height: 52 * SizeConfig.heightMultiplier(context),
            child: PrimaryButton(
              onPressed: () {
                ref.read(staffProvider.notifier).update((state) {
                  final newState = List<StaffMember>.from(state);
                  final staffIndex = state.indexWhere(
                      (member) => member.id == widget.staffMemberId);
                  newState[staffIndex] = state[staffIndex].copyWith(
                      role: isViewOnlySelected
                          ? 'Viewer'
                          : isCanEditSelected
                              ? 'Helper'
                              : 'Worker');
                  return newState;
                });
                Navigator.pop(context);
              },
              text: 'Save Changes'.tr,
            ),
          )),
    );
  }
}
