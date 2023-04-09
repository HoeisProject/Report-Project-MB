import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/common/models/user_model.dart';

final loginRegisterLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final loginRegisterIsLoginProvider = StateProvider.autoDispose<bool>((ref) {
  return true;
});

final loginRegisterLoginColorProvider = StateProvider.autoDispose<Color>((ref) {
  return Colors.black;
});

final loginRegisterRegisterColorProvider =
    StateProvider.autoDispose<Color>((ref) {
  return Colors.lightBlue;
});

final loginRegisterIsAdminProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final loginRegisterRoleProvider = StateProvider.autoDispose<String>((ref) {
  return UserRoleEnum.employee.name;
});

final loginRegisterMediaFileProvider = StateProvider.autoDispose<File?>((ref) {
  return null;
});
