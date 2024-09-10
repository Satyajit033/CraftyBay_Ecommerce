import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_1/application/state_holder_binder.dart';
import 'package:ecommerce_1/presentation/state_holders/theme_manager_controller.dart';
import 'package:ecommerce_1/presentation/ui/screens/splash_screen.dart';
import 'package:ecommerce_1/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CraftyBay extends StatefulWidget {

 static GlobalKey<NavigatorState>globalKey = GlobalKey<NavigatorState>();

 const CraftyBay({super.key});

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {

  late final StreamSubscription _connectivityStatusStream;
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    checkInitialInternetConnection();
    checkInternetConnectivityStatus();
    ThemeManager.getThemeMode().then((themeMode) {
      if (themeMode == ThemeMode.system) {
        ThemeManager.setThemeMode(ThemeMode.light);
      }
      _themeMode = themeMode;
    });
    super.initState();
  }

  void checkInitialInternetConnection() async {
    final result = await Connectivity().checkConnectivity();
    handleConnectivityStates(result);
  }

  void checkInternetConnectivityStatus() {
    _connectivityStatusStream = Connectivity().onConnectivityChanged.listen((status) {
      handleConnectivityStates(status);
    });
  }

  void handleConnectivityStates(List<ConnectivityResult> status) {
    if (status != ConnectivityResult.mobile &&
        status != ConnectivityResult.wifi) {
      Get.defaultDialog(
        title: "No Internet",
        middleText: "Please check your internet connection.",
        barrierDismissible: false,
        titleStyle: const TextStyle(color: Colors.red),
      );
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: CraftyBay.globalKey,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: StateHolderBinder(),
      themeMode: _themeMode,
      theme: ThemeData(
          primarySwatch: MaterialColor(
              ColorPalette.primaryColor.value, ColorPalette().color),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: ColorPalette.primaryColor,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorPalette.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 13),
            textStyle: const TextStyle(
              fontSize: 16, letterSpacing: 0.5, fontWeight: FontWeight.w500,),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          )
      ),
          inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide:
                  BorderSide(color: ColorPalette.primaryColor, width: 2.5),
            ),
          )

      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: MaterialColor(
              ColorPalette.primaryColor.value, ColorPalette().color),
          //primaryC
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: ColorPalette.primaryColor,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPalette.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 13),
                textStyle: const TextStyle(
                  fontSize: 16, letterSpacing: 0.5, fontWeight: FontWeight.w500,),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              )
          ),
          inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide:
              BorderSide(color: ColorPalette.primaryColor, width: 2.5),
            ),
          )
      ),
    );
  }

  @override
  void dispose() {
    _connectivityStatusStream.cancel();
    super.dispose();
  }
}

