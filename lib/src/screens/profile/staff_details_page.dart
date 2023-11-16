import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/navigate_button.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/buttons/secondary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/lists/table_lsit/table_clickable_link.dart';
import '../../widgets/other/custom_snack_bar.dart';
import 'list_of_staff.dart';
import 'manage_permissions.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

class StaffDetailsPage extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String email;
  final String phoneNumber;

  const StaffDetailsPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.email,
    required this.phoneNumber,
  });

  @override
  State<StaffDetailsPage> createState() => _StaffDetailsPageState();
}

class _StaffDetailsPageState extends State<StaffDetailsPage> {
  bool isViewOnlySelected = true;
  bool isCanEditSelected = false;
  bool isWorkerSelected = false;
  bool isGeneralInfoSelected = false;
  bool isBreedingInfoSelected = false;
  bool isMedicalInfoSelected = false;

  void updatePermissions({
    bool? isViewOnlySelected,
    bool? isCanEditSelected,
    bool? isWorkerSelected,
    bool? isGeneralInfoSelected,
    bool? isBreedingInfoSelected,
    bool? isMedicalInfoSelected,
  }) {
    setState(() {
      this.isViewOnlySelected = isViewOnlySelected!;
      this.isCanEditSelected = isCanEditSelected!;
      this.isWorkerSelected = isWorkerSelected!;
      this.isGeneralInfoSelected = isGeneralInfoSelected!;
      this.isBreedingInfoSelected = isBreedingInfoSelected!;
      this.isMedicalInfoSelected = isMedicalInfoSelected!;
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
          title: Text(
            'Member Of Your Staff',
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
              padding: EdgeInsets.only(right: 6.0 * globals.widthMediaQuery),
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
                  showModalBottomSheet(
                    showDragHandle: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    isDismissible: true,
                    builder: (BuildContext context) {
                      return DrowupWidget(
                        heightFactor: 0.4,
                        heading: 'Delete Member?',
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Delete ',
                                    style: AppFonts.body2(
                                        color: AppColors.grayscale90),
                                  ),
                                  TextSpan(
                                    text: widget.title,
                                    style: AppFonts.body1(
                                        color: AppColors.primary30),
                                  ),
                                  TextSpan(
                                    text:
                                        ' from your staffs?\nThis action cannot be undone',
                                    style: AppFonts.body2(
                                        color: AppColors.grayscale90),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 32 * globals.heightMediaQuery,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 52 * globals.heightMediaQuery,
                              child: NavigateButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ListOfStaff(), // Replace with the appropriate StaffListPage widget
                                    ),
                                  );
                                  CustomSnackBar.show(
                                    context,
                                    'Member was Deleted',
                                    Icons.check_circle_rounded,
                                    24 * globals.heightMediaQuery,
                                    color: AppColors.primary10,
                                  );
                                },
                                text: 'Delete',
                              ),
                            ),
                            SizedBox(
                              height: 8 * globals.heightMediaQuery,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 52 * globals.heightMediaQuery,
                              child: SecondaryButton(
                                onPressed: () {},
                                text: 'Cancel',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                right: 16.0 * globals.widthMediaQuery,
                left: 16.0 * globals.widthMediaQuery),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 44 * globals.heightMediaQuery),
                Center(
                  child: CircleAvatar(
                    radius: 60 * globals.widthMediaQuery,
                    backgroundImage: AssetImage(widget.imagePath),
                  ),
                ),
                SizedBox(height: 16 * globals.heightMediaQuery),
                Center(
                  child: Text(
                    widget.title,
                    style: AppFonts.title4(color: AppColors.grayscale90),
                  ),
                ),
                Center(
                  child: Text(
                    widget.email,
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  ),
                ),
                SizedBox(
                  height: 32 * globals.heightMediaQuery,
                ),
                Text(
                  'Member Permissions',
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: 14 * globals.heightMediaQuery,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Access level',
                        style: AppFonts.body2(color: AppColors.grayscale70),
                      ),
                      Text(
                        widget.subtitle,
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32 * globals.heightMediaQuery,
                ),
                Text(
                  'Contact Details',
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: 14 * globals.heightMediaQuery,
                ),
                TableClickableText(
                  iconPath: 'assets/icons/frame/24px/Outlined_Phone.png',
                  text1: 'Phone Number',
                  url: widget.phoneNumber,
                  urlText: widget.phoneNumber,
                ),
                SizedBox(
                  height: 20 * globals.heightMediaQuery,
                ),
                TableClickableText(
                  iconPath: 'assets/icons/frame/24px/16_Mail.png',
                  text1: 'Email Address',
                  url: widget.email,
                  urlText: widget.email,
                ),
                SizedBox(
                  height: 35 * globals.heightMediaQuery,
                ),
                Text(
                  'Address',
                  style: AppFonts.title5(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: 14 * globals.heightMediaQuery,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Address',
                    style: AppFonts.body2(color: AppColors.grayscale70),
                  ),
                  trailing: Text(
                    'United Arab Emirates',
                    style: AppFonts.body2(color: AppColors.grayscale90),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: 343 * globals.widthMediaQuery,
          height: 52 * globals.heightMediaQuery,
          child: PrimaryButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManagePermissions(
                      onPermissionsChanged: updatePermissions,
                    ),
                  ),
                );
              },
              text: 'Manage Permissions'),
        ),
      ),
    );
  }
}
