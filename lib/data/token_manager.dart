import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'token_manager.g.dart';

@Riverpod(keepAlive: true)
TokenManager tokenManager(TokenManagerRef ref) {
  return TokenManager();
}

class TokenManager {
  static const String keyToken = 'TokenNoSecure';

  late FlutterSecureStorage _storage;

  TokenManager() {
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  Future<String?> read() async {
    String? token = await _storage.read(key: keyToken);
    debugPrint('Read Token: $token');
    return token;
  }

  Future<void> store(String token) async {
    debugPrint('Store Token: $token');
    return _storage.write(key: keyToken, value: token);
  }

  Future<String> delete() async {
    String? token = await read();
    if (token == null) return 'Token not exist';
    await _storage.delete(key: keyToken);
    return 'Token delete successfully';
  }
}
