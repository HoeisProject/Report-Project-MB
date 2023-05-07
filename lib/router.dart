import 'package:flutter/material.dart';
import 'package:report_project/admin/screens/admin_report_detail.dart';
import 'package:report_project/admin/screens/admin_project_detail.dart';
import 'package:report_project/admin/screens/admin_report_rejected.dart';
import 'package:report_project/admin/screens/admin_user_home.dart';
import 'package:report_project/admin/screens/admin_home.dart';
import 'package:report_project/admin/screens/admin_project_create.dart';
import 'package:report_project/admin/screens/admin_project_home.dart';
import 'package:report_project/admin/screens/admin_user_verify.dart';
import 'package:report_project/auth/screens/login_register.dart';
import 'package:report_project/auth/screens/user_profile.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/employee/screens/create_report.dart';
import 'package:report_project/employee/screens/detail_report.dart';
import 'package:report_project/employee/screens/employee_home.dart';
import 'package:report_project/splash/screens/splash_screen.dart';

import 'common/widgets/error_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    /// AUTH
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
    /// Project
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
          builder: (context) => AdminProjectDetail(project: project));

    /// User
    case AdminUserHomeScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const AdminUserHomeScreen());
    case AdminUserVerifyScreen.routeName:
      final user = routeSettings.arguments as UserModel;
      return MaterialPageRoute(
        builder: (context) => AdminUserVerifyScreen(user: user),
      );

    /// Report
    case AdminReportDetailScreen.routeName:
      final report = routeSettings.arguments as ReportModel;
      return MaterialPageRoute(
          builder: (context) => AdminReportDetailScreen(report: report));
    case AdminReportRejectedScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const AdminReportRejectedScreen());

    /// Other
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
