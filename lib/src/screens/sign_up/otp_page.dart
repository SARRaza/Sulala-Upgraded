import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sulala_app/src/data/globals.dart' as globals;
import '../../theme/colors/colors.dart';
import '../../theme/fonts/fonts.dart';
import '../../widgets/controls_and_buttons/buttons/primary_button.dart';
import '../../widgets/controls_and_buttons/text_buttons/primary_textbutton.dart';
import '../../widgets/inputs/otp_fields/otp_field.dart';

class OTPPage extends StatefulWidget {
  final String? phoneNumber;
  final String? emailAddress;

  const OTPPage({
    Key? key,
    this.phoneNumber,
    this.emailAddress,
  }) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

PrimaryButtonStatus buttonStatus = PrimaryButtonStatus.idle;
TextStatus textStatus = TextStatus.idle;

class _OTPPageState extends State<OTPPage> {
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
            "Enter Code",
            style: AppFonts.title2(color: AppColors.grayscale90),
          ),
          SizedBox(
            height: globals.heightMediaQuery * 7,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: widget.phoneNumber != null
                      ? "We sent a verification code on the following\nPhone number: "
                      : "We sent a verification code on the following\nEmail address: ",
                  style: AppFonts.body2(color: AppColors.grayscale70),
                ),
                TextSpan(
                  text: widget.phoneNumber != null
                      ? widget.phoneNumber!
                      : widget.emailAddress,
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
                    "Invalid verification code.",
                    style: AppFonts.caption2(color: AppColors.error100),
                  ),
                  Text(
                    "Please, check the code or resend it again",
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
      text: "Send new code",
      status: textStatus,
    );
  }

  Widget _buildCountdown() {
    return Text(
      "Send new code in: 00:${_remainingSeconds.toString().padLeft(2, '0')}",
      style: AppFonts.body1(color: AppColors.grayscale90),
    );
  }

  Widget _buildConfirmButton(
      PrimaryButtonStatus status, VoidCallback onPressed) {
    return SizedBox(
      height: globals.heightMediaQuery * 52,
      width: globals.widthMediaQuery * 343,
      child: PrimaryButton(
        text: "Confirm",
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
        builder: (context) => OTPPage(
          phoneNumber: widget.phoneNumber,
        ),
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
