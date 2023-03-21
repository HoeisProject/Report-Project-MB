import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:report_project/feature_1/auth/screens/login_register.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.location.isPermanentlyDenied) {
        Permission.location.request();
      }
      if (await Permission.storage.isPermanentlyDenied) {
        Permission.storage.request();
      }
      if (await Permission.camera.isPermanentlyDenied) {
        Permission.camera.request();
      }
      if (await Permission.microphone.isPermanentlyDenied) {
        Permission.microphone.request();
      }
      Map<Permission, PermissionStatus> reqPermission = await [
        Permission.location,
        Permission.storage,
        Permission.camera,
        Permission.microphone,
      ].request();

      Timer(
          const Duration(seconds: 2),
          () => Navigator.popAndPushNamed(
              context, LoginRegisterScreen.routeName));
    }
    // else if (Platform.isIOS) {
    //   Map<Permission, PermissionStatus> reqPermission = await [
    //     Permission.location,
    //     Permission.photos,
    //     Permission.camera,
    //     Permission.microphone,
    //   ].request();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200.0,
          height: 200.0,
          child: Image.asset(
            "assets/images/app_ic_launch.png",
          ),
        ),
      ),
    );
  }
}
