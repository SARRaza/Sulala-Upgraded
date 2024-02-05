// import 'package:flutter/material.dart';
// import '../../theme/colors/colors.dart';
// import '../../theme/fonts/fonts.dart';
// import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
// import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

// class AppSettings extends StatefulWidget {
//   const AppSettings({super.key});

//   @override
//   State<AppSettings> createState() => _AppSettings();
// }

// class _AppSettings extends State<AppSettings> {
//   String selectedLanguage = '';
//   String selectedLanguageTemp = '';

//   void _showLanguageSelection() {
//     List<String> languages = ['English', 'Arabic', 'Hindi'];
//     showModalBottomSheet(
//       showDragHandle: true,
//       backgroundColor: Colors.transparent,
//       context: context,
//       isScrollControlled: true,
//       isDismissible: true,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return DrowupWidget(
//               heightFactor: 0.45,
//               heading: 'Language Of The App',
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   for (int i = 0; i < languages.length; i++)
//                     ListTile(
//                       contentPadding: EdgeInsets.zero,
//                       title: Text(languages[i]),
//                       trailing: selectedLanguageTemp == languages[i]
//                           ? Container(
//                               width: 25,
//                               height: 25,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color: AppColors.primary20,
//                                   width: 6.0,
//                                 ),
//                               ),
//                             )
//                           : Container(
//                               width: 25,
//                               height: 25,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color: AppColors.grayscale30,
//                                   width: 1.0,
//                                 ),
//                               ),
//                             ),
//                       onTap: () {
//                         setState(() {
//                           selectedLanguageTemp = languages[i];
//                         });
//                       },
//                     ),
//                   SizedBox(height: 32 * SizeConfig.heightMultiplier(context)),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 52 * SizeConfig.heightMultiplier(context),
//                     child: PrimaryButton(
//                         onPressed: () {
//                           setState(() {
//                             selectedLanguage = selectedLanguageTemp;
//                           });
//                           Navigator.pop(context);
//                         },
//                         text: 'Save'),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     ).then((_) {
//       setState(() {
//         selectedLanguage = selectedLanguageTemp;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         scrolledUnderElevation: 0.0,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: Text(
//           'App Settings',
//           style: AppFonts.headline3(color: AppColors.grayscale90),
//         ),
//         leading: IconButton(
//           padding: EdgeInsets.zero,
//           icon: Container(
//             padding: const EdgeInsets.all(8.0),
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: AppColors.grayscale10,
//             ),
//             child: const Icon(
//               Icons.arrow_back,
//               color: AppColors.grayscale90,
//             ),
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(
//               left: 16 * SizeConfig.widthMultiplier(context),
//               right: 16 * SizeConfig.widthMultiplier(context),
//               top: 24 * SizeConfig.heightMultiplier(context)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 8),
//               ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 title: Text(
//                   'Language',
//                   style: AppFonts.body1(color: AppColors.grayscale90),
//                 ),
//                 subtitle: Text(
//                   'English',
//                   style: AppFonts.body2(color: AppColors.grayscale60),
//                 ),
//                 onTap: _showLanguageSelection,
//                 trailing: const Icon(
//                   Icons.chevron_right_rounded,
//                   color: AppColors.grayscale60,
//                   size: 35,
//                 ),
//               ),
//               const Divider()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/globals.dart';
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';

class AppSettings extends ConsumerStatefulWidget {
  const AppSettings({super.key});

  @override
  _AppSettings createState() => _AppSettings();
}

class _AppSettings extends ConsumerState<AppSettings> {
  final Map<String, Locale> _supportedLocales = {
    'English': const Locale('en', 'US'),
    'Hindi': const Locale('hi', 'IN'),
    'Arabic': const Locale('ar', 'SA'),
    'French': const Locale('fr', 'FR')
  };

  late Locale? selectedLocale;

  @override
  void initState() {
    selectedLocale = Get.locale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'App Settings'.tr,
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
              const SizedBox(height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Language'.tr,
                  style: AppFonts.body1(color: AppColors.grayscale90),
                ),
                subtitle: Text(
                  _supportedLocales.keys.firstWhere(
                      (language) => _supportedLocales[language] == Get.locale),
                  style: AppFonts.body2(color: AppColors.grayscale60),
                ),
                onTap: _showLanguageSelection,
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.grayscale60,
                  size: 35,
                ),
              ),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageSelection() {
    double sheetHeight = MediaQuery.of(context).size.height * 0.60;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              constraints: BoxConstraints(maxHeight: sheetHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Language Of The App'.tr,
                      style: AppFonts.title3(color: AppColors.grayscale90),
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: _supportedLocales.keys.map((name) {
                          final locale = _supportedLocales[name];

                          return ListTile(
                            title: Text(name),
                            trailing: locale == selectedLocale
                                ? Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.primary20,
                                        width: 6.0,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.grayscale30,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                            onTap: () {
                              setState(() {
                                selectedLocale = locale;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 32 * SizeConfig.heightMultiplier(context)),
                  SizedBox(
                    width: double.infinity,
                    height: 52 * SizeConfig.heightMultiplier(context),
                    child: PrimaryButton(
                      onPressed: () {
                        if (selectedLocale != null) {
                          Get.updateLocale(selectedLocale!);
                        }

                        Navigator.pop(context);
                      },
                      text: 'Save',
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(12.0),
                  //   child: ButtonWidget(
                  //     onPressed: () {
                  //       setState(() {
                  //         selectedLanguage = selectedLanguageTemp;
                  //       });
                  //       Get.updateLocale(Locale.fromSubtags(
                  //           languageCode: locales
                  //               .firstWhere((locale) =>
                  //                   locale['name'] ==
                  //                   selectedLanguage)['locale']
                  //               .languageCode,
                  //           countryCode: locales
                  //               .firstWhere((locale) =>
                  //                   locale['name'] ==
                  //                   selectedLanguage)['locale']
                  //               .countryCode));
                  //       Navigator.pop(context);
                  //     },
                  //     buttonText: 'Save'.tr,
                  //   ),
                  // ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
