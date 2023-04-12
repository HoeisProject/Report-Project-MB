import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/common/styles/theme.dart';

final switchThemeProvider =
    StateProvider<AppTheme>((ref) => AppTheme.lightTheme);

final appThemeProvider = StateProvider<ThemeData>((ref) {
  final switchTheme = ref.watch(switchThemeProvider);
  if (switchTheme == AppTheme.darkTheme) {
    return AppThemes.appThemeData[AppTheme.darkTheme]!;
  }
  return AppThemes.appThemeData[AppTheme.lightTheme]!;
});
