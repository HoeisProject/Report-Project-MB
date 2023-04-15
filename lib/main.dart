import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/common/controller/theme_controller.dart';
import 'package:report_project/common/services/back4app_config.dart';
import 'package:report_project/splash/screens/splash_screen.dart';
import 'package:report_project/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Back4appConfig.initialize();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // ref.read(switchThemeProvider.notifier).state = Utility.getTheme()!;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return MaterialApp(
      title: 'Report Project',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: theme,
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
