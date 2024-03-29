import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

import '../controls_and_buttons/buttons/primary_button.dart';
import '../controls_and_buttons/tags/custom_tags.dart';

class AnimalTagsModal extends StatefulWidget {
  const AnimalTagsModal({super.key, required this.selectedTags});
  final List<String> selectedTags;

  @override
  State<AnimalTagsModal> createState() => _AnimalTagsModalState();
}

class _AnimalTagsModalState extends State<AnimalTagsModal> {
  late List<String> selectedTags;

  @override
  void initState() {
    super.initState();
    selectedTags = widget.selectedTags;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tags'.tr,
              style: AppFonts.title2(color: AppColors.grayscale90),
            ),
            const SizedBox(height: 25),
            Text(
              'Current State'.tr,
              style: AppFonts.headline3(color: AppColors.grayscale90),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 10,
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                CustomTag(
                  label: 'Borrowed'.tr,
                  selected: selectedTags.contains('Borrowed'),
                  onTap: () {
                    setState(() {
                      if (selectedTags.contains('Borrowed')) {
                        selectedTags.remove('Borrowed');
                      } else {
                        selectedTags.add('Borrowed');
                      }
                    });
                  },
                ),
                CustomTag(
                  label: 'Adopted'.tr,
                  selected: selectedTags.contains('Adopted'),
                  onTap: () {
                    setState(() {
                      if (selectedTags.contains('Adopted')) {
                        selectedTags.remove('Adopted');
                      } else {
                        selectedTags.add('Adopted');
                      }
                    });
                  },
                ),
                CustomTag(
                  label: 'Donated'.tr,
                  selected: selectedTags.contains('Donated'),
                  onTap: () {
                    setState(() {
                      if (selectedTags.contains('Donated')) {
                        selectedTags.remove('Donated');
                      } else {
                        selectedTags.add('Donated');
                      }
                    });
                  },
                ),
                CustomTag(
                  label: 'Escaped'.tr,
                  selected: selectedTags.contains('Escaped'),
                  onTap: () {
                    setState(() {
                      if (selectedTags.contains('Escaped')) {
                        selectedTags.remove('Escaped');
                      } else {
                        selectedTags.add('Escaped');
                      }
                    });
                  },
                ),
                CustomTag(
                  label: 'Stolen'.tr,
                  selected: selectedTags.contains('Stolen'),
                  onTap: () {
                    setState(() {
                      if (selectedTags.contains('Stolen')) {
                        selectedTags.remove('Stolen');
                      } else {
                        selectedTags.add('Stolen');
                      }
                    });
                  },
                ),
                CustomTag(
                  label: 'Transferred'.tr,
                  selected: selectedTags.contains('Transferred'),
                  onTap: () {
                    setState(() {
                      if (selectedTags.contains('Transferred')) {
                        selectedTags.remove('Transferred');
                      } else {
                        selectedTags.add('Transferred');
                      }
                    });
                  },
                ),

                // Add more chips here
              ],
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 20,
            ),
            Text(
              'Medical State'.tr,
              style: AppFonts.headline3(color: AppColors.grayscale90),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 10,
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                CustomTag(
                  label: 'Injured'.tr,
                  selected: selectedTags.contains('Injured'),
                  onTap: () {
                    setState(() {
                      if (selectedTags.contains('Injured')) {
                        selectedTags.remove('Injured');
                      } else {
                        selectedTags.add('Injured');
                      }
                    });
                  },
                ),
                CustomTag(
                  label: 'Sick'.tr,
                  selected: selectedTags.contains('Sick'),
                  onTap: () {
                    setState(() {
                      if (selectedTags.contains('Sick')) {
                        selectedTags.remove('Sick');
                      } else {
                        selectedTags.add('Sick');
                      }
                    });
                  },
                ),
                CustomTag(
                  label: 'Quarantined'.tr,
                  selected: selectedTags.contains('Quarantined'),
                  onTap: () {
                    setState(() {
                      if (selectedTags.contains('Quarantined')) {
                        selectedTags.remove('Quarantined');
                      } else {
                        selectedTags.add('Quarantined');
                      }
                    });
                  },
                ),
                CustomTag(
                  label: 'Medication'.tr,
                  selected: selectedTags.contains('Medication'),
                  onTap: () {
                    setState(() {
                      if (selectedTags.contains('Medication')) {
                        selectedTags.remove('Medication');
                      } else {
                        selectedTags.add('Medication');
                      }
                    });
                  },
                ),
                CustomTag(
                  label: 'Testing'.tr,
                  selected: selectedTags.contains('Testing'),
                  onTap: () {
                    setState(() {
                      if (selectedTags.contains('Testing')) {
                        selectedTags.remove('Testing');
                      } else {
                        selectedTags.add('Testing');
                      }
                    });
                  },
                ),
                CustomTag(
                  label: 'Pregnant'.tr,
                  selected: selectedTags.contains('Pregnant'),
                  onTap: () {
                    setState(() {
                      if (selectedTags.contains('Pregnant')) {
                        selectedTags.remove('Pregnant');
                      } else {
                        selectedTags.add('Pregnant');
                      }
                    });
                  },
                ),
                CustomTag(
                  label: 'Lactating'.tr,
                  selected: selectedTags.contains('Lactating'),
                  onTap: () {
                    setState(() {
                      if (selectedTags.contains('Lactating')) {
                        selectedTags.remove('Lactating');
                      } else {
                        selectedTags.add('Lactating');
                      }
                    });
                  },
                ),

                // Add more chips here
              ],
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 20,
            ),
            Text(
              'Other'.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier(context) * 10,
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                CustomTag(
                  label: 'Sold'.tr,
                  selected: selectedTags.contains('Sold'),
                  onTap: () {
                    setState(() {
                      if (selectedTags.contains('Sold')) {
                        selectedTags.remove('Sold');
                      } else {
                        selectedTags.add('Sold');
                      }
                    });
                  },
                ),
                CustomTag(
                  label: 'Dead'.tr,
                  selected: selectedTags.contains('Dead'),
                  onTap: () {
                    setState(() {
                      if (selectedTags.contains('Dead')) {
                        selectedTags.remove('Dead');
                      } else {
                        selectedTags.add('Dead');
                      }
                    });
                  },
                ),
                // Add more chips here
              ],
            ),
            const SizedBox(height: 77.0),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      Navigator.of(context).pop(selectedTags);
                    },
                    status: PrimaryButtonStatus.idle,
                    text: 'Save'.tr,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
