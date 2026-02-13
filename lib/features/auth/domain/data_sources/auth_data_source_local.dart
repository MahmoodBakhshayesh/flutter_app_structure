
import 'package:riverpodfuckaround/core/interfaces/base_data_source.dart';

import '../../../../core/interfaces/base_key_value_store.dart';
import '../interfaces/auth_data_source_interface.dart';

class AuthDataSourceLocal  extends LocalDataSource implements AuthDataSourceInterface {
  AuthDataSourceLocal(super.keyValueStore);
}