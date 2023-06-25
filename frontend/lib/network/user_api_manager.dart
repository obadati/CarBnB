import 'package:http/http.dart' as Http;
import 'api_manager_base.dart';

class UserAPIManager {
  static final UserAPIManager _shared = UserAPIManager._internal();

  factory UserAPIManager() {
    return _shared;
  }

  UserAPIManager._internal();

  static const routePrefix = 'user/';

  Future<Http.Response?> loginUserWith(String email, String password) async {
    var body = {"email": email, "password": password};

    var response = await post(routePrefix + Routes.login.toShortString(), body, authHeader: false);
    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  Future<Http.Response?> registerUserWith(String email, String password,
      String firstname, String lastname, String phoneNumber) async {
    var body = {
      "email": email,
      "password": password,
      "firstName": firstname,
      "lastName": lastname,
      "phoneNumber": phoneNumber
    };

    var response = await post(routePrefix+'register', body, authHeader: false);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }
}
