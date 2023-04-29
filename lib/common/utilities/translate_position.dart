import 'package:geocoding/geocoding.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class TranslatePosition {
  final ParseGeoPoint position;

  TranslatePosition({required this.position});

  Future<String> translatePos() async {
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placeMarks[0];
    String result =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    return result;
  }
}
