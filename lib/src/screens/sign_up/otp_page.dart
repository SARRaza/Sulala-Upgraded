import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sulala_upgrade/src/data/globals.dart' as globals;
import '../../data/riverpod_globals.dart';
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/otp_fields/otp_field.dart';

class OTPPage extends ConsumerStatefulWidget {
  // final String? phoneNumber;
  // final String? emailAddress;

  const OTPPage({
    Key? key,
    // this.phoneNumber,
    // this.emailAddress,
  }) : super(key: key);

  @override
  ConsumerState<OTPPage> createState() => _OTPPageState();
}

PrimaryButtonStatus buttonStatus = PrimaryButtonStatus.idle;
TextStatus textStatus = TextStatus.idle;

class _OTPPageState extends ConsumerState<OTPPage> {
  late int _remainingSeconds;
  late Timer _timer;
  bool isResendButtonVisible = false;
  bool otpErrorState = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = 10; // Set initial time
    _startTimer();
  }

  void onOTPFilled(String otp) {
    // Handle OTP filled logic
    _timer.cancel(); // Stop the timer
    setState(() {
      buttonStatus = PrimaryButtonStatus.idle; // Set the button status
    });
  }

  bool isOTPError(String otp) {
    // Dummy error check: Consider OTP "123456" as the correct OTP
    const correctOTP = '123456';
    return otp != correctOTP;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel();
          isResendButtonVisible = true;
        }
      });
    });
  }

  void _resetTimer() {
    _timer.cancel();
    _remainingSeconds = 10;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.grayscale90,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: _buildContent(),
        floatingActionButton: SizedBox(
          height: globals.heightMediaQuery * 122,
          child: Column(
            children: [
              if (isResendButtonVisible) _buildResendButton(),
              if (!isResendButtonVisible) _buildCountdown(),
              SizedBox(
                height: globals.heightMediaQuery * 16,
              ),
              if (isResendButtonVisible)
                _buildConfirmButton(PrimaryButtonStatus.disabled, () {}),
              if (!isResendButtonVisible)
                _buildConfirmButton(buttonStatus, _onConfirmButtonPressed),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _buildContent() {
    final phoneNumber = ref.watch(phoneNumberProvider);
    final email = ref.watch(emailAdressProvider);
    final countryCode = ref.watch(selectedCountryCodeProvider);
    return Padding(
      padding: EdgeInsets.only(
        left: globals.widthMediaQuery * 19,
        right: globals.widthMediaQuery * 19,
        top: globals.heightMediaQuery * 41,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter Code".tr,
            style: AppFonts.title2(color: AppColors.grayscale90),
          ),
          SizedBox(
            height: globals.heightMediaQuery * 7,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: phoneNumber.isNotEmpty
                      ? "We sent a verification code on the following\nPhone number: "
                          .tr
                      : "We sent a verification code on the following\nEmail address: "
                          .tr,
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
                TextSpan(
                  text: phoneNumber.isNotEmpty ? countryCode : countryCode,
                  style: AppFonts.body2(color: AppColors.primary50),
                ),
                TextSpan(
                  text: phoneNumber.isNotEmpty ? phoneNumber : email,
                  style: AppFonts.body2(color: AppColors.primary50),
                ),
              ],
            ),
          ),
          SizedBox(
            height: globals.heightMediaQuery * 41,
          ),
          SizedBox(
            width: globals.widthMediaQuery * 337,
            child: OTPField(
              onFilled: onOTPFilled,
              onError: isOTPError,
              onErrorChange: (error) {
                setState(() {
                  otpErrorState = error;
                });
              },
            ),
          ),
          SizedBox(
            height: globals.heightMediaQuery * 24,
          ),
          if (otpErrorState)
            Center(
              child: Column(
                children: [
                  Text(
                    "Invalid verification code.".tr,
                    style: AppFonts.caption2(color: AppColors.error100),
                  ),
                  Text(
                    "Please, check the code or resend it again".tr,
                    style: AppFonts.caption2(color: AppColors.error100),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResendButton() {
    return PrimaryTextButton(
      onPressed: _onResendButtonPressed,
      text: "Send New Code".tr,
      status: textStatus,
    );
  }

  Widget _buildCountdown() {
    return Text(
      "Send New Code in: 00:${_remainingSeconds.toString().padLeft(2, '0')}".tr,
      style: AppFonts.body1(color: AppColors.grayscale90),
    );
  }

  Widget _buildConfirmButton(
      PrimaryButtonStatus status, VoidCallback onPressed) {
    return SizedBox(
      height: globals.heightMediaQuery * 52,
      width: globals.widthMediaQuery * 343,
      child: PrimaryButton(
        text: "Confirm".tr,
        status: status,
        onPressed: onPressed,
      ),
    );
  }

  void _onResendButtonPressed() {
    setState(() {
      _resetTimer();
      isResendButtonVisible = false;
      buttonStatus = PrimaryButtonStatus.idle;
      otpErrorState = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const OTPPage(),
      ),
    );
  }

  void _onConfirmButtonPressed() {
    if (otpErrorState) {
      setState(() {
        buttonStatus = PrimaryButtonStatus.disabled;
        isResendButtonVisible = true;
      });
    } else {
      setState(() {
        buttonStatus = PrimaryButtonStatus.loading;
        Navigator.of(context).pushNamed('/create_password');
      });
    }
  }
}
