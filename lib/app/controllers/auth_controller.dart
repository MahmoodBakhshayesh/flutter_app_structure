import 'dart:developer';

import '../data/app_data.dart';

class AuthController {
  
  Future<bool> login(String username, String password) async {
    // Simulate login delay
    log("token before login was ${AppData.instance.token}");
    await Future.delayed(const Duration(seconds: 1));

    
    // In a real app, call API here.
    // For now, any login is successful.
    if (username.isNotEmpty && password.isNotEmpty) {
      AppData.instance.token = "mock_token_${DateTime.now().millisecondsSinceEpoch}";
      // AppData().setToken("mock_token_${DateTime.now().millisecondsSinceEpoch}");

      return true;
    }
    return false;
  }

  void logout() {
    AppData.instance.token = null;
  }
}
