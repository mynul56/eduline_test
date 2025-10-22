import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepository {
  static saveFirstTime() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setBool(Pref.isFirst, false);
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
