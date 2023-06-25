import 'dart:collection';
import 'dart:convert';
import 'dart:io';
// import 'dart:html';

import 'package:carbnb/App/login_pref.dart';
import 'package:carbnb/models/user_model.dart';
import 'package:http/http.dart' as Http;
import 'package:http_parser/http_parser.dart';
enum Routes {
  login

}

extension ParseToString on Routes {
  String toShortString() {
    return toString().split('.').last;
  }
}

Future<Http.Response> post(String path, var body, {bool authHeader = true}) async {
  String url = 'http://localhost:3000/' + path;
  Map<String, String> headers = new HashMap();
  headers['Accept'] = 'application/json';
  headers['Content-type'] = 'application/json';
  if (authHeader) {
    UserModel? userModel = await UserPref.getUserData();
    if(userModel != null && userModel.accessToken != null) {
      headers['Authorization'] = 'Bearer ${userModel.accessToken}';
    }
  }

  Http.Response response = await Http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
      encoding: Encoding.getByName('utf-8')
  );

  return response;
}

Future<bool> multipartPost(String path, Map<String, String> body, File file, {bool authHeader = true}) async {
  String url = 'http://localhost:3000/' + path;
  Map<String, String> headers = new HashMap();
  headers['Accept'] = 'application/json';
  headers['Content-type'] = 'application/json';
  if (authHeader) {
    UserModel? userModel = await UserPref.getUserData();
    if(userModel != null && userModel.accessToken != null) {
      headers['Authorization'] = 'Bearer ${userModel.accessToken}';
    }
  }
  var req = Http.MultipartRequest ('POST', Uri.parse(url));

  headers.forEach((key, value) {
  req.headers[key] = value;
  });
  body.forEach((key, value) {
    req.fields[key] = value;
  });
  req.files.add(await Http.MultipartFile.fromPath(
      'images',
      file.path,
      contentType: MediaType('image', 'jpg')
      // contentType: MediaType('application', 'x-tar')
  ));
  var response = await req.send();
  print(response);
  return (response.statusCode == 200) ? true : false;
}

Future<Http.Response> put(String path, var body) async {
  String url = 'http://localhost:3000/' + path;
  Map<String, String> headers = new HashMap();
  headers['Accept'] = 'application/json';
  headers['Content-type'] = 'application/json';

  UserModel? userModel = await UserPref.getUserData();
  if(userModel != null && userModel.accessToken != null) {
    headers['Authorization'] = 'Bearer ${userModel.accessToken}';
  }

  Http.Response response = await Http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
      encoding: Encoding.getByName('utf-8')
  );

  return response;
}


Future<Http.Response> get(String path) async {
  String base_url = 'http://localhost:3000/' + path;
  Map<String, String> headers = new HashMap();
  headers['Accept'] = 'application/json';
  UserModel? userModel = await UserPref.getUserData();
  if(userModel != null && userModel.accessToken != null) {
    headers['Authorization'] = 'Bearer ${userModel.accessToken}';
  }
  print(headers);
  Http.Response response = await Http.get(
      Uri.parse(base_url),
      headers: headers
  );

  return response;
}

// var url = Uri.https('${base_url}', '${path}', queryParameters);