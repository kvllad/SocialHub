import 'dart:convert';
import 'package:app/features/auth/data/models/user_register.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserData {
  const UserData([this._storage = const FlutterSecureStorage()]);

  final FlutterSecureStorage _storage;
  static const _tokenKey = 'jwt_token';

  static const _userKey = 'user_data';

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<void> saveUser(UserRegister user) async {
    await _storage.write(key: _userKey, value: jsonEncode(user.toJson()));
  }

  Future<UserRegister?> getUser() async {
    final userStr = await _storage.read(key: _userKey);
    if (userStr == null) return null;
    return UserRegister.fromJson(jsonDecode(userStr));
  }
}
