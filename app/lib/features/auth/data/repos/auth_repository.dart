import 'package:app/core/logger/logger.dart';
import 'package:app/features/auth/data/data/user_data.dart';
import 'package:app/features/auth/data/models/user_login_req.dart';
import 'package:app/features/auth/data/models/user_register.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  AuthRepository({required Dio client, required UserData userData}) : _client = client, _userData = userData;

  final Dio _client;
  final UserData _userData;

  Future<String> login({required UserLoginReq request}) async {
    final result = await _client.post('http://146.103.118.137:8000', data: request.toJson());
    return result.data.toString();
  }

  Future<void> register({required UserRegister request}) async {
    try {
      final regResult = await _client.post('http://146.103.118.137:8000/auth/register', data: request.toJson());
      final logRequest = UserLoginReq(phoneNumber: request.phoneNumber, password: request.password);
      final logResult = await _client.post('http://146.103.118.137:8000/auth/login', data: logRequest.toJson());
      final loginData = logResult.data;

      if (loginData is Map<String, dynamic>) {
        final token = loginData['access_token'] as String?;
        if (token != null) {
          await _userData.saveToken(token);
        }

        final userJson = loginData['user'];
        if (userJson is Map<String, dynamic>) {
          final mappedUser = Map<String, dynamic>.from(userJson)..['password'] = request.password;
          await _userData.saveUser(UserRegister.fromJson(mappedUser));
        }
      }

      logger.d('Success: ${regResult.data}: ${logResult.data}');
    } on Exception catch (e) {
      logger.e('Gained error: $e');
    }
  }
}
