import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminProjectCreateStartDateProvider =
    StateProvider.autoDispose<DateTime?>((ref) => null);

final adminProjectCreateEndDateProvider =
    StateProvider.autoDispose<DateTime?>((ref) => null);

final adminProjectCreateIsLoadingProvider =
    StateProvider.autoDispose<bool>((ref) => false);
