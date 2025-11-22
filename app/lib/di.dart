import 'package:app/core/network/dio_module.dart';
import 'package:app/features/auth/data/data/user_data.dart';
import 'package:app/features/auth/data/repos/auth_repository.dart';
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
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(client: dio, userData: getIt<UserData>()));
  configureDependencies();
}
