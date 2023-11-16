// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/toggles/toggle_active.dart';
import '../../widgets/controls_and_buttons/toggles/toggle_disabled.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

class PrivacySecurityPage extends StatefulWidget {
  const PrivacySecurityPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrivacySecurityPage createState() => _PrivacySecurityPage();
}

class _PrivacySecurityPage extends State<PrivacySecurityPage> {
  bool _AllowCollab = true;
  bool _ShowListOfAnimals = false;
  bool _ShowFamilyTree = false;
  bool _ShowContactInfo = false;
  bool _PhoneNumber = false;
  bool _EmailAddress = false;

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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Privacy & Security',
                style: AppFonts.title4(color: AppColors.grayscale90),
              ),
              SizedBox(height: 16 * globals.heightMediaQuery),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Allow Collaboration',
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: ToggleActive(
                  value: _AllowCollab,
                  onChanged: (value) {
                    setState(() {
                      _AllowCollab = value;
                      if (!value) {
                        // Reset the values of Phone Number and Email Address switches
                        _ShowListOfAnimals = false;
                        _ShowFamilyTree = false;
                      }
                    });
                  },
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Show List Of Animals',
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: _AllowCollab
                    ? const ToggleDisabled(checked: true)
                    : ToggleActive(
                        value: _ShowListOfAnimals,
                        onChanged: (value) {
                          setState(() {
                            _ShowListOfAnimals = value;
                          });
                        }),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Show Family Tree',
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: _AllowCollab
                    ? const ToggleDisabled(checked: true)
                    : ToggleActive(
                        value: _ShowFamilyTree,
                        onChanged: (value) {
                          setState(() {
                            _ShowFamilyTree = value;
                          });
                        }),
              ),
              SizedBox(
                height: 32 * globals.heightMediaQuery,
              ),
              Text(
                'Contact Information',
                style: AppFonts.title4(color: AppColors.grayscale90),
              ),
              SizedBox(height: 16 * globals.heightMediaQuery),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Show Contact Information',
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: ToggleActive(
                  value: _ShowContactInfo,
                  onChanged: (value) {
                    setState(() {
                      _ShowContactInfo = value;
                      if (!value) {
                        // Reset the values of Phone Number and Email Address switches
                        _PhoneNumber = false;
                        _EmailAddress = false;
                      }
                    });
                  },
                ),
              ),
              Visibility(
                visible: _ShowContactInfo,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Phone Number',
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                      trailing: ToggleActive(
                        value: _PhoneNumber,
                        onChanged: _ShowContactInfo
                            ? (value) {
                                setState(() {
                                  _PhoneNumber = value;
                                });
                              }
                            : null,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Email Address',
                        style: AppFonts.body2(color: AppColors.grayscale90),
                      ),
                      trailing: ToggleActive(
                        value: _EmailAddress,
                        onChanged: _ShowContactInfo
                            ? (value) {
                                setState(() {
                                  _EmailAddress = value;
                                });
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )),
    );
  }
}
