import '../data/app_data.dart';

class AuthController {
  
  Future<bool> login(String username, String password) async {
    // Simulate login delay
    await Future.delayed(const Duration(seconds: 1));
    
    // In a real app, call API here.
    // For now, any login is successful.
    if (username.isNotEmpty && password.isNotEmpty) {
      AppData.instance.token = "mock_token_${DateTime.now().millisecondsSinceEpoch}";
      return true;
    }
    return false;
  }

  void logout() {
    AppData.instance.token = null;
  }
}
