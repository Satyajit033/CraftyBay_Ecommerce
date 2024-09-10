import 'package:ecommerce_1/presentation/state_holders/auth_state_holders/email_verification_controller.dart';
import 'package:ecommerce_1/presentation/ui/screens/auth/otp_verification_screen.dart';
import 'package:ecommerce_1/presentation/ui/utility/color_palette.dart';
import 'package:ecommerce_1/presentation/ui/utility/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 90,
                ),
                Center(
                  child: SvgPicture.asset(
                    ImageAssets.craftyBayLogoSVG,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Welcome Back",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 27, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text("Please Enter Your Email Address",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey)),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _emailTEController,
                  cursorColor: ColorPalette.primaryColor,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email Address',
                  ),
                  validator: (String? text) {
                    if (text?.isEmpty ?? true) {
                      return 'Enter your email address';
                    } else if (text!.isEmail == false) {
                      /// REGEX (Email validator)
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: double.infinity,
                    child: GetBuilder<EmailVerificationController>(
                        builder: (controller) {
                      if (controller.emailVerificationInProgress) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            verifyEmail(controller);
                          }
                        },
                        child: const Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }))
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void>verifyEmail(EmailVerificationController controller)async{
    final response = await controller.verifyEmail(_emailTEController.text.trim());
    if (response) {
      Get.to(() =>  OTPVerificationScreen(
          email: _emailTEController.text.trim(),
        ),
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    "Email Verification failed! Try Again")));
      }
    }
  }
}
