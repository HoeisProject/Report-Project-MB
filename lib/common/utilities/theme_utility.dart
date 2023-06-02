// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:report_project/common/styles/theme.dart';

part 'theme_utility.g.dart';

@Riverpod(keepAlive: true)
Future<ThemeUtility> themeUtility(ThemeUtilityRef ref) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return ThemeUtility(preferences: preferences);
}

class ThemeUtility {
  final SharedPreferences preferences;

  ThemeUtility({
    required this.preferences,
  });

  static const String keySelectedTheme = 'keySelectedTheme';

  Future<bool> saveTheme(AppTheme selectedTheme) async {
    String theme = jsonEncode(selectedTheme.toString());
    return preferences.setString(keySelectedTheme, theme);
  }

  AppTheme? getTheme() {
    String? theme = preferences.getString(keySelectedTheme);
    if (theme == null) {
      return AppTheme.lightTheme;
    }
    return getThemeFromString(jsonDecode(theme));
  }

  AppTheme? getThemeFromString(String themeString) {
    for (AppTheme theme in AppTheme.values) {
      if (theme.toString() == themeString) {
        return theme;
      }
    }
    return null;
  }
}
