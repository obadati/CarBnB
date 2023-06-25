import 'package:carbnb/App/login_pref.dart';
import 'package:carbnb/models/car_model.dart';
import 'package:carbnb/models/user_model.dart';
import 'package:carbnb/network/order_api_manager.dart';
import 'package:carbnb/screens/HomeScreen/rent_car_screen.dart';
import 'package:flutter/material.dart';
import 'about_us.dart';

class Checkout extends StatefulWidget {
  final Car car;

  const Checkout(this.car);

  @override
  _CheckoutState createState() => _CheckoutState(this.car);
}

class _CheckoutState extends State<Checkout> {
  final Car car;

  _CheckoutState(this.car);

  DateTime? selectedStartDate;// = DateTime.now();
  DateTime? selectedEndDate;// = DateTime.now();
  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Checkout",
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: oldBody(),
    );
  }

  Widget oldBody() {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(
            top: 12.0, left: 12.0, right: 12.0, bottom: 12.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 6.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Selected Car"),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Color(0xFFF5F8FB),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.car_rental,
                      ),
                      title: Text(car.brand + " " + car.model),
                    ),
                  ),
                  const Text("Rent Dates"),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Color(0xFFF5F8FB),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.date_range,
                        color: Colors.black54,
                      ),
                      title: Text(
                          "${(selectedStartDate ?? DateTime.now()).day}/${(selectedStartDate ?? DateTime.now()).month}/${(selectedStartDate ?? DateTime.now()).year}"),
                      onTap: () {
                        _selectStartDate(context);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Color(0xFFF5F8FB),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.date_range,
                      ),
                      title: Text(
                          "${(selectedEndDate ?? DateTime.now()).day}/${(selectedEndDate ?? DateTime.now()).month}/${(selectedEndDate ?? DateTime.now()).year}"),
                      onTap: () {
                        _selectEndDate(context);
                      },
                    ),
                  ),
                  Text("Total price (Daily price: " +
                      car.dailyCost.toString() +
                      ", Hourly price: " +
                      car.hourlyCost.toString()),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Color(0xFFF5F8FB),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.attach_money,
                        color: Colors.black54,
                      ),
                      title: Text(totalPrice.toString()),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Color(0xFFF5F8FB),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        _requestCar();
                      },
                      color: Colors.blue,
                      child: const Text(
                        'Request this Car',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                  const Text(
                      'The request is not yet a final confirmation. The owner of the car has to approve it.'),
                  Container(
                    margin: const EdgeInsets.only(top: 24.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget newBody() {

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: const Text('Selected car'),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    color: Color(0xFFF5F8FB),
                                  ),
                                  child: Center(
                                    child: ListTile(
                                      minVerticalPadding: 1,
                                      minLeadingWidth: 1,
                                      leading: const Icon(
                                        Icons.car_rental,
                                        color: Colors.black54,
                                      ),
                                      title: Text(
                                        '${car.brand} ${car.model} at ${car.city}',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Flexible(
                            flex: 1,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 0, 16, 0),
                                          child: const Text('From Date'),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 50,
                                          // margin: const EdgeInsets.symmetric(vertical: 12.0),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                            color: Color(0xFFF5F8FB),
                                          ),
                                          child: Center(
                                            child: ListTile(
                                              minVerticalPadding: 1,
                                              minLeadingWidth: 1,
                                              leading: const Icon(
                                                Icons.date_range,
                                                color: Colors.black54,
                                              ),
                                              title: Text(
                                                  "${(selectedStartDate ?? DateTime.now()).day}/${(selectedStartDate ?? DateTime.now()).month}/${(selectedStartDate ?? DateTime.now()).year}"),
                                              onTap: () {
                                                setState(() {
                                                  _selectStartDate(context);
                                                });

                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 0, 16, 0),
                                          child: const Text('To Date'),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 50,
                                          // margin: const EdgeInsets.symmetric(vertical: 12.0),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                            color: Color(0xFFF5F8FB),
                                          ),
                                          child: Center(
                                            child: ListTile(
                                              minLeadingWidth: 1,
                                              leading: const Icon(
                                                Icons.date_range,
                                                color: Colors.black54,
                                              ),
                                              title: Text(
                                                  "${(selectedEndDate ?? DateTime.now()).day}/${(selectedEndDate ?? DateTime.now()).month}/${(selectedEndDate ?? DateTime.now()).year}"),
                                              onTap: () {
                                                _selectEndDate(context);
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            )),
            flex: 2,
          ),
          Flexible(
            child: Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: Container(
                  color: Colors.white,
                  // width: 200,
                  // height: 200,
                ),
              ),
            )),
            flex: 3,
          ),
          Flexible(
            child: Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: Container(
                  color: Colors.white,
                  // width: 200,
                  // height: 200,
                ),
              ),
            )),
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => Checkout(car.car)));
              },
              child: const Text(
                'Request this car',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _selectStartDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    selectedStartDate = selected;
    if (selectedEndDate == null) { // first time
      selectedEndDate = selected;
    }
    setState(() {
      _recalculatePrice();
    });
    // else {
    //   if (_validateDateFields(selected!, selectedEndDate ?? DateTime.now())) {
    //     if (selected != selectedStartDate) {
    //       setState(() {
    //         selectedStartDate = selected;
    //       });
    //     }
    //     _recalculatePrice();
    //   }
    // }
  }

  _selectEndDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedEndDate ?? DateTime.now(),//selectedStartDate ?? DateTime.now(),
      firstDate: selectedStartDate ?? DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (_validateDateFields(selectedStartDate ?? DateTime.now(), selected!)) {
      if (selected != selectedEndDate) {
        setState(() {
          selectedEndDate = selected;
        });
      }
      _recalculatePrice();
    }
  }

  _validateDateFields(DateTime from, DateTime to) {
    if (from.isAfter(to)) {
      return false;
    }
    return true;
  }

  _recalculatePrice() {
    var dateTimeFrom = DateTime.parse(selectedStartDate.toString());
    var dateTimeTo = DateTime.parse(selectedEndDate.toString());
    print(dateTimeFrom);
    print(dateTimeTo);
    int hours = dateTimeTo.difference(dateTimeFrom).inHours;
    int days = hours ~/ 24;
    hours = hours % 24;

    int price = days * car.dailyCost + hours * car.hourlyCost;
    totalPrice = price;
  }

  _requestCar() async {
    OrderAPIManager orderAPIManager = OrderAPIManager();
    UserModel? userModel = await UserPref.getUserData();

    int carId = car.carId;
    int ownerId = car.userId;
    int userId = userModel?.user?.userId ?? 0;
    DateTime from = selectedStartDate ?? DateTime.now();
    DateTime to = selectedEndDate ?? DateTime.now();
    int price = totalPrice;
    var response = await orderAPIManager.createOrder(
        carId, ownerId, userId, from, to, price);
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
        Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Text("Your request for selected dates has been sent to the owner."),
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
