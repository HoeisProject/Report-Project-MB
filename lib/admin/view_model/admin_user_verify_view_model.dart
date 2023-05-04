import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminUserVerifyIsLoadingProvider =
    StateProvider.autoDispose<bool>((ref) => false);
