import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart';
import 'package:sulala_upgrade/src/data/riverpod_globals.dart';
import '../../../data/countries_data.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../lists/countries_widget/countries_widget.dart';
import '../draw_ups/draw_up_widget.dart';

class PhoneNumberField extends ConsumerStatefulWidget {
  final String? label;
  final Function(String)? onSave;
  final TextEditingController? controller;

  const PhoneNumberField({Key? key, this.label, this.onSave, this.controller})
      : super(key: key);

  @override
  ConsumerState<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends ConsumerState<PhoneNumberField> {
  Color _borderColor = AppColors.grayscale20;
  Color _backgroundColor = AppColors.grayscale0;
  final FocusNode _focusNode = FocusNode();
  late final TextEditingController _textEditingController;
  bool _hasError = false;
  CountryInfo? selectedCountry;

  void _clearText() {
    _textEditingController.clear();
    // Reset error state when clearing text
    setState(() {
      _hasError = false;
      _borderColor = AppColors.grayscale20;
      _backgroundColor = AppColors.grayscale0;
    });
  }

  void _validatePhoneNumber(String value) {
    // Check if the phone number contains only digits
    bool isValidPhoneNumber = int.tryParse(value) != null;

    setState(() {
      _hasError = !isValidPhoneNumber;
      _borderColor =
          isValidPhoneNumber ? AppColors.primary30 : AppColors.error100;
      _backgroundColor =
          isValidPhoneNumber ? AppColors.grayscale0 : AppColors.error10;
    });
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = widget.controller ?? TextEditingController();
    _textEditingController.text = ref.read(phoneNumberProvider);
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _borderColor = _focusNode.hasFocus
          ? (_hasError ? AppColors.error100 : AppColors.primary30)
          : (_hasError ? AppColors.error100 : AppColors.grayscale20);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) // Conditionally show the label
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label!,
                  style: AppFonts.caption2(color: AppColors.grayscale90),
                ),
                _buildPhoneNumberField(),
              ],
            ),
          if (widget.label == null) _buildPhoneNumberField(),
          if (_hasError)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Phone numbers can't have text".tr,
                style: AppFonts.caption2(color: AppColors.error100),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    final countryFlag = ref.watch(selectedCountryFlagProvider);
    final countryCode = ref.watch(selectedCountryCodeProvider);
    var phoneNumber = ref.watch(phoneNumberProvider);
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: _backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
          side: BorderSide(color: _borderColor, width: 1.0),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: _backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  _showFilterModalSheet(context);
                },
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  bottomLeft: Radius.circular(24.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: SizeConfig.widthMultiplier(context) * 9),
                    Image.asset(
                      countryFlag,
                      width: 24,
                    ),
                    Text(
                      countryCode,
                      style: AppFonts.body2(color: AppColors.grayscale90),
                    ),
                    Icon(Icons.arrow_drop_down_rounded,
                        color: AppColors.primary40,
                        size: SizeConfig.widthMultiplier(context) * 13),
                    SizedBox(width: SizeConfig.widthMultiplier(context) * 2),
                  ],
                ),
              ),
            ),
            Container(
              height: SizeConfig.heightMultiplier(context) * 41,
              width: 1,
              color: _borderColor,
            ),
            Expanded(
              flex: 2,
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: _textEditingController,
                    onChanged: (value) {
                      ref
                          .read(phoneNumberProvider.notifier)
                          .update((state) => value);
                      _validatePhoneNumber(value);
                      setState(() {
                        phoneNumber = value;
                        if (!_hasError && widget.onSave != null) {
                          widget.onSave!(countryCode + phoneNumber);
                        }
                      });
                    },
                    keyboardType: TextInputType.phone,
                    style: AppFonts.body2(color: AppColors.grayscale90),
                    decoration: InputDecoration(
                      hintText: 'Enter Phone Number'.tr,
                      border: InputBorder.none,
                      hintStyle: AppFonts.body1(color: AppColors.grayscale50),
                      suffixIcon: phoneNumber.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  _clearText();
                                  phoneNumber = "";
                                });
                              },
                              child: Image.asset(
                                'assets/icons/frame/24px/20_Clear_form.png',
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterModalSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: DrawUpWidget(
            heading: 'Filter'.tr,
            content: Column(
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier(context) * 772,
                  child: const CountriesWidget(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//Example of use:

// Functions to be used in the example page:
// String? savedPhoneNumber;

// void savePhoneNumber(String phoneNumber) {
//   setState(() {
//     savedPhoneNumber = phoneNumber;
//   });
// }

//ExamplePage build:
// Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.9,
//               child: PhoneNumberField(
//                   label: 'Phone Number', onSave: savePhoneNumber),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               savedPhoneNumber != null
//                   ? 'Saved Phone Number: $savedPhoneNumber'
//                   : 'Phone number not saved yet',
//             ),
//           ],
//         ),
//       ),
