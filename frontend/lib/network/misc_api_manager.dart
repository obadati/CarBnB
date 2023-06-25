import 'package:http/http.dart' as Http;
import 'api_manager_base.dart';

class MiscAPIManager {
  static final MiscAPIManager _shared = MiscAPIManager._internal();

  factory MiscAPIManager() {
    return _shared;
  }

  MiscAPIManager._internal();

  static const routePrefix = 'faq/';
  static const routeFilter = 'car/filterdata/';

  Future<Http.Response?> getFAQs() async {
    var response = await get(routePrefix);
    if(response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  Future<Http.Response?> getFilterData() async {
    var response = await get(routeFilter);
    if(response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }


}