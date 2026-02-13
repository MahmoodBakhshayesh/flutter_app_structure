import 'dart:developer';

import 'package:app_device_net_info/app_device_net_info.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../core/models/base/flavor_config.dart';
//
// class AppData extends ChangeNotifier {
//   AppData._();
//   late SharedPreferences _prefs;
//   factory AppData() => instance;
//
//   static final AppData instance = AppData._();
//   static const String _kTokenKey = 'auth_token';
//
//   String? token;
//   String? _firebaseToken;
//
//   bool get hasToken2 => instance.token != null && instance.token!.isNotEmpty;
//   bool get hasToken => token != null && token!.isNotEmpty;
//
//   String? get firebaseToken => instance._firebaseToken;
//
//   Future<AppInfoData> get getAppInfo => AppDeviceNetworkInfo.getAppInfo();
//
//   static Flavor get defaultFlavor => Flavor.dev;
//
//   Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//     token = _prefs.getString(_kTokenKey);
//     // Don't notify here because it's startup
//   }
//
//   void setToken(String? value) {
//     instance.token = value;
//     log("set token from ${token} to $value  => ${hasToken}");
//     if (token != value) {
//       token = value;
//       if (value != null) {
//         _prefs.setString(_kTokenKey, value);
//       } else {
//         _prefs.remove(_kTokenKey);
//       }
//       notifyListeners();
//     }
//   }
//
//   void setFirebaseToken(String? token) {
//     instance._firebaseToken = token;
//
//   }
//
//   void clear() {
//     instance.token = null;
//     instance._firebaseToken = null;
//     instance.token = null;
//   }
// }
//
//

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/models/base/flavor_config.dart';

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
    log("setting token ${_token}");
    // Don't notify here because it's startup
  }

  Future<AppInfoData> get getAppInfo => AppDeviceNetworkInfo.getAppInfo();

  static Flavor get defaultFlavor => Flavor.dev;

  set token(String? value) {
    if (_token != value) {
      _token = value;
      if (value != null) {
        _prefs.setString(_kTokenKey, value);
        log("saving token ${value}");
      } else {
        // _prefs.remove(_kTokenKey);
      }
      notifyListeners();
    }
  }

  bool get hasToken => _token != null && _token!.isNotEmpty;
}
