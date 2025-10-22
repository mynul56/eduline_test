import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepository {
  static saveFirstTime() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setBool(Pref.isFirst, false);
  }

  Future<void> saveString(String key, String value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(key);
  }

  Future<void> remove(String key) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove(key);
  }

  static saveRememberMe(bool rememberMe) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setBool(Pref.rememberMe, rememberMe);
  }

  static readFirstTime() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final isFirst = sp.getBool(Pref.isFirst);
    return isFirst ?? true;
  }

  readRememberMe() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final isFirst = sp.getBool(Pref.rememberMe);
    return isFirst ?? false;
  }
}

class Pref {
  static const String isFirst = "first_time";
  static const String rememberMe = "remember_me";
}
