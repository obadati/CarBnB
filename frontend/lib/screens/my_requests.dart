import 'dart:convert';

import 'package:carbnb/App/login_pref.dart';
import 'package:carbnb/models/user_model.dart';
import 'package:carbnb/network/order_api_manager.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:intl/intl.dart';

class MyRequestsScreen extends StatefulWidget {
  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreen();
}

class _MyRequestsScreen extends State<MyRequestsScreen> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  var _response = [];

  Future<String> _fetchMyRequestsPending() async {
    return await this._memoizer.runOnce(() async {
      var orderAPIManager = OrderAPIManager();

      UserModel? userModel = await UserPref.getUserData();

      var response = await orderAPIManager
          .getMyRequestsPending(userModel?.user?.userId.toString() ?? '0');

      if (response != null) {
        setState(() {
          _response = jsonDecode(response.body);
        });
        return jsonDecode(response.body);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Requests',
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(25),
          child: FutureBuilder<String>(
            future: _fetchMyRequestsPending(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (_response.length == 0) {
                  return new Text("There are no requests on any of your cars!");
                } else {
                  return ListView.builder(
                      itemCount: _response.length,
                      itemBuilder: (BuildContext context, int position) {
                        return ExpansionTile(
                            title: Text("Request for " + _response[position]["brand"] + " " + _response[position]["model"]),
                            initiallyExpanded: position == 0,
                            children: <Widget>[
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 12.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                        color: Color(0xFFF5F8FB),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Selected Car"),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              color: Color(0xFFF5F8FB),
                                            ),
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.car_rental,
                                              ),
                                              title: Text(
                                                  _response[position]["brand"]),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              color: Color(0xFFF5F8FB),
                                            ),
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.person,
                                              ),
                                              title: Text(
                                                  _response[position]["Name"]),
                                            ),
                                          ),
                                          Text("Rent Date"),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              color: Color(0xFFF5F8FB),
                                            ),
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.date_range,
                                                color: Colors.black54,
                                              ),
                                              title: Text(new DateFormat("dd.MM.yyyy hh:mm").format(DateTime.parse(_response[position]["fromTime"])) + " - " + new DateFormat("dd.MM.yyyy hh:mm").format(DateTime.parse(_response[position]["toTime"]))),
                                            ),
                                          ),
                                          Text("Price"),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              color: Color(0xFFF5F8FB),
                                            ),
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.euro,
                                                color: Colors.black54,
                                              ),
                                              title: Text(getPriceForDateTime(_response[position]["fromTime"], _response[position]["toTime"], _response[position]["hourlyCost"], _response[position]["dailyCost"]) + " €"),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              color: Color(0xFFF5F8FB),
                                            ),
                                            child: MaterialButton(
                                              onPressed: () {
                                                updateStatus(_response[position]["orderID"], 1);
                                                // Navigator.pushReplacement(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (BuildContext context) => super.widget));
                                              },
                                              color: Colors.green,
                                              child: const Text(
                                                'Accept',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              color: Color(0xFFF5F8FB),
                                            ),
                                            child: MaterialButton(
                                              onPressed: () {
                                                updateStatus(_response[position]["orderID"], 4);
                                                // Navigator.pushReplacement(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (BuildContext context) => super.widget));
                                              },
                                              color: Colors.red,
                                              child: const Text(
                                                'Decline',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ])
                            ]);
                      });
                }
              } else {
                return Text("Loading...");
              }
            },
          )),
    );
  }

  String getPriceForDateTime(String fromTime, String toTime, int hourlyCost, int dailyCost) {
    var dateTimeFrom = DateTime.parse(fromTime);
    var dateTimeTo = DateTime.parse(toTime);
    int hours = dateTimeTo.difference(dateTimeFrom).inHours;
    int days = hours ~/ 24;
    hours = hours % 24;

    int totalCost = days * dailyCost + hours * hourlyCost;

    return totalCost.toString();
  }

  Future<void> updateStatus(int orderId, int newStatus) async {
    var orderAPIManager = OrderAPIManager();
    var response = await orderAPIManager.updateOrderStatus(orderId, newStatus);
    if (response != null) {
      print('order created!');
      showSuccessAlertDialog(context);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (BuildContext context) => RentCarScreen()));
    }
  }


  showSuccessAlertDialog(BuildContext context) {
    // set up the buttons
    Widget doneButton = FlatButton(
      child: Text("Done"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
        // Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Text("Thanks for accepting your car rental request."),
      actions: [
        doneButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
