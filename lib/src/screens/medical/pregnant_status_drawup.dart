import 'package:flutter/material.dart';
import '../../theme/colors/colors.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/inputs/draw_ups/draw_up_widget.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;

// ignore: must_be_immutable
class PregnantStatusWidget extends StatelessWidget {
  bool? newMammalpregnantStatus;
  bool? mammalpregnantStatuses;

  PregnantStatusWidget(
      {super.key, this.newMammalpregnantStatus, this.mammalpregnantStatuses});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
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
                      height: 55 * globals.heightMediaQuery,
                    ),
                    SizedBox(
                      width: 343 * globals.widthMediaQuery,
                      height: 52 * globals.heightMediaQuery,
                      child: PrimaryButton(
                          text: 'Confirm',
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
