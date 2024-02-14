import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';

class PregnantStatusWidget extends StatefulWidget {
  final bool mammalPregnantStatus;

  const PregnantStatusWidget({super.key, required this.mammalPregnantStatus});

  @override
  State<PregnantStatusWidget> createState() => _PregnantStatusWidgetState();
}

class _PregnantStatusWidgetState extends State<PregnantStatusWidget> {
  late bool mammalPregnantStatuses;

  @override
  void initState() {
    mammalPregnantStatuses = widget.mammalPregnantStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: DrawUpWidget(
        heightFactor: 0.45,
        heading: 'Pregnancy Status'.tr,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Not Pregnant'.tr),
                  trailing: mammalPregnantStatuses == false
                      ? Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary30,
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
                              color: AppColors.grayscale20,
                              width: 1.0,
                            ),
                          ),
                        ),
                  onTap: () {
                    setState(
                      () {
                        mammalPregnantStatuses = false;
                      },
                    );
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Pregnant'.tr),
                  trailing: mammalPregnantStatuses == true
                      ? Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary30,
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
                              color: AppColors.grayscale20,
                              width: 1.0,
                            ),
                          ),
                        ),
                  onTap: () {
                    setState(() {
                      mammalPregnantStatuses = true;
                    });
                  },
                ),
                SizedBox(
                  height: 55 * SizeConfig.heightMultiplier(context),
                ),
                SizedBox(
                  width: 343 * SizeConfig.widthMultiplier(context),
                  height: 52 * SizeConfig.heightMultiplier(context),
                  child: PrimaryButton(
                      text: 'Confirm'.tr,
                      onPressed: () {
                        Navigator.pop(context, mammalPregnantStatuses);
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
