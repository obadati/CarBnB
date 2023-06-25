// To parse this JSON data, do
//
//     final filterData = filterDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FilterData filterDataFromJson(String str) => FilterData.fromJson(json.decode(str));

String filterDataToJson(FilterData data) => json.encode(data.toJson());

class FilterData {
  FilterData({
    required this.brand,
    required this.city,
    required this.type,
    required this.color,
    required this.gear,
    required this.fuel,
  });

  List<String> brand;
  List<String> city;
  List<String> type;
  List<String> color;
  List<String> gear;
  List<String> fuel;

  factory FilterData.fromJson(Map<String, dynamic> json) => FilterData(
    brand: List<String>.from(json["brand"].map((x) => x)),
    city: List<String>.from(json["city"].map((x) => x)),
    type: List<String>.from(json["type"].map((x) => x)),
    color: List<String>.from(json["color"].map((x) => x)),
    gear: List<String>.from(json["gear"].map((x) => x)),
    fuel: List<String>.from(json["fuel"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "brand": List<dynamic>.from(brand.map((x) => x)),
    "city": List<dynamic>.from(city.map((x) => x)),
    "type": List<dynamic>.from(type.map((x) => x)),
    "color": List<dynamic>.from(color.map((x) => x)),
    "gear": List<dynamic>.from(gear.map((x) => x)),
    "fuel": List<dynamic>.from(fuel.map((x) => x)),
  };
}
