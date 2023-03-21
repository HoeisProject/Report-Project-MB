import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Back4appService {
  // testing database
  final String keyApplicationId = "74mBYHxzcNprmHfUGAUqFaO8xneKAlT49PSGpmeY";
  final String clientKey = "Z8h6cpPweXpSy4k92bdui8QIrdzB3TFi6DgENrKR";
  final String keyParseServerUrl = "https://parseapi.back4app.com/";

  Future<Parse> initialize() async {
    return Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      debug: true,
      clientKey: clientKey,
      coreStore: await CoreStoreSharedPrefsImp.getInstance(),
    );
  }
}
