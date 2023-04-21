import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountVerifyLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final accountVerifyMediaFileProvider = StateProvider.autoDispose<File?>((ref) {
  return null;
});
