import 'package:flutter_riverpod/flutter_riverpod.dart';

final switchImageFullFuncProvider = StateProvider((ref) => 0);

final reportDetailListMediaFilePathProvider = StateProvider((ref) => [""]);

final imageDownloadProgressProvider = StateProvider((ref) => 0.0);

final imageDownloadTextProvider = StateProvider((ref) => "");
