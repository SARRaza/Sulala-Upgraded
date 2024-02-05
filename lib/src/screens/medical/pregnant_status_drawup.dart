import 'package:flutter/material.dart';
import '../../data/globals.dart';
import '../../theme/colors/colors.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

// ignore: must_be_immutable
class PregnantStatusWidget extends StatefulWidget {
  bool mammalpregnantStatuses;

  PregnantStatusWidget({super.key, required this.mammalpregnantStatuses});

  @override
  State<PregnantStatusWidget> createState() => _PregnantStatusWidgetState();
}

class _PregnantStatusWidgetState extends State<PregnantStatusWidget> {
  late bool mammalpregnantStatuses;

  @override
  void initState() {
    mammalpregnantStatuses = widget.mammalpregnantStatuses;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: DrowupWidget(
        heightFactor: 0.45,
        heading: 'Pregnancy Status',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Not Pregnant'),
                  trailing: mammalpregnantStatuses == false
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
                        mammalpregnantStatuses = false;
                      },
                    );
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Pregnant'),
                  trailing: mammalpregnantStatuses == true
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
                      mammalpregnantStatuses = true;
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
                      text: 'Confirm',
                      onPressed: () {
                        Navigator.pop(context, mammalpregnantStatuses);
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
