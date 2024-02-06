import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/toggles/toggle_active.dart';
import '../../widgets/controls_and_buttons/toggles/toggle_disabled.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool pauseAll = false;
  bool sysNotifications = false;
  bool animalNotifications = false;
  bool collaboration = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.grayscale10,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.grayscale90,
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
              right: 16 * SizeConfig.widthMultiplier(context),
              top: 24 * SizeConfig.heightMultiplier(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notifications'.tr,
                style: AppFonts.title4(color: AppColors.grayscale90),
              ),
              SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Pause All'.tr,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: ToggleActive(
                  onChanged: (value) {
                    setState(() {
                      pauseAll = value;
                      if (value) {
                        // Disable other switches and turn them off
                        sysNotifications = false;
                        animalNotifications = false;
                        collaboration = false;
                      }
                    });
                  },
                  value: pauseAll,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'System Notifications'.tr,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: pauseAll
                    ? const ToggleDisabled(
                        checked: false,
                      )
                    : ToggleActive(
                        onChanged: (value) {
                          setState(() {
                            sysNotifications = value;
                          });
                        },
                        value: sysNotifications,
                      ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Animal Management'.tr,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: pauseAll
                    ? const ToggleDisabled(
                        checked: false,
                      )
                    : ToggleActive(
                        value: animalNotifications,
                        onChanged: (value) {
                          setState(() {
                            animalNotifications = value;
                          });
                        },
                      ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Collaboration'.tr,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: pauseAll
                    ? const ToggleDisabled(
                        checked: false,
                      )
                    : ToggleActive(
                        value: collaboration,
                        onChanged: (value) {
                          setState(() {
                            collaboration = value;
                          });
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
