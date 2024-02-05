import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/widgets/styled_dismissible.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  final List<Map<String, dynamic>> notifications = [
    {
      'imagePath': 'assets/icons/frame/24px/Frame-39.png',
      'title': 'New Update Available!',
      'subtitle': 'Download From AppStore Now',
      'time': DateTime.now()
          .subtract(const Duration(hours: 1)), // Example time (1 hour ago)
    },
    {
      'imagePath': 'assets/icons/frame/24px/Frame-39.png',
      'title': 'Horse Vaccination',
      'subtitle': '09.01.2023',
      'time': DateTime.now()
          .subtract(const Duration(hours: 2)), // Example time (2 hours ago)
    },
    {
      'imagePath': 'assets/icons/frame/24px/Frame-39.png',
      'title': 'Mohammed',
      'subtitle': 'Request',
      'time': DateTime.now().subtract(
          const Duration(minutes: 30)), // Example time (30 minutes ago)
    },
    // Add more data here if needed
  ];

  String formatTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day ago' : 'days ago'}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour ago' : 'hours ago'}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute ago' : 'minutes ago'}';
    } else {
      return 'Just now';
    }
  }

  String truncateTextWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: Colors.transparent,
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
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: 16 * SizeConfig.widthMultiplier(context),
              right: SizeConfig.widthMultiplier(context) * 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notifications',
                style: AppFonts.title4(color: AppColors.grayscale90),
              ),
              SizedBox(height: SizeConfig.heightMultiplier(context) * 16),
              Expanded(
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    final timeAgo =
                        formatTimeAgo(notification['time'] as DateTime);
                    return StyledDismissible(
                      onDismissed: (direction) {
                        // Remove the item from the list
                        setState(() {
                          notifications.removeAt(index);
                        });
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: SizeConfig.widthMultiplier(context) * 24,
                          backgroundImage:
                              AssetImage(notification['imagePath'] as String),
                        ),
                        title: Text(
                          truncateTextWithEllipsis(
                              notification['title'] as String, 15),
                          style:
                              AppFonts.headline4(color: AppColors.grayscale90),
                        ),
                        subtitle: Text(
                          truncateTextWithEllipsis(
                              notification['subtitle'] as String, 20),
                          style: AppFonts.body2(color: AppColors.grayscale70),
                        ),
                        trailing: (notification['subtitle'] == 'Request')
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle 'Yes' button click
                                      setState(() {
                                        notifications.removeAt(index);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: AppColors.primary50,
                                      shape: const CircleBorder(),
                                      padding: EdgeInsets.all(
                                          SizeConfig.widthMultiplier(context) *
                                              12),
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
                                      setState(() {
                                        notifications.removeAt(index);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.grayscale10,
                                      elevation: 0,
                                      shape: const CircleBorder(),
                                      padding: EdgeInsets.all(
                                          SizeConfig.widthMultiplier(context) *
                                              12),
                                    ),
                                    child: const Icon(Icons.close_rounded,
                                        color: AppColors.grayscale90),
                                  ),
                                ],
                              )
                            : Text(
                                timeAgo,
                                style: AppFonts.body2(
                                    color: AppColors.grayscale60),
                              ),
                        onTap: () {
                          // Handle tap on the list item
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
