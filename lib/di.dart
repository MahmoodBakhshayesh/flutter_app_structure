import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpodfuckaround/features/persons/domain/interfaces/persons_repository_interface.dart';
import 'package:riverpodfuckaround/features/persons/domain/repositories/persons_details_repository.dart';
import 'app/repositories/login_repository.dart';
import 'app/controllers/auth_controller.dart';
import 'features/persons/controllers/passenger_details_controller.dart';
import 'features/persons/controllers/passengers_controller.dart';

final getIt = GetIt.instance;

void dependencyInjection() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<PersonsRepositoryInterface>(() => PersonsRepository());
  getIt.registerFactory<PassengersController>(() => PassengersController(getIt<PersonsRepositoryInterface>()));
  getIt.registerFactory<PassengerDetailsController>(() => PassengerDetailsController(getIt<PersonsRepositoryInterface>()));
  getIt.registerFactory<AuthController>(() => AuthController());
}
