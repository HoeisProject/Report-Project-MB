import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/feature_1/splash/screens/splash_screen.dart';
import 'package:report_project/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const ProviderScope(
      child: MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Report Project',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
