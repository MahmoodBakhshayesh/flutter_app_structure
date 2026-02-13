import '../../usecases/login_usecase.dart';

abstract class AuthRepositoryInterface  {
  Future<LoginResponse> login({required LoginRequest request});
}
