import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {

  static const String USER_NAME = "user_name";
  static const String PHONE_NUMBER = "phone_number";
  static const String IS_LOGGED = "is_logged";

  static void setUserLogin(bool isLogged) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(IS_LOGGED, isLogged);
  }

  static Future<bool> getLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(IS_LOGGED) ?? false;
  }

  static void setUserName(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(USER_NAME, name);
  }

  static Future<String> getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(USER_NAME) ?? "Vikas Suthar";
  }

  static void setPhoneNumber(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(PHONE_NUMBER, name);
  }

  static Future<String> getPhoneNumber() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(PHONE_NUMBER) ?? "1234567890";
  }
}