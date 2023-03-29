import 'package:flutter/material.dart';
import 'package:report_project/admin/screens/admin_detail_report.dart';
import 'package:report_project/admin/screens/admin_home.dart';
import 'package:report_project/auth/screens/login_register.dart';
import 'package:report_project/auth/screens/user_profile.dart';
import 'package:report_project/employee/screens/create_report.dart';
import 'package:report_project/employee/screens/detail_report.dart';
import 'package:report_project/employee/screens/employee_home.dart';
import 'package:report_project/splash/screens/splash_screen.dart';

import 'common/widgets/error_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case LoginRegisterScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const LoginRegisterScreen());
    case UserProfileScreen.routeName:
      return MaterialPageRoute(builder: (context) => const UserProfileScreen());
    case HomeEmployee.routeName:
      return MaterialPageRoute(builder: (context) => const HomeEmployee());
    case CreateReportScreen.routeName:
      return MaterialPageRoute(builder: (context) => const CreateReportScreen());
    case DetailReportScreen.routeName:
      return MaterialPageRoute(builder: (context) => const DetailReportScreen());
    case AdminHomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => const AdminHomeScreen());
    case AdminDetailReportScreen.routeName:
      final arguments = routeSettings.arguments as Map<String, dynamic>;
      final reportObject = arguments['reportObject'];
      return MaterialPageRoute(
          builder: (context) => AdminDetailReportScreen(
                reportObject: reportObject ?? "",
              ));
    default:
      return MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Page Not Found'),
            centerTitle: true,
          ),
          body: const ErrorScreen(text: 'This page does not exists'),
        );
      });
  }
}
