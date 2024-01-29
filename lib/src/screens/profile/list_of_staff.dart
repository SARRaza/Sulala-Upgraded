import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import 'shimmer_list_of_staff.dart';
import 'staff_details_page.dart';

class ListOfStaff extends StatefulWidget {
  const ListOfStaff({super.key});

  @override
  State<ListOfStaff> createState() => _ListOfStaffState();
}

class _ListOfStaffState extends State<ListOfStaff> {
  List<Map<String, dynamic>> options = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDataFromBackend(); // Fetch initial data from the backend
  }

  String truncateTextWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  Future<void> fetchDataFromBackend() async {
    // Simulate fetching data from the backend
    await Future.delayed(const Duration(seconds: 2));

    // Update the options list with the fetched data
    List<Map<String, dynamic>> newData = [
      {
        'imagePath': 'assets/avatars/120px/Staff1.png',
        'title': 'Paul Rivera',
        'subtitle': 'Viewer',
        'email': 'paul@example.com',
        'phoneNumber': '+1 234 567 890',
      },
      {
        'imagePath': 'assets/avatars/120px/Staff2.png',
        'title': 'Rebecca Wilson',
        'subtitle': 'Helper',
        'email': 'paul@example.com',
        'phoneNumber': '+1 234 567 890',
      },
      {
        'imagePath': 'assets/avatars/120px/Staff3.png',
        'title': 'Patricia Williams',
        'subtitle': 'Helper',
        'email': 'paul@example.com',
        'phoneNumber': '+1 234 567 890',
      },
      {
        'imagePath': 'assets/avatars/120px/Staff1.png',
        'title': 'Scott Simmons',
        'subtitle': 'Worker',
        'email': 'paul@example.com',
        'phoneNumber': '+1 234 567 890',
      },
      {
        'imagePath': 'assets/avatars/120px/Staff2.png',
        'title': 'Lee Hall',
        'subtitle': 'Worker',
        'email': 'paul@example.com',
        'phoneNumber': '+1 234 567 890',
      },
      // Add more data as needed
    ];

    setState(() {
      options = newData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                inviteMembarDrowup(
                    context, globals.heightMediaQuery, globals.widthMediaQuery);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16 * globals.heightMediaQuery,
              right: 16 * globals.heightMediaQuery,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Staff',
                  style: AppFonts.title3(color: AppColors.grayscale90),
                ),
                SizedBox(
                  height: 24 * globals.heightMediaQuery,
                ),
                isLoading
                    ? const Center(child: ShimmerListOfStaff())
                    : options.isEmpty
                        ? Center(
                            child: Column(
                            children: [
                              SizedBox(height: 120 * globals.heightMediaQuery),
                              Image.asset(
                                'assets/illustrations/farmer.png',
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 44 * globals.heightMediaQuery),
                              Text(
                                'You have no staff',
                                style: AppFonts.headline3(
                                    color: AppColors.grayscale90),
                              ),
                              SizedBox(height: 90 * globals.heightMediaQuery),
                              SizedBox(
                                  width: 154 * globals.widthMediaQuery,
                                  height: 52 * globals.heightMediaQuery,
                                  child: PrimaryButton(
                                      text: 'Invite a Member',
                                      onPressed: () {
                                        inviteMembarDrowup(
                                            context,
                                            globals.heightMediaQuery,
                                            globals.widthMediaQuery);
                                      }))
                            ],
                          ))
                        : ListView.builder(
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 24 * globals.widthMediaQuery,
                                  backgroundImage:
                                      AssetImage(options[index]['imagePath']),
                                ),
                                title: Text(
                                  options[index]['title'],
                                  style: AppFonts.headline3(
                                      color: AppColors.grayscale90),
                                ),
                                subtitle: Text(options[index]['subtitle'],
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
                                        imagePath: options[index]['imagePath'],
                                        title: options[index]['title'],
                                        subtitle: options[index]['subtitle'],
                                        email: options[index]['email'],
                                        phoneNumber: options[index]
                                            ['phoneNumber'],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                options.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24 * globals.heightMediaQuery),
                          Text(
                            'Requests',
                            style: AppFonts.headline3(
                                color: AppColors.grayscale80),
                          ),
                          SizedBox(height: 8 * globals.heightMediaQuery),
                          ListView.builder(
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                minVerticalPadding:
                                    8 * globals.heightMediaQuery,
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 24 * globals.widthMediaQuery,
                                  backgroundImage:
                                      AssetImage(options[index]['imagePath']),
                                ),
                                title: Text(
                                  options[index]['title'],
                                  style: AppFonts.headline3(
                                      color: AppColors.grayscale90),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Handle 'Yes' button click
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: AppColors.primary50,
                                        shape: const CircleBorder(),
                                        padding: EdgeInsets.all(
                                            12 * globals.widthMediaQuery),
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
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.grayscale10,
                                        elevation: 0,
                                        shape: const CircleBorder(),
                                        padding: EdgeInsets.all(
                                            globals.widthMediaQuery * 12),
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

  Future<dynamic> inviteMembarDrowup(
      BuildContext context, double heightMediaQuery, double widthMediaQuery) {
    return showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return DrowupWidget(
          heightFactor: 0.41,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Invite Member',
                style: AppFonts.title3(color: AppColors.grayscale90),
              ),
              Text(
                'Share this link that will provide users access to your farm',
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
                    initialValue: truncateTextWithEllipsis(
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
                      // CustomSnackBar.show(
                      //     context, 'Link Copied To Clipboard');

                      Navigator.pop(
                          context); // Navigate back to the previous screen
                    },
                    child: Text('Copy Link    ',
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
                  text: 'Share Link',
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
