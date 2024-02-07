import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/text_fields/primary_text_field.dart';
import 'sign_up.dart';

class JoinNow extends ConsumerStatefulWidget {
  const JoinNow({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<JoinNow> createState() => _JoinNowState();
}

class _JoinNowState extends ConsumerState<JoinNow>
    with SingleTickerProviderStateMixin {
  bool hasError = false;

  final _whoOwnTheFarmController = TextEditingController();
  final _whatIsTheNameOfYourFarmController = TextEditingController();

  int _contentState = 0;

  @override
  void dispose() {
    _whoOwnTheFarmController.dispose();
    _whatIsTheNameOfYourFarmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: SizeConfig.widthMultiplier(context) * 375,
                child: Image.asset(
                  "assets/graphic/Animal_p.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier(context) * 185,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          SizeConfig.widthMultiplier(context) * 32,
                        ),
                        topRight: Radius.circular(
                          SizeConfig.widthMultiplier(context) * 32,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        SizeConfig.widthMultiplier(context) * 16,
                        0,
                        SizeConfig.widthMultiplier(context) * 16,
                        MediaQuery.of(context)
                            .viewInsets
                            .bottom, // Adjusts for keyboard
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.heightMultiplier(context) * 41,
                          ),
                          _contentState == 0
                              ? Column(
                                  children: [
                                    Text(
                                      'What Is The Name Of Your Farm?'.tr,
                                      style: AppFonts.title2(
                                        color: AppColors.grayscale90,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.heightMultiplier(context) *
                                              41,
                                    ),
                                    PrimaryTextField(
                                      controller:
                                          _whatIsTheNameOfYourFarmController,
                                      hintText: 'Farm Name'.tr,
                                      errorMessage: hasError == true
                                          ? 'Field cannot be empty'.tr
                                          : null,
                                      onChanged: (value) {
                                        ref
                                            .read(
                                                whatIsTheNameOfYourFarmProvider
                                                    .notifier)
                                            .update((state) => value);
                                      },
                                      onErrorChanged: (value) {
                                        hasError = value;
                                      },
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.heightMultiplier(context) *
                                              24,
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.heightMultiplier(context) *
                                              52,
                                      width: double.infinity,
                                      child: PrimaryButton(
                                        text: "Continue".tr,
                                        onPressed: () {
                                          if (ref
                                              .read(
                                                  whatIsTheNameOfYourFarmProvider)
                                              .isNotEmpty) {
                                            setState(() {
                                              _whatIsTheNameOfYourFarmController
                                                  .clear();
                                              _contentState = 1;
                                              hasError = false;
                                            });
                                          } else {
                                            setState(() {
                                              hasError = true;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Text(
                                      "Who owns the farm?".tr,
                                      style: AppFonts.title2(
                                        color: AppColors.grayscale90,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.heightMultiplier(context) *
                                              41,
                                    ),
                                    PrimaryTextField(
                                      controller: _whoOwnTheFarmController,
                                      hintText: 'Owner name'.tr,
                                      errorMessage: hasError == true
                                          ? 'Field cannot be empty'.tr
                                          : null,
                                      onChanged: (value) {
                                        ref
                                            .read(
                                                whoOwnTheFarmProvider.notifier)
                                            .update((state) => value);
                                      },
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.heightMultiplier(context) *
                                              24,
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.heightMultiplier(context) *
                                              52,
                                      width: double.infinity,
                                      child: PrimaryButton(
                                        text: "Continue".tr,
                                        onPressed: () {
                                          if (ref
                                              .read(whoOwnTheFarmProvider)
                                              .isNotEmpty) {
                                            setState(() {
                                              // whoOwnTheFarmController.clear();
                                              hasError = false;
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignUp(),
                                                ),
                                              );
                                            });
                                          } else {
                                            setState(() {
                                              hasError = true;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
