import 'package:flutter/material.dart';
import 'package:report_project/admin/screens/admin_detail_report.dart';
import 'package:report_project/admin/screens/admin_project_detail.dart';
import 'package:report_project/admin/screens/admin_user_home.dart';
import 'package:report_project/admin/screens/admin_home.dart';
import 'package:report_project/admin/screens/admin_project_create.dart';
import 'package:report_project/admin/screens/admin_project_home.dart';
import 'package:report_project/auth/screens/login_register.dart';
import 'package:report_project/auth/screens/user_profile.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:report_project/common/models/report_model.dart';
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

    /// EMPLOYEE
    case EmployeeHomeScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const EmployeeHomeScreen());
    case CreateReportScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const CreateReportScreen());
    case DetailReportScreen.routeName:
      final report = routeSettings.arguments as ReportModel;
      return MaterialPageRoute(
          builder: (context) => DetailReportScreen(report: report));

    /// ADMIN
    case AdminHomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => const AdminHomeScreen());
    case AdminProjectHomeScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const AdminProjectHomeScreen());
    case AdminProjectCreateScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const AdminProjectCreateScreen());
    case AdminProjectDetail.routeName:
      final project = routeSettings.arguments as ProjectModel;
      return MaterialPageRoute(
          builder: (context) => AdminProjectDetail(
                project: project,
              ));
    case AdminUserHomeScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const AdminUserHomeScreen());
    case AdminDetailReportScreen.routeName:
      final report = routeSettings.arguments as ReportModel;
      return MaterialPageRoute(
          builder: (context) => AdminDetailReportScreen(report: report));
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
