import 'package:carbnb/app/login_pref.dart';
import 'package:carbnb/models/user_model.dart';

class AppStateManager {
  static final AppStateManager shared = AppStateManager._internal();

  UserModel? loginUser;
//  AppPreferences _appPreferences;

  factory AppStateManager() {
    return shared;
  }

  AppStateManager._internal() {
    getUserData();
  }

  getUserData() async {
    await UserPref.getUserData().then((value) {
      if (value != null) {
        this.loginUser = value;
      }
    });
  }
}
