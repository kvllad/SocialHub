import 'package:app/core/network/dio_module.dart';
import 'package:app/core/router/router.dart';
import 'package:app/features/auth/data/data/user_data.dart';
import 'package:app/features/auth/data/repos/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getIt.init();

void registerDI() {
  configureDependencies();
  final userData = getIt<UserData>();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await userData.getToken();
        if (token != null && token.isNotEmpty) {
          options.queryParameters = <String, dynamic>{
            ...options.queryParameters,
            'token': token,
          };
        }
        handler.next(options);
      },
      onError: (error, handler) {
        final status = error.response?.statusCode ?? 0;
        if (status == 401 || status == 403) {
          router.go('/register');
        }
        handler.next(error);
      },
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(client: dio, userData: userData));
}
