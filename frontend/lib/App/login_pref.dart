import 'dart:convert';

//import 'package:goldsgymapp/model/LoginResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carbnb/models/user_model.dart';

class UserPref {
  // Constants for Preference-Name
  static const String PREF_IS_LOGGED_IN = "IS_LOGGED_IN";
  static const String PREF_USER_DATA = "USER_DATA";

  static Future<UserModel?> getUserData() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(shared_User.getString(PREF_USER_DATA)!);
    var user = UserModel.fromJson(userMap);
    return user;
  }

  static setUserData(String jsonString) async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    shared_User.setString(PREF_USER_DATA, jsonString);
  }

  static Future<bool> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool? boolValue = prefs.getBool(PREF_IS_LOGGED_IN);
    return (boolValue == null) ? false : boolValue;
  }

  static setLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool(PREF_IS_LOGGED_IN, status);
  }

}
