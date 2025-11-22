import 'package:app/features/auth/data/models/user_login_req.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  AuthRepository({required Dio client}) : _client = client;

  final Dio _client;

  Future<String> login({required UserLoginReq request}) async {
    final result = await _client.post('http://146.103.118.137:8000', data: request.toJson());
    return result.data.toString();
  }

  void logout() {}
}
