import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  SharedPreferences? _preferences;
  static final Preferences _instance = Preferences._internal();

  factory Preferences() {
    return _instance;
  }
  Preferences._internal();
  initPref() async {
    _preferences = await SharedPreferences.getInstance();
  }

  set setKeyString(Map<String, dynamic> params) {
    _preferences?.setString(params['key'], params['value']);
  }

  set setKeyInt(Map<String, dynamic> params) {
    _preferences?.setInt(params['key'], params['value']);
  }

  set setKeyDouble(Map<String, dynamic> params) {
    _preferences?.setDouble(params['key'], params['value']);
  }

  set setKeyBool(Map<String, dynamic> params) {
    _preferences?.setBool(params['key'], params['value']);
  }

  set setKeyStringList(Map<String, dynamic> params) {
    _preferences?.setStringList(params['key'], params['value']);
  }

  String? getKeyString(String key) => _preferences?.getString(key);
  getKeyInt(String key) => _preferences?.getInt(key);
  getKeyStringList(String key) => _preferences?.getStringList(key);
  getKeyBool(String key) => _preferences?.getBool(key);

  Future<void> clearPreferences(String key) async {
    await _preferences!.remove(key);
  }
}
