import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../data/globals.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/toggles/toggle_active.dart';
import '../../widgets/controls_and_buttons/toggles/toggle_disabled.dart';

class PrivacySecurityPage extends ConsumerStatefulWidget {
  const PrivacySecurityPage({super.key});

  @override
  ConsumerState<PrivacySecurityPage> createState() => _PrivacySecurityPage();
}

class _PrivacySecurityPage extends ConsumerState<PrivacySecurityPage> {
  bool allowCollaboration = true;
  bool showListOfAnimals = false;
  bool showFamilyTree = false;
  bool showContactInfo = false;

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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Privacy & Security'.tr,
                style: AppFonts.title4(color: AppColors.grayscale90),
              ),
              SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Allow Collaboration'.tr,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: ToggleActive(
                  value: allowCollaboration,
                  onChanged: (value) {
                    setState(() {
                      allowCollaboration = value;
                      if (!value) {
                        // Reset the values of Phone Number and Email Address switches
                        showListOfAnimals = false;
                        showFamilyTree = false;
                      }
                    });
                  },
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Show List Of Animals'.tr,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: allowCollaboration
                    ? const ToggleDisabled(checked: true)
                    : ToggleActive(
                        value: showListOfAnimals,
                        onChanged: (value) {
                          setState(() {
                            showListOfAnimals = value;
                          });
                        }),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Show Family Tree'.tr,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: allowCollaboration
                    ? const ToggleDisabled(checked: true)
                    : ToggleActive(
                        value: showFamilyTree,
                        onChanged: (value) {
                          setState(() {
                            showFamilyTree = value;
                          });
                        }),
              ),
              SizedBox(
                height: 32 * SizeConfig.heightMultiplier(context),
              ),
              Text(
                'Contact Information'.tr,
                style: AppFonts.title4(color: AppColors.grayscale90),
              ),
              SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Show Contact Information'.tr,
                  style: AppFonts.body2(color: AppColors.grayscale90),
                ),
                trailing: ToggleActive(
                  value: showContactInfo,
                  onChanged: (value) {
                    setState(() {
                      showContactInfo = value;
                      if (!value) {}
                    });
                  },
                ),
              ),
              Visibility(
                visible: showContactInfo,
                child: Column(
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final phoneNumberVisibility =
                            ref.watch(phoneNumberVisibilityProvider);

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Phone Number'.tr,
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                          trailing: ToggleActive(
                            value: phoneNumberVisibility,
                            onChanged: showContactInfo
                                ? (value) {
                                    ref
                                        .read(phoneNumberVisibilityProvider
                                            .notifier)
                                        .update((state) => value);
                                  }
                                : null,
                          ),
                        );
                      },
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final emailAddressVisibility =
                            ref.watch(emailAddressVisibilityProvider);

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Email Address'.tr,
                            style: AppFonts.body2(color: AppColors.grayscale90),
                          ),
                          trailing: ToggleActive(
                            value: emailAddressVisibility,
                            onChanged: showContactInfo
                                ? (value) {
                                    ref
                                        .read(emailAddressVisibilityProvider
                                            .notifier)
                                        .update((state) => value);
                                  }
                                : null,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ]),
          )),
    );
  }
}
