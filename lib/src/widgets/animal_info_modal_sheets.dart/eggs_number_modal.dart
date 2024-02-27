import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controls_and_buttons/buttons/sar_button_widget.dart';
import '../inputs/text_fields/primary_text_field.dart';
import 'package:sulala_upgrade/src/data/globals.dart';

class EggsNumberModal extends StatelessWidget {
  final int eggsNumber;
  const EggsNumberModal({super.key, required this.eggsNumber});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: eggsNumber.toString());
    return Padding(
      padding: EdgeInsets.only(
          left: 16.0,
          top: 16.0,
          right: 16.0,
          bottom: 16 + MediaQuery.of(context).viewInsets.bottom
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add Number Of Eggs'.tr,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          PrimaryTextField(
            hintText: 'Enter Number Of Eggs'.tr,
            labelText: 'Enter Number Of Eggs'.tr,
            controller: controller,
          ),
          SizedBox(height: SizeConfig.heightMultiplier(context) * 35),
          ButtonWidget(
            onPressed: () {
              Navigator.pop(context, int.tryParse(controller.text) ?? 0);
            },
            buttonText: 'Confirm'.tr,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 238, 238, 238),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text('Cancel'.tr),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
