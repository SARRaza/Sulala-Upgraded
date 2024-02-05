import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sulala_upgrade/src/screens/profile/privacy_security.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutApp();
}

class _AboutApp extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'About App'.tr,
            style: AppFonts.headline3(color: AppColors.grayscale90),
          ),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: 16 * SizeConfig.widthMultiplier(context),
                right: 16 * SizeConfig.widthMultiplier(context),
                top: 24 * SizeConfig.heightMultiplier(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 120 * SizeConfig.widthMultiplier(context),
                    height: 120 * SizeConfig.widthMultiplier(context),
                    decoration: BoxDecoration(
                      color: AppColors.secondary10,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                        child: Image(
                      image: AssetImage('assets/graphic/Logotype.png'),
                    )),
                  ),
                ),
                SizedBox(height: 16 * SizeConfig.heightMultiplier(context)),
                FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                          child: Text(
                              'appVersion'.trParams(
                                  {'version': snapshot.data!.version}),
                              style:
                                  AppFonts.body2(color: AppColors.grayscale70)),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
                SizedBox(
                  height: 32 * SizeConfig.heightMultiplier(context),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.grayscale20,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Terms Of Use'.tr,
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      size: 30,
                      color: AppColors.grayscale50,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Privacy Policy'.tr,
                    style: AppFonts.body2(color: AppColors.grayscale90),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    size: 30,
                    color: AppColors.grayscale50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
