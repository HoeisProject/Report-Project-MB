import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:report_project/admin/screens/admin_home.dart';
import 'package:report_project/auth/controllers/profile_controller.dart';
import 'package:report_project/auth/screens/login_register.dart';
import 'package:report_project/common/controller/theme_controller.dart';
import 'package:report_project/common/utilities/theme_utility.dart';
import 'package:report_project/common/widgets/error_screen.dart';
import 'package:report_project/employee/screens/employee_home.dart';

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
    _loadTheme();
    _requestPermission(context);
  }

  void _loadTheme() {
    final themeUtility = ref.read(themeUtilityProvider);
    debugPrint('theme in');
    // ref.read(switchThemeProvider.notifier).state =
    //     themeUtility.value!.getTheme()!;
    themeUtility.when(
        data: (data) {
          debugPrint('theme : $data');
          ref.read(switchThemeProvider.notifier).state = data.getTheme()!;
        },
        error: (error, trace) => debugPrint('Error : $error'),
        loading: () {});
  }

  void _requestPermission(context) async {
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
    debugPrint("Splash Screen");
    final currentUser = ref.watch(profileControllerProvider);
    ref.listen(profileControllerProvider, (previous, next) {
      debugPrint("Splash Screen - ref listen profileControllerProvider");
      if (!next.hasValue || next.value == null) {
        Navigator.popAndPushNamed(context, LoginRegisterScreen.routeName);
        return;
      }
      Timer(const Duration(seconds: 2), () {
        if (next.value!.role == 'admin') {
          Navigator.popAndPushNamed(context, AdminHomeScreen.routeName);
        } else if (next.value!.role == 'employee') {
          Navigator.popAndPushNamed(context, EmployeeHomeScreen.routeName);
        }
      });
    });
    return Scaffold(
      body: currentUser.when(
        data: (user) {
          debugPrint(user.toString());
          return _splashWidget();
        },
        error: (error, stackTrace) {
          // Asumsikan aja server back4apps meledak / kena meteor ??
          return const ErrorScreen(text: 'Splash Screen - Call Developer');
        },
        loading: () {
          return _splashWidget();
        },
      ),
    );
  }

  Widget _splashWidget() {
    return SizedBox(
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
    );
  }
}
