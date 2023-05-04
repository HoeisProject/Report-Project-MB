import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Back4appConfig {
  // testing database
  static const keyApplicationId = "74mBYHxzcNprmHfUGAUqFaO8xneKAlT49PSGpmeY";
  static const clientKey = "Z8h6cpPweXpSy4k92bdui8QIrdzB3TFi6DgENrKR";
  static const masterKey = 'KdguyIKFGBydQTHafXKr0p4SAImWrPK5bCfM3VO6';
  static const keyParseServerUrl = "https://parseapi.back4app.com/";

  static Future<Parse> initialize() async {
    return Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      debug: true,
      clientKey: clientKey,
      coreStore: await CoreStoreSharedPrefsImp.getInstance(),
      masterKey: masterKey,
    );
  }
}
