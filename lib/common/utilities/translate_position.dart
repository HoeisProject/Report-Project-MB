import 'package:geocoding/geocoding.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translate_position.g.dart';

@riverpod
FutureOr<String> translatePosition(
  TranslatePositionRef ref, {
  required String position,
}) async {
  // List<Placemark> placeMarks =
  //     await placemarkFromCoordinates(position.latitude, position.longitude);
  final pos = position.split('#');
  try {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      double.parse(pos[0]),
      double.parse(pos[1]),
    );
    Placemark place = placeMarks[0];
    String result =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    return result;
  } catch (e) {
    return 'Not a valid address';
  }
}
