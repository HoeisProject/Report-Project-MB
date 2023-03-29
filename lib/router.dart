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
    case UserProfilePage.routeName:
      return MaterialPageRoute(builder: (context) => const UserProfilePage());
    case HomeEmployee.routeName:
      return MaterialPageRoute(builder: (context) => const HomeEmployee());
    case ReportCreate.routeName:
      return MaterialPageRoute(builder: (context) => const ReportCreate());
    case ReportDetail.routeName:
      return MaterialPageRoute(builder: (context) => const ReportDetail());
    case AdminHome.routeName:
      return MaterialPageRoute(builder: (context) => const AdminHome());
    case AdminDetailReport.routeName:
      final arguments = routeSettings.arguments as Map<String, dynamic>;
      final reportObject = arguments['reportObject'];
      return MaterialPageRoute(
          builder: (context) => AdminDetailReport(
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
