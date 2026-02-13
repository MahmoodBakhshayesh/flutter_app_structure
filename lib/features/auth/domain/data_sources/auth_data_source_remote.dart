import 'package:riverpodfuckaround/core/interfaces/base_data_source.dart';
import '../interfaces/auth_data_source_interface.dart';

class AuthDataSourceRemote extends RemoteDataSource implements AuthDataSourceInterface {
  AuthDataSourceRemote(super.apiService);
}