import 'package:app/core/logger/logger.dart';
import 'package:app/di.dart';
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

      final regResult = await _client.post('http://146.103.118.137:8000/register', data: request.toJson());
      final logRequest = UserLoginReq(phoneNumber: request.phoneNumber, password: request.password);
      final logResult = await _client.post('http://146.103.118.137:8000/login', data: logRequest.toJson());
      await _userData.saveToken(logResult.data.toString());
      logger.d('Success: ${regResult}: $logResult');
    } on Exception catch (e) {
      logger.e('Gained error: $e');
    }
  }
}
