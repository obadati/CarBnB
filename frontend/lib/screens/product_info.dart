
import 'package:carbnb/config/constants.dart';
import 'package:carbnb/models/car_model.dart';
import 'package:carbnb/screens/checkout.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {

  final CarModel car;
  final bool showRentThisCar;

  ProductPage( this.car, [this.showRentThisCar = true] );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Details',
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
          title: Text(car.car.brand + " from " + car.car.name),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200.0,
                    width: 400.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage((Constants.base_image_url + '${car.car.carId}.jpg')),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    car.car.brand + " " + car.car.model,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      car.car.descriptionText == null ? "" : car.car.descriptionText,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Hourly cost',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      car.car.hourlyCost == null ? "" : car.car.hourlyCost.toString() + " €",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Daily cost',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      car.car.dailyCost == null ? "" : car.car.dailyCost.toString() + " €",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // Divider(),
                  // ListTile(
                  //   title: Text(
                  //     'Pick-up/Delivery Type',
                  //     style: TextStyle(
                  //       color: Colors.blue,
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   subtitle: Text(
                  //     ' TODO Delivery',
                  //     style: TextStyle(
                  //       fontSize: 18,
                  //     ),
                  //   ),
                  // ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Type',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      car.car.type == null ? "" : car.car.type,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Car Brand',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      car.car.brand == null ? "" : car.car.brand,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Color',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      car.car.color == null ? "" : car.car.color,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Seats',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      car.car.seats == null ? "" : car.car.seats.toString(),
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Fuel Type',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      car.car.fuel == null ? "" : car.car.fuel,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: this.showRentThisCar,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
                      ),
                      onPressed: () {  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Checkout(car.car))); },
                      child: const Text('Rent this car', style: TextStyle(fontSize: 15, color: Colors.white),),
                    ),
                  )
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
}

class StatelessFulWidget {
}