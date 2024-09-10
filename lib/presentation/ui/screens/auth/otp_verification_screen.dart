import 'package:ecommerce_1/presentation/state_holders/auth_state_holders/email_verification_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/auth_state_holders/otp_verification_controller.dart';
import 'package:ecommerce_1/presentation/state_holders/auth_state_holders/read_profile_controller.dart';
import 'package:ecommerce_1/presentation/ui/screens/auth/create_profile_screen.dart';
import 'package:ecommerce_1/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:ecommerce_1/presentation/ui/utility/color_palette.dart';
import 'package:ecommerce_1/presentation/ui/widgets/craftyBay_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final EmailVerificationController _emailVerificationController =
  Get.find<EmailVerificationController>();
  final OtpVerificationController _otpVerificationController =
  Get.find<OtpVerificationController>();
  final TextEditingController _otpTEController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _otpVerificationController.seconds = 120;
    _otpVerificationController.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Center(
                  child: CraftyBayLogo(),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Enter OTP Code',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text('A 6 digit OTP Code has been Sent',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey)),
                const SizedBox(
                  height: 24,
                ),
                PinCodeTextField(
                  controller: _otpTEController,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    activeColor: ColorPalette.primaryColor,
                    inactiveColor: ColorPalette.primaryColor,
                    selectedColor: Colors.green,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (v) {},
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<OtpVerificationController>(
                      builder: (otpController) {
                        if (otpController.otpVerificationInProgress) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ElevatedButton(
                          onPressed: () {
                            verifyOtp(otpController);
                          },
                          child: const Text('Next',style: TextStyle(color: Colors.white),),
                        );
                      }),
                ),
                const SizedBox(
                  height: 24,
                ),
                GetBuilder<OtpVerificationController>(
                    builder: (otpVerificationController) {
                      return Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.grey),
                              children: [
                                const TextSpan(text: 'This code will expire in '),
                                TextSpan(
                                  text: '${otpVerificationController.seconds}'
                                      's',
                                  style: TextStyle(
                                    color:
                                    otpVerificationController.seconds == 0
                                        ? Colors.grey
                                        : ColorPalette.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_otpVerificationController.seconds == 0) {
                                _emailVerificationController
                                    .verifyEmail(widget.email);
                                _otpVerificationController.seconds = 120;
                                _otpVerificationController.startTimer();
                              }
                            },
                            style: TextButton.styleFrom(
                              foregroundColor:
                              _otpVerificationController.seconds == 0
                                  ? ColorPalette.primaryColor
                                  : Colors.grey,
                            ),
                            child: const Text('Resend Code'),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyOtp(OtpVerificationController controller) async {
    final response =
    await controller.verifyOTP(widget.email, _otpTEController.text.trim());
    if (response) {
      Get.snackbar('Success', 'OTP verification successful.',
          backgroundColor: ColorPalette.primaryColor,
          colorText: Colors.white,
          borderRadius: 10,
          snackPosition: SnackPosition.BOTTOM);
      await Get.find<ReadProfileController>().readProfileData();

      Get.find<ReadProfileController>().readProfileModel.data == null
          ? Get.offAll(() => CreateProfileScreen())
          : Get.offAll(() => const MainBottomNavScreen());
    } else {
      Get.snackbar('Failed', 'Otp verification failed! Try again',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
          snackPosition: SnackPosition.BOTTOM);
      _otpTEController.clear();
      controller.timer.cancel();
    }
  }
}
