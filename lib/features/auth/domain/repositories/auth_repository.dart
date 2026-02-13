import 'package:riverpodfuckaround/features/auth/domain/data_sources/auth_data_source_local.dart';
import 'package:riverpodfuckaround/features/auth/domain/interfaces/auth_data_source_interface.dart';
import 'package:riverpodfuckaround/features/auth/domain/interfaces/auth_repository_interface.dart';
import 'package:riverpodfuckaround/features/auth/usecases/login_usecase.dart';

import '../../../../di.dart';
import '../data_sources/auth_data_source_remote.dart';

class AuthRepository implements AuthRepositoryInterface {
  final AuthDataSourceInterface _remoteSource;
  final AuthDataSourceInterface _localSource;

  AuthRepository({required AuthDataSourceInterface remoteSource, required AuthDataSourceInterface localSource})
      : _localSource = localSource, _remoteSource = remoteSource;

  static AuthRepositoryInterface get builder => AuthRepository(
    remoteSource: AuthDataSourceRemote(locator()),
    localSource: AuthDataSourceLocal(locator()),
  );

  @override
  Future<LoginResponse> login({required LoginRequest request}) async {
    return LoginResponse();
  }
}
