import 'package:flutter/material.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../../../data/countries_data.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/fonts/fonts.dart';
import '../../lists/countries_widget/countries_widget.dart';
import '../draw_ups/draw_up_widget.dart';

class PhoneNumberField extends StatefulWidget {
  final String? label;
  final Function(String)? onSave;

  const PhoneNumberField({
    Key? key,
    this.label,
    this.onSave,
  }) : super(key: key);

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  String countryCode = "+966";
  String countryFlag = "assets/icons/flags/Country=SA.png";
  String phoneNumber = "";
  Color _borderColor = AppColors.grayscale20;
  Color _backgroundColor = AppColors.grayscale0;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
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

  void _onCountrySelected(CountryInfo countryInfo) {
    setState(
      () {
        selectedCountry = countryInfo;
        countryCode = countryInfo.countryCode;
        countryFlag = countryInfo.flagImagePath;
      },
    );
    Navigator.pop(context);
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
                "Phone numbers can't have text",
                style: AppFonts.caption2(color: AppColors.error100),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberField() {
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
                    SizedBox(width: globals.widthMediaQuery * 9),
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
                        size: globals.widthMediaQuery * 13),
                    SizedBox(width: globals.widthMediaQuery * 2),
                  ],
                ),
              ),
            ),
            Container(
              height: globals.heightMediaQuery * 41,
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
                      hintText: "Enter phone number",
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
          child: DrowupWidget(
            heading: 'Filter',
            content: Column(
              children: [
                SizedBox(
                  height: globals.heightMediaQuery * 772,
                  child: CountriesWidget(
                    onCountrySelected: _onCountrySelected,
                  ),
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