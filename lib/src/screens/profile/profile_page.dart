import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/navigate_button.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/buttons/secondary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/other/profile_three_information_block.dart';
import 'about_app.dart';
import 'app_setting.dart';
import 'customer_support.dart';
import 'edit_profile_information.dart';
import 'list_of_staff.dart';
import 'notifications_pause.dart';
import 'privacy_security.dart';
import 'shimmer_profile_page.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

class ProfilePage extends ConsumerStatefulWidget {
  final bool showEditIcon;
  const ProfilePage({super.key, required this.showEditIcon});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDataFromBackend();
  }

  Future<void> fetchDataFromBackend() async {
    // Simulate fetching data from the backend
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final firstName = ref.watch(firstNameProvider);
    final lastName = ref.watch(lastNameProvider);
    final profilePicture = ref.watch(proflePictureProvider);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile'.tr,
          style: AppFonts.title3(color: AppColors.grayscale90),
        ),
        actions: [
          if (widget.showEditIcon)
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileInformation(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Image(
                    image: AssetImage(
                        'assets/icons/frame/24px/edit_icon_button.png'),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 16 * globals.widthMediaQuery,
                  right: 16 * globals.widthMediaQuery),
              child: isLoading
                  ? const ShimmerProfilePage()
                  : Column(
                      children: [
                        SizedBox(height: 40 * globals.heightMediaQuery),
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.16,
                          backgroundColor: AppColors.grayscale10,
                          backgroundImage: profilePicture != null
                              ? FileImage(profilePicture)
                              : null,
                          child: profilePicture == null
                              ? CircleAvatar(
                                  radius: 60 * globals.widthMediaQuery,
                                  backgroundImage: const AssetImage(
                                      'assets/avatars/120px/Staff1.png'),
                                )
                              : null,
                        ),
                        SizedBox(
                          height: 16 * globals.heightMediaQuery,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              firstName,
                              style:
                                  AppFonts.title4(color: AppColors.grayscale90),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              lastName,
                              style:
                                  AppFonts.title4(color: AppColors.grayscale90),
                            ),
                          ],
                        ),
                        Text(
                          '123-456-7890',
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                        SizedBox(height: 16 * globals.heightMediaQuery),
                        Text(
                          'Head of Farm'.tr,
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                        SizedBox(height: 32 * globals.heightMediaQuery),
                        SizedBox(
                          height: 40 * globals.heightMediaQuery,
                          child: PrimaryButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ListOfStaff()),
                              );
                              // Add function of the button below
                            },
                            text: 'Collaboration'.tr,
                            position: PrimaryButtonPosition.right,
                          ),
                        ),
                        SizedBox(height: 24 * globals.heightMediaQuery),
                        const ProfileThreeInformationBlock(
                          head1: '24',
                          head2: '1',
                          head3: '4',
                        ),
                        SizedBox(height: 24 * globals.heightMediaQuery),
                      ],
                    ),
            ),
            Container(
              height: 12,
              color: AppColors.grayscale10,
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 16 * globals.widthMediaQuery,
                  right: 16 * globals.widthMediaQuery),
              child: Column(
                children: [
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: EdgeInsets.all(6 * globals.widthMediaQuery),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.grayscale0,
                        ),
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color: AppColors.primary30,
                        ),
                      ),
                      title: Text(
                        'Accounts'.tr,
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           const AuthorizationMethodsPage()),
                        // );
                      }),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: EdgeInsets.all(6 * globals.widthMediaQuery),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.grayscale0,
                        ),
                        child: const Icon(
                          Icons.payment_rounded,
                          color: AppColors.primary30,
                        ),
                      ),
                      title: Text(
                        'Payment Methods'.tr,
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const PaymentPage()),
                        // );
                      }),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: EdgeInsets.all(6 * globals.widthMediaQuery),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.grayscale0,
                        ),
                        child: const Icon(
                          Icons.star_outline_rounded,
                          color: AppColors.primary30,
                        ),
                      ),
                      title: Text(
                        'Subscriptions'.tr,
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => SubscriptionPage()),
                        // );
                      }),
                ],
              ),
            ),
            Container(
              height: 12,
              color: AppColors.grayscale10,
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 16 * globals.widthMediaQuery,
                  right: 16 * globals.widthMediaQuery),
              child: Column(
                children: [
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: EdgeInsets.all(6 * globals.widthMediaQuery),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.grayscale0,
                        ),
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: AppColors.primary30,
                        ),
                      ),
                      title: Text(
                        'Notifications'.tr,
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationSettingsPage()),
                        );
                      }),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: EdgeInsets.all(6 * globals.widthMediaQuery),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.grayscale0,
                        ),
                        child: const Icon(
                          Icons.lock_outline,
                          color: AppColors.primary30,
                        ),
                      ),
                      title: Text(
                        'Privacy and Security'.tr,
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PrivacySecurityPage()),
                        );
                      }),
                ],
              ),
            ),
            Container(
              height: 12,
              color: AppColors.grayscale10,
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 16 * globals.widthMediaQuery,
                  right: 16 * globals.widthMediaQuery),
              child: Column(
                children: [
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: EdgeInsets.all(6 * globals.widthMediaQuery),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.grayscale0,
                        ),
                        child: const Icon(
                          Icons.settings_outlined,
                          color: AppColors.primary30,
                        ),
                      ),
                      title: Text(
                        'App Settings'.tr,
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AppSettings()),
                        );
                      }),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: EdgeInsets.all(6 * globals.widthMediaQuery),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.grayscale0,
                        ),
                        child: const Icon(
                          Icons.warning_amber_rounded,
                          color: AppColors.primary30,
                        ),
                      ),
                      title: Text(
                        'About App'.tr,
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutApp()),
                        );
                      }),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                          padding: EdgeInsets.all(6 * globals.widthMediaQuery),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.grayscale0,
                          ),
                          child: const Icon(Icons.contact_support_outlined,
                              color: AppColors.primary30)),
                      title: Text(
                        'Customer Support'.tr,
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CustomerSupport()),
                        );
                      }),
                ],
              ),
            ),
            Container(
              height: 12,
              color: AppColors.grayscale10,
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 16 * globals.widthMediaQuery,
                  right: 16 * globals.widthMediaQuery),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: EdgeInsets.all(6 * globals.widthMediaQuery),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grayscale0,
                      ),
                      child: const Icon(Icons.logout_rounded,
                          color: AppColors.grayscale90),
                    ),
                    title: Text(
                      'Sign Out'.tr,
                      style: AppFonts.body2(color: AppColors.error100),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        showDragHandle: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        isScrollControlled: true,
                        isDismissible: true,
                        builder: (BuildContext context) {
                          return DrowupWidget(
                            heightFactor: 0.33,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Sign Out?'.tr,
                                  style: AppFonts.title3(
                                      color: AppColors.grayscale90),
                                ),
                                SizedBox(height: 32 * globals.heightMediaQuery),
                                SizedBox(
                                  height: 52 * globals.heightMediaQuery,
                                  width: double.infinity,
                                  child: NavigateButton(
                                      onPressed: () {}, text: 'Yes'.tr),
                                ),
                                SizedBox(height: 8 * globals.heightMediaQuery),
                                SizedBox(
                                  height: 52 * globals.heightMediaQuery,
                                  width: double.infinity,
                                  child: SecondaryButton(
                                      onPressed: () {}, text: 'Cancel'.tr),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 12,
              color: AppColors.grayscale10,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
