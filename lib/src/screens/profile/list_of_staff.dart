import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import '../../data/classes/staff_member.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import '../../widgets/other/custom_snack_bar.dart';
import 'shimmer_list_of_staff.dart';
import 'staff_details_page.dart';

class ListOfStaff extends ConsumerStatefulWidget {
  const ListOfStaff({super.key});

  @override
  ConsumerState<ListOfStaff> createState() => _ListOfStaffState();
}

class _ListOfStaffState extends ConsumerState<ListOfStaff> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDataFromBackend(); // Fetch initial data from the backend
  }

  String _truncateTextWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  Future<void> _fetchDataFromBackend() async {
    // Simulate fetching data from the backend
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final staff = ref.watch(staffProvider);
    final requests = ref.watch(collaborationRequestsProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.grayscale10,
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.grayscale90,
                )),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.grayscale10,
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                _showInviteDrawUp(context, SizeConfig.heightMultiplier(context),
                    SizeConfig.widthMultiplier(context));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16 * SizeConfig.heightMultiplier(context),
              right: 16 * SizeConfig.heightMultiplier(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Staff'.tr,
                  style: AppFonts.title3(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: 24 * SizeConfig.heightMultiplier(context),
                ),
                isLoading
                    ? const Center(child: ShimmerListOfStaff())
                    : staff.isEmpty
                        ? Center(
                            child: Column(
                            children: [
                              SizedBox(
                                  height: 120 *
                                      SizeConfig.heightMultiplier(context)),
                              Image.asset(
                                'assets/illustrations/farmer.png',
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                  height: 44 *
                                      SizeConfig.heightMultiplier(context)),
                              Text(
                                'You have no staff'.tr,
                                style: AppFonts.headline3(
                                    color: AppColors.grayscale90),
                              ),
                              SizedBox(
                                  height: 90 *
                                      SizeConfig.heightMultiplier(context)),
                              SizedBox(
                                  width:
                                      154 * SizeConfig.widthMultiplier(context),
                                  height:
                                      52 * SizeConfig.heightMultiplier(context),
                                  child: PrimaryButton(
                                      text: 'Invite a Member'.tr,
                                      onPressed: () {
                                        _showInviteDrawUp(
                                            context,
                                            SizeConfig.heightMultiplier(
                                                context),
                                            SizeConfig.widthMultiplier(
                                                context));
                                      }))
                            ],
                          ))
                        : ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: staff.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius:
                                      24 * SizeConfig.widthMultiplier(context),
                                  backgroundImage: staff[index].image,
                                ),
                                title: Text(
                                  staff[index].name,
                                  style: AppFonts.headline3(
                                      color: AppColors.grayscale90),
                                ),
                                subtitle: Text(staff[index].role,
                                    style: AppFonts.body2(
                                        color: AppColors.grayscale70)),
                                trailing: const Icon(
                                  Icons.chevron_right_rounded,
                                  color: AppColors.grayscale50,
                                  size: 30,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StaffDetailsPage(
                                        staffMemberId: staff[index].id!,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                requests.isEmpty || isLoading
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height:
                                  24 * SizeConfig.heightMultiplier(context)),
                          Text(
                            'Requests'.tr,
                            style: AppFonts.headline3(
                                color: AppColors.grayscale80),
                          ),
                          SizedBox(
                              height: 8 * SizeConfig.heightMultiplier(context)),
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: requests.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                minVerticalPadding:
                                    8 * SizeConfig.heightMultiplier(context),
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius:
                                      24 * SizeConfig.widthMultiplier(context),
                                  backgroundImage: requests[index].image,
                                ),
                                title: Text(
                                  requests[index].name,
                                  style: AppFonts.headline3(
                                      color: AppColors.grayscale90),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Handle 'Yes' button click
                                        ref.read(staffProvider.notifier).update(
                                            (state) =>
                                                List<StaffMember>.from(state)
                                                  ..add(requests[index]));
                                        ref
                                            .read(collaborationRequestsProvider
                                                .notifier)
                                            .update((state) => state
                                                .where((request) =>
                                                    request.name !=
                                                    requests[index].name)
                                                .toList());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: AppColors.primary50,
                                        shape: const CircleBorder(),
                                        padding: EdgeInsets.all(12 *
                                            SizeConfig.widthMultiplier(
                                                context)),
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ),
                                    // SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Handle 'No' button click
                                        ref
                                            .read(collaborationRequestsProvider
                                                .notifier)
                                            .update((state) => state
                                                .where((request) =>
                                                    request.name !=
                                                    requests[index].name)
                                                .toList());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.grayscale10,
                                        elevation: 0,
                                        shape: const CircleBorder(),
                                        padding: EdgeInsets.all(
                                            SizeConfig.widthMultiplier(
                                                    context) *
                                                12),
                                      ),
                                      child: const Icon(Icons.close_rounded,
                                          color: AppColors.grayscale90),
                                    ),
                                    const Icon(Icons.chevron_right_rounded,
                                        color: AppColors.grayscale50, size: 30),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showInviteDrawUp(
      BuildContext context, double heightMediaQuery, double widthMediaQuery) {
    return showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return DrawUpWidget(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Invite Member'.tr,
                style: AppFonts.title3(color: AppColors.grayscale90),
              ),
              Text(
                'Share this link that will provide users access to your farm'
                    .tr,
                style: AppFonts.body2(color: AppColors.grayscale70),
              ),
              SizedBox(
                height: 32 * heightMediaQuery,
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextFormField(
                    style: AppFonts.body2(color: AppColors.grayscale90),
                    initialValue: _truncateTextWithEllipsis(
                        'https://example.com',
                        30), // Replace with your link value from the backend
                    readOnly: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(48.0),
                        borderSide: const BorderSide(
                          color: AppColors.grayscale20,
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(
                          20 * widthMediaQuery,
                          14 * heightMediaQuery,
                          8 * widthMediaQuery,
                          14 * heightMediaQuery),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      const link =
                          'https://example.com'; // Replace with your link value from the backend
                      Clipboard.setData(const ClipboardData(text: link));
                      CustomSnackBar.show(
                          context, 'Link Copied To Clipboard'.tr, Icons.copy, 20);

                      Navigator.pop(
                          context); // Navigate back to the previous screen
                    },
                    child: Text('Copy Link'.tr,
                        style: AppFonts.body1(color: AppColors.primary40)),
                  ),
                ],
              ),
              SizedBox(
                height: 32 * heightMediaQuery,
              ),
              SizedBox(
                width: double.infinity,
                height: 52 * heightMediaQuery,
                child: PrimaryButton(
                  onPressed: _shareLink,
                  text: 'Share Link'.tr,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _shareLink() {
    Share.share('https://example.com');
  }
}
