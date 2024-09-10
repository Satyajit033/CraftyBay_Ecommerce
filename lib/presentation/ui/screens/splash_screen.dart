import 'package:ecommerce_1/presentation/state_holders/auth_controller.dart';
import 'package:ecommerce_1/presentation/ui/screens/auth/email_verification_screen.dart';
import 'package:ecommerce_1/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:ecommerce_1/presentation/ui/utility/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToNextScreen();
    super.initState();
  }

  Future<void> goToNextScreen() async {
    await AuthController.getAccessToken();
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Get.offAll(() => AuthController.isLoggedIn
          ? const MainBottomNavScreen()
          : const EmailVerificationScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Center(
          child: SvgPicture.asset(
            ImageAssets.craftyBayLogoSVG,
            width: 100,
          ),
        ),
        const Spacer(),
        const CircularProgressIndicator(),
        const SizedBox(
          height: 16,
        ),
        const Text("Version 1.0"),
        const SizedBox(
          height: 30,
        ),
      ],
    ));
  }
}
