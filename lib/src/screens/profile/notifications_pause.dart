import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/toggles/toggle_active.dart';
import '../../widgets/controls_and_buttons/toggles/toggle_disabled.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _pauseAll = false;
  bool _sysNotifications = false;
  bool _animalNotifications = false;
  bool _collaboration = false;

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
              left: 16 * globals.widthMediaQuery,
              right: 16 * globals.widthMediaQuery,
              top: 24 * globals.heightMediaQuery),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notifications',
                style: AppFonts.title4(color: AppColors.grayscale90),
              ),
              SizedBox(height: 16 * globals.heightMediaQuery),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Pause All',
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: ToggleActive(
                  onChanged: (value) {
                    setState(() {
                      _pauseAll = value;
                      if (value) {
                        // Disable other switches and turn them off
                        _sysNotifications = false;
                        _animalNotifications = false;
                        _collaboration = false;
                      }
                    });
                  },
                  value: _pauseAll,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'System Notifications',
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: _pauseAll
                    ? const ToggleDisabled(
                        checked: false,
                      )
                    : ToggleActive(
                        onChanged: (value) {
                          setState(() {
                            _sysNotifications = value;
                          });
                        },
                        value: _sysNotifications,
                      ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Animal Management',
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: _pauseAll
                    ? const ToggleDisabled(
                        checked: false,
                      )
                    : ToggleActive(
                        value: _animalNotifications,
                        onChanged: (value) {
                          setState(() {
                            _animalNotifications = value;
                          });
                        },
                      ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Collaboration',
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: _pauseAll
                    ? const ToggleDisabled(
                        checked: false,
                      )
                    : ToggleActive(
                        value: _collaboration,
                        onChanged: (value) {
                          setState(() {
                            _collaboration = value;
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
