import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData extends ChangeNotifier {
  AppData._();
  static final AppData instance = AppData._();
  static const String _kTokenKey = 'auth_token';
  late SharedPreferences _prefs;

  String? _token;
  String? get token => _token;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs.getString(_kTokenKey);
    // Don't notify here because it's startup
  }

  set token(String? value) {
    if (_token != value) {
      _token = value;
      if (value != null) {
        _prefs.setString(_kTokenKey, value);
      } else {
        _prefs.remove(_kTokenKey);
      }
      notifyListeners();
    }
  }

  bool get hasToken => _token != null && _token!.isNotEmpty;
}
