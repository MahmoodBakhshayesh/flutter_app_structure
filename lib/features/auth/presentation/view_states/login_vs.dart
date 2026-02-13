import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_it/get_it.dart';
import '../../controllers/auth_controller.dart';

class LoginViewState {
  final bool isLoading;
  final String? errorMessage;
  final bool isLoggedIn;

  LoginViewState({
    this.isLoading = false,
    this.errorMessage,
    this.isLoggedIn = false,
  });

  factory LoginViewState.initial() => LoginViewState();

  LoginViewState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isLoggedIn,
  }) {
    return LoginViewState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

class LoginNotifier extends Notifier<LoginViewState> {
  // Use GetIt to get AuthController
  AuthController get _authController => GetIt.I<AuthController>();

  @override
  LoginViewState build() {
    return LoginViewState.initial();
  }

  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final success = await _authController.login(username, password);
      if (success) {
        state = state.copyWith(isLoading: false, isLoggedIn: true);
      } else {
        state = state.copyWith(isLoading: false, errorMessage: "Invalid credentials");
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void reset() {
    state = LoginViewState.initial();
  }
}

final loginNotifierProvider = NotifierProvider<LoginNotifier, LoginViewState>(LoginNotifier.new);
