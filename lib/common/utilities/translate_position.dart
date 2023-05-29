import 'package:geocoding/geocoding.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class TranslatePosition {
  final String position;

  TranslatePosition({required this.position});

  Future<String> translatePos() async {
    // List<Placemark> placeMarks =
    //     await placemarkFromCoordinates(position.latitude, position.longitude);
    final pos = position.split('#');
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      double.parse(pos[0]),
      double.parse(pos[1]),
    );
    Placemark place = placeMarks[0];
    String result =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    return result;
  }
}
