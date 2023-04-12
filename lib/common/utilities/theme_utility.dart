// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:report_project/common/styles/theme.dart';

part 'theme_utility.g.dart';

@riverpod
Future<ThemeUtility> themeUtility(ThemeUtilityRef ref) async {
  final preferences = await SharedPreferences.getInstance();
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
    if (null == theme) {
      return AppTheme.darkTheme;
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
