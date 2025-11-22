import 'package:app/features/auth/data/data/user_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UserData', () {
    late UserData userData;
    late FlutterSecureStorage storage;

    setUp(() {
      // Use the in-memory implementation for testing
      FlutterSecureStorage.setMockInitialValues({});
      storage = const FlutterSecureStorage();
      userData = UserData(storage);
    });

    test('saveToken stores the token', () async {
      await userData.saveToken('test_token');
      final token = await storage.read(key: 'jwt_token');
      expect(token, 'test_token');
    });

    test('getToken retrieves the token', () async {
      await storage.write(key: 'jwt_token', value: 'stored_token');
      final token = await userData.getToken();
      expect(token, 'stored_token');
    });

    test('deleteToken removes the token', () async {
      await storage.write(key: 'jwt_token', value: 'to_delete');
      await userData.deleteToken();
      final token = await storage.read(key: 'jwt_token');
      expect(token, isNull);
    });
  });
}
