// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Car> carFromJson(String str) => List<Car>.from(json.decode(str).map((x) => Car.fromJson(x)));

String carToJson(List<Car> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


CarModel carModelFromJson(String str) => CarModel.fromJson(json.decode(str));

String carModelToJson(CarModel data) => json.encode(data.toJson());

class CarModel {
  CarModel({
    required this.car,
  });

  Car car;

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
    car: Car.fromJson(json),
  );

  Map<String, dynamic> toJson() => {
    "car": car.toJson()
  };
}


class Car {
  Car({
    required this.carId,
    required this.userId,
    required this.name,
    required this.brand,
    required this.type,
    required this.fuel,
    required this.gear,
    required this.color,
    required this.descriptionText,
    required this.model,
    required this.plateNumber,
    required this.hourlyCost,
    required this.dailyCost,
    required this.seats,
    required this.doors,
    required this.lat,
    required this.long,
    required this.city,
    required this.dateCreated,
  });

  int carId;
  int userId;
  String name;
  String brand;
  String type;
  String fuel;
  String gear;
  String color;
  String descriptionText;
  String model;
  String plateNumber;
  int hourlyCost;
  int dailyCost;
  int seats;
  int doors;
  String lat;
  String long;
  String city;
  DateTime dateCreated;
  // String mediaLink;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    carId: json["carID"],
    userId: json["userID"],
    name: json["Name"],
    brand: json["brand"],
    type: json["Type"],
    fuel: json["fuel"],
    gear: json["gear"],
    color: json["color"],
    descriptionText: json["description"],
    model: json["model"],
    plateNumber: json["plateNumber"],
    hourlyCost: json["hourlyCost"],
    dailyCost: json["dailyCost"],
    seats: json["seats"],
    doors: json["doors"],
    lat: json["lat"],
    long: json["long"],
    city: json["city"],
    dateCreated: DateTime.parse(json["dateCreated"]),
  );

  Map<String, dynamic> toJson() => {
    "carID": carId,
    "userID": userId,
    "Name": name,
    "brand": brand,
    "Type": type,
    "fuel": fuel,
    "gear": gear,
    "color": color,
    "description": descriptionText,
    "model": model,
    "plateNumber": plateNumber,
    "hourlyCost": hourlyCost,
    "dailyCost": dailyCost,
    "seats": seats,
    "doors": doors,
    "lat": lat,
    "long": long,
    "city": city,
    "dateCreated": dateCreated.toIso8601String(),
  };
}
