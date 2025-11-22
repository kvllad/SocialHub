import 'package:app/core/network/dio_module.dart';

class AuthRepository {
  AuthRepository({required DioModule client}) : _client = client;

  final DioModule _client;

  void authorize() {
    final result;
  }
}
