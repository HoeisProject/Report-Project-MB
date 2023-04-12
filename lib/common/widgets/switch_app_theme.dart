import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/common/controller/theme_controller.dart';
import 'package:report_project/common/styles/theme.dart';
import 'package:report_project/common/utilities/utility.dart';

Widget switchAppTheme(
  BuildContext context,
  WidgetRef ref,
) {
  final appTheme = ref.watch(switchThemeProvider);
  return ListTile(
    leading: appTheme == AppTheme.lightTheme
        ? const Icon(Icons.light_mode)
        : const Icon(Icons.dark_mode),
    title: appTheme == AppTheme.lightTheme
        ? const Text("Light Theme")
        : const Text("Dark Theme"),
    onTap: () {
      if (appTheme == AppTheme.lightTheme) {
        ref.read(switchThemeProvider.notifier).state = AppTheme.darkTheme;
        Utility.saveTheme(AppTheme.darkTheme);
      } else {
        ref.read(switchThemeProvider.notifier).state = AppTheme.lightTheme;
        Utility.saveTheme(AppTheme.lightTheme);
      }
    },
    trailing: Switch(
        value: appTheme == AppTheme.lightTheme ? false : true,
        onChanged: (value) {
          if (appTheme == AppTheme.lightTheme) {
            ref.read(switchThemeProvider.notifier).state = AppTheme.darkTheme;
            Utility.saveTheme(AppTheme.darkTheme);
          } else {
            ref.read(switchThemeProvider.notifier).state = AppTheme.lightTheme;
            Utility.saveTheme(AppTheme.lightTheme);
          }
        }),
  );
}
