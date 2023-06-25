// import 'dart:html';
import 'dart:io';
import 'package:http/http.dart' as Http;
import 'api_manager_base.dart';

class CarAPIManager {
  static final CarAPIManager _shared = CarAPIManager._internal();

  factory CarAPIManager() {
    return _shared;
  }

  CarAPIManager._internal();

  static const routePrefix = 'car/';
  static const routeFilter = 'filter';

  Future<Http.Response?> getCars() async {
    var response = await get(routePrefix);
    if(response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  Future<Http.Response?> getCarsByUser(String userId) async {
    var response = await get(routePrefix + "user/" + userId);
    if(response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  Future<Http.Response?> getCarById(String id) async {
    var response = await get(routePrefix + id);
    if(response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }


  Future<Http.Response?> getCarByFilterData(Map<String,String> data) async {
    var response = await post(routePrefix + routeFilter, data)/* get(routePrefix + routeFilter, queryParameters: data)*/;
    if(response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  Future<bool> addCar(Map<String,String> data,File file) async {
    var response = await multipartPost(routePrefix, data, file);// multipartPost(routePrefix, data, file);
    return response;
  }

  Future<Http.Response?> setCarStatus(int carId, int status) async {
    var body = {
      "CarID": carId,
      "Status": status
    };

    var response = await put(routePrefix + "carstatus", body);
    if(response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }
}