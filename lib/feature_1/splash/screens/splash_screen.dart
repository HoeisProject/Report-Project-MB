import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/feature_1/admin/screens/admin_home.dart';
import 'package:report_project/feature_1/auth/screens/login_register.dart';
import 'package:report_project/feature_1/auth/services/profile_service.dart';
import 'package:report_project/feature_1/employee/screens/employee_home.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const routeName = '/splash_screen';

  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    requestPermission(context);
  }

  void requestPermission(context) async {
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
      Map<Permission, PermissionStatus> _ = await [
        Permission.location,
        Permission.storage,
        Permission.camera,
        Permission.microphone,
      ].request();

      Timer(const Duration(seconds: 2), () async {
        final parseUser =
            await ref.read(profileServiceProvider).getCurrentUser();
        if (parseUser == null) {
          Navigator.popAndPushNamed(context, LoginRegisterScreen.routeName);
        }
        final user = UserModel.fromParseUser(parseUser!);
        if (user.role == 'admin') {
          Navigator.popAndPushNamed(context, AdminHome.routeName);
        }
        Navigator.popAndPushNamed(context, HomeEmployee.routeName);
      });
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
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                width: 200.0,
                height: 200.0,
                child: Image.asset(
                  "assets/images/app_ic_launch.png",
                ),
              ),
            ),
            const Text('from',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14.0,
                )),
            const Text(
              "HOEI's",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
