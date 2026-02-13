import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpodfuckaround/features/auth/domain/interfaces/auth_repository_interface.dart';

import 'app/controllers/auth_controller.dart';
import 'app/data/app_data.dart';
import 'core/constants/keys.dart';
import 'core/helpers/api_service.dart';
import 'core/helpers/app_overlays_helper.dart';
import 'core/helpers/go_router_helper.dart';
import 'core/helpers/logger_service.dart';
import 'core/helpers/shared_preferences_helper.dart';
import 'core/interfaces/base_config.dart';
import 'core/interfaces/base_key_value_store.dart';
import 'core/interfaces/base_navigation_service.dart';
import 'core/interfaces/base_overlays_helper.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/persons/controllers/passenger_details_controller.dart';
import 'features/persons/controllers/passengers_controller.dart';
import 'features/persons/domain/interfaces/persons_repository_interface.dart';
import 'features/persons/domain/repositories/persons_details_repository.dart';

GetIt locator = GetIt.instance;

final sessionStorage = locator<BaseKeyValueStore>(instanceName: Keys.sessionStorageInstance);

LoggerService registerLoggerService() {
  return locator.registerSingleton(LoggerService());
}

/// Key-value storages
Future<void> initializeStorages() {
  return registerStorage(locator);
}

void initializeDependencies() {
  /// Navigator Service
  locator.registerSingleton<BaseNavigationService>(GoRouterHelper());

  /// Overlays Helper
  locator.registerLazySingleton<BaseOverlaysHelper>(() => AppOverlaysHelper());

  /// ApiService (NetworkManager)
  locator.registerLazySingleton<ApiService>(() => ApiService.appDefault());
}

Future<void> registerGlobalRepositories() async {

  /// Auth Repository
  /// we must initialize [AuthRepository] at app startup because it's global in app and needed at [AppMiddlewares]
  final authRepo = locator.registerSingleton<AuthRepositoryInterface>(AuthRepository.builder);
  locator.registerLazySingleton<PersonsRepositoryInterface>(() => PersonsRepository.builder);
  locator.registerFactory<PassengersController>(() => PassengersController(locator<PersonsRepositoryInterface>()));
  locator.registerFactory<PassengerDetailsController>(() => PassengerDetailsController(locator<PersonsRepositoryInterface>()));
  locator.registerFactory<AuthController>(() => AuthController());
  // /// read token and initialize [AppData] if data exist.
  // final loginResponse = authRepo.loadLoginResponse();
  // if (loginResponse != null) {
  //   AppData.instance.setToken(loginResponse.loginResponse.token);
  //
  //   /// initializing PermissionService with user permissions
  //   PermissionService.instance.init(loginResponse.loginResponse.userSettings?.userPermission ?? []);
  // }

  /// Config Repository
  final storage = locator<BaseKeyValueStore>();
  locator.registerLazySingleton<ConfigRepository>(
    () => ConfigRepository(
      AssetConfigLoader(),
      StorageConfigLoader(storage),
      DefaultConfigLoader(),
    ),
  );
  await AppData.instance.init();

}


