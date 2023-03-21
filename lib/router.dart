import 'package:flutter/material.dart';
import 'package:report_project/feature_1/auth/screens/login_register.dart';
import 'package:report_project/feature_1/splash/screens/splash_screen.dart';

import 'common/widgets/error_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case LoginRegisterScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const LoginRegisterScreen());
    default:
      return MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Not Found')),
          body: const ErrorScreen(text: 'This page does not exists'),
        );
      });
  }
}
