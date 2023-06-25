import 'package:http/http.dart' as Http;
import 'api_manager_base.dart';

class OrderAPIManager {
  static final OrderAPIManager _shared = OrderAPIManager._internal();

  factory OrderAPIManager() {
    return _shared;
  }

  OrderAPIManager._internal();

  static const routePrefix = 'order/';

  Future<Http.Response?> getUserOrder(String userId) async {
    var response = await get(routePrefix + "userOrder/" + userId);
    if(response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  Future<Http.Response?> getMyRequestsPending(String userId) async {
    var response = await get(routePrefix + "pendingOrder/" + userId);
    if(response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  Future<Http.Response?> updateOrderStatus(int orderId, int statusId) async {
    var body = {
      "OrderID": orderId,
      "StatusID": statusId
    };

    var response = await put(routePrefix, body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  Future<Http.Response?> createOrder(int carId, int ownerId, int userId, DateTime from, DateTime to, int price) async {
    var body = {
      "carID": carId,
      "ownerID": ownerId,
      "userID": userId,
      "fromTime": from.toString(),
      "toTime": to.toString(),
      "total": price,
      "insuranceID" : "3"
    };

    var response = await post(routePrefix, body);
    if(response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }
}