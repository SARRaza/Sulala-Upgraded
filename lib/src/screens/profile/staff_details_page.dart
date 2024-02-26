import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/providers/user_providers.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/navigate_button.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/buttons/secondary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/lists/table_list/table_clickable_link.dart';
import '../../widgets/other/custom_snack_bar.dart';
import 'manage_permissions.dart';

class StaffDetailsPage extends ConsumerStatefulWidget {
  final int staffMemberId;

  const StaffDetailsPage(
      {super.key,
      required this.staffMemberId});

  @override
  ConsumerState<StaffDetailsPage> createState() => _StaffDetailsPageState();
}

class _StaffDetailsPageState extends ConsumerState<StaffDetailsPage> {
  bool isViewOnlySelected = true;
  bool isCanEditSelected = false;
  bool isWorkerSelected = false;
  bool isGeneralInfoSelected = false;
  bool isBreedingInfoSelected = false;
  bool isMedicalInfoSelected = false;

  void _updatePermissions({
    bool? isViewOnlySelected,
    bool? isCanEditSelected,
    bool? isWorkerSelected,
    bool? isGeneralInfoSelected,
    bool? isBreedingInfoSelected,
    bool? isMedicalInfoSelected,
  }) {
    setState(() {
      this.isViewOnlySelected = isViewOnlySelected ?? this.isViewOnlySelected;
      this.isCanEditSelected = isCanEditSelected ?? this.isCanEditSelected;
      this.isWorkerSelected = isWorkerSelected ?? this.isWorkerSelected;
      this.isGeneralInfoSelected =
          isGeneralInfoSelected ?? this.isGeneralInfoSelected;
      this.isBreedingInfoSelected =
          isBreedingInfoSelected ?? this.isBreedingInfoSelected;
      this.isMedicalInfoSelected =
          isMedicalInfoSelected ?? this.isMedicalInfoSelected;
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: ref.watch(staffMemberProvider(widget.staffMemberId)).when(
        error: (error, trace) => Scaffold(body: Text('Error: $error')),
        loading: () => const Scaffold(body: Center(
          child: CircularProgressIndicator(),),),
        data: (staffMember) {
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0.0,
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                'Member Of Your Staff'.tr,
                style: AppFonts.headline3(color: AppColors.grayscale90),
              ),
              leading: IconButton(
                padding: EdgeInsets.zero,
                icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.grayscale10,
                    ),
                    child:
                        const Icon(Icons.arrow_back, color: AppColors.grayscale90)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                      right: 6.0 * SizeConfig.widthMultiplier(context)),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grayscale10,
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: AppColors.error100,
                      ),
                    ),
                    onPressed: () {
                      _confirmDeletion(staffMember).then((confirmed) {
                        if(confirmed) {
                          ref.read(staffProvider.notifier)
                              .removeMember(widget.staffMemberId);
                          CustomSnackBar.show(
                            context,
                            'Member was Deleted'.tr,
                            Icons.check_circle_rounded,
                            24 * SizeConfig.heightMultiplier(context),
                            color: AppColors.primary10,
                          );
                          Navigator.pop(context);


                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    right: 16.0 * SizeConfig.widthMultiplier(context),
                    left: 16.0 * SizeConfig.widthMultiplier(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 44 * SizeConfig.heightMultiplier(context)),
                    Center(
                      child: CircleAvatar(
                        radius: 60 * SizeConfig.widthMultiplier(context),
                        backgroundImage: staffMember.image,
                      ),
                    ),
                    SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                    Center(
                      child: Text(
                        staffMember.name,
                        style: AppFonts.title4(color: AppColors.grayscale90),
                      ),
                    ),
                    Center(
                      child: Text(
                        staffMember.email,
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                    ),
                    SizedBox(
                      height: 32 * SizeConfig.heightMultiplier(context),
                    ),
                    Text(
                      'Member Permissions'.tr,
                      style: AppFonts.title5(color: AppColors.grayscale90),
                    ),
                    SizedBox(
                      height: 14 * SizeConfig.heightMultiplier(context),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Access level'.tr,
                            style: AppFonts.body2(color: AppColors.grayscale70),
                          ),
                          Text(
                            staffMember.role,
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32 * SizeConfig.heightMultiplier(context),
                    ),
                    Text(
                      'Contact Details'.tr,
                      style: AppFonts.title5(color: AppColors.grayscale90),
                    ),
                    SizedBox(
                      height: 14 * SizeConfig.heightMultiplier(context),
                    ),
                    TableClickableText(
                      iconPath: 'assets/icons/frame/24px/Outlined_Phone.png',
                      text1: 'Phone Number'.tr,
                      url: "tel:${staffMember.phoneNumber}",
                      urlText: staffMember.phoneNumber,
                    ),
                    SizedBox(
                      height: 20 * SizeConfig.heightMultiplier(context),
                    ),
                    TableClickableText(
                      iconPath: 'assets/icons/frame/24px/16_Mail.png',
                      text1: 'Email Address'.tr,
                      url: "mailto:${staffMember.email}",
                      urlText: staffMember.email,
                    ),
                    SizedBox(
                      height: 35 * SizeConfig.heightMultiplier(context),
                    ),
                    Text(
                      'Address'.tr,
                      style: AppFonts.title5(color: AppColors.grayscale90),
                    ),
                    SizedBox(
                      height: 14 * SizeConfig.heightMultiplier(context),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Address'.tr,
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                      trailing: Text(
                        staffMember.address,
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: SizedBox(
              width: 343 * SizeConfig.widthMultiplier(context),
              height: 52 * SizeConfig.heightMultiplier(context),
              child: PrimaryButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManagePermissions(
                          staffMemberId: widget.staffMemberId,
                          onPermissionsChanged: _updatePermissions,
                        ),
                      ),
                    );
                  },
                  text: 'Manage Permissions'.tr),
            ),
          );
        }
      ),
    );
  }

  Future<bool> _confirmDeletion(staffMember) async {
    return await showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return DrawUpWidget(
          heightFactor: 0.4,
          heading: 'Delete Member?'.tr,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Delete '.tr,
                      style: AppFonts.body2(
                          color: AppColors.grayscale90),
                    ),
                    TextSpan(
                      text: staffMember.name,
                      style: AppFonts.body1(
                          color: AppColors.primary30),
                    ),
                    TextSpan(
                      text:
                      ' from your staffs?\nThis action cannot be undone'
                          .tr,
                      style: AppFonts.body2(
                          color: AppColors.grayscale90),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32 * SizeConfig.heightMultiplier(context),
              ),
              SizedBox(
                width: double.infinity,
                height: 52 * SizeConfig.heightMultiplier(context),
                child: NavigateButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  text: 'Delete'.tr,
                ),
              ),
              SizedBox(
                height: 8 * SizeConfig.heightMultiplier(context),
              ),
              SizedBox(
                width: double.infinity,
                height: 52 * SizeConfig.heightMultiplier(context),
                child: SecondaryButton(
                  onPressed: () => Navigator.pop(context, false),
                  text: 'Cancel'.tr,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
