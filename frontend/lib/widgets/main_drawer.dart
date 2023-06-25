import 'dart:convert';
import 'dart:ffi';

import 'package:carbnb/models/filter_data.dart';
import 'package:carbnb/network/misc_api_manager.dart';
import 'package:flutter/material.dart';


class MainDrawer extends StatefulWidget {
  final ValueChanged onResult;
  final Map<String, String> filterData;
  MainDrawer({required this.onResult, required this.filterData});
  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  FilterData? filterData;

  @override
  void initState() {
    // TODO: implement initState
    _fetchCarsOnLocation();
    super.initState();
  }

  setFilterIfDataAvailable() {
    var mapData = widget.filterData;
    if (mapData['city'] != null && mapData['city']!.isNotEmpty) {
      selectedLocation = mapData['city'];
    }
    if (mapData['brand'] != null && mapData['brand']!.isNotEmpty) {
      selectedBrand = mapData['brand'];
    }
    if (mapData['type'] != null && mapData['type']!.isNotEmpty) {
      selectedCarType = mapData['type'];
    }
    if (mapData['fuel'] != null && mapData['fuel']!.isNotEmpty) {
      selectedFuelType = mapData['fuel'];
    }
    if (mapData['gear'] != null && mapData['gear']!.isNotEmpty) {
      selectedGearType = mapData['gear'];
    }
    if (mapData['color'] != null && mapData['color']!.isNotEmpty) {
      selectedColor = mapData['color'];
    }
    if (mapData['seat'] != null && mapData['seat']!.isNotEmpty) {
      selectedSeats = mapData['seat'];
    }
    if (mapData['price'] != null && mapData['price']!.isNotEmpty) {
      _currentSliderValue = double.parse(mapData['price'] ?? '0.0');
    }
  }

  void _fetchCarsOnLocation() async {
    var miscAPIManager = MiscAPIManager();

    var response = await miscAPIManager.getFilterData();

    if (response != null) {
      // setState(() {
      final parsedJson = jsonDecode(response.body);
      filterData = FilterData.fromJson(parsedJson);
      setFilterIfDataAvailable();
      setState(() {});
    }
  }

  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      // onTap: tapHandler,
    );
  }

  List<bool> purchaseType = [false, false, false];

  String? selectedLocation;
  List<String> locations = [
    'Frankfurt',
    'Berlin',
    'Hamburg',
    'Munich',
    'Cologne',
    'Düsseldorf',
    'Leipzig',
    'Nuremberg',
    'Fulda',
  ];

  String? selectedBrand;

  String? defaultPickupDeliveryType;
  List <String> pickupDeliveryTypes = [
    'Pick Up',
    'Delivery',
  ];

  String? selectedCarType;
  String? selectedColor;
  String? selectedSeats;
  List <String> seats = [
    '1',
    '2',
    '4',
  ];

  String? selectedFuelType;
  String? selectedGearType;
  double _currentSliderValue = 0;

  resetFilter() {
    selectedLocation = null;
    selectedBrand = null;
    selectedCarType = null;
    selectedFuelType = null;
    selectedGearType = null;
    selectedColor = null;
    selectedSeats = null;
    _currentSliderValue = 0;
  }

  Map<String, String> createFilterParam() {
    var returnMap = Map<String, String>();
    returnMap['city'] = selectedLocation ?? "";
    returnMap['brand'] = selectedBrand ?? "";
    returnMap['type'] = selectedCarType ?? "";
    returnMap['fuel'] = selectedFuelType ?? "";
    returnMap['gear'] = selectedGearType ?? "";
    returnMap['color'] = selectedColor ?? "";
    returnMap['seat'] = selectedSeats ?? "";
    returnMap['price'] = '${_currentSliderValue}';
    return returnMap;
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold));

    return Drawer(
      child: filterData == null ?
      Center(child: CircularProgressIndicator()) :
      Padding(
          padding: const EdgeInsets.only(left: 16,top: 60,right: 16,bottom: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                dropDownFilter('Location', locations, (newValue) => {
                  setState(() {
                    selectedLocation = newValue!;
                  }),

                }, selectedLocation, 'Select Location'),
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Text('Price per day'),
                ),
                Slider(
                  value: _currentSliderValue,
                  max: 100,
                  divisions: 75,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
                dropDownFilter('Brand', filterData?.brand, (newValue) => {
                  setState(() {
                    selectedBrand = newValue!;
                  }),

                }, /*defaultBrand == null ? filterData?.brand?.first : */selectedBrand, 'Select car brand'),
                // dropDownFilter('Pick-up/delivery type', pickupDeliveryTypes, (newValue) => {
                //   setState(() {
                //     defaultPickupDeliveryType = newValue!;
                //   }),
                // }, defaultPickupDeliveryType, 'Select pick-up/delivery type'),
                dropDownFilter('Car Type', filterData?.type, (newValue) => {
                  setState(() {
                    selectedCarType = newValue!;
                  }),

                }, selectedCarType, 'Select Location'),
                dropDownFilter('Color', filterData?.color, (newValue) => {
                  setState(() {
                    selectedColor = newValue!;
                  }),

                }, selectedColor, 'Select Color'),
                dropDownFilter('Seats', seats, (newValue) => {
                  setState(() {
                    selectedSeats = newValue!;
                  }),

                }, selectedSeats, 'Select number of seats'),
                dropDownFilter('Fuel Type', filterData?.fuel, (newValue) => {
                  setState(() {
                    selectedFuelType = newValue!;
                  }),

                }, selectedFuelType, 'Select fuel preference'),
                dropDownFilter('Car Transmission', filterData?.gear, (newValue) => {
                  setState(() {
                    selectedGearType = newValue!;
                  }),

                }, selectedGearType, 'Select preferred car transmission'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: style,
                      onPressed: () {
                        resetFilter();
                        widget.onResult(createFilterParam());
                        Navigator.pop(context);
                      },
                      child: const Text('Reset'),
                    ),
                    ElevatedButton(
                      style: style,
                      onPressed: () {
                        widget.onResult(createFilterParam());
                        Navigator.pop(context);
                      },
                      child: const Text('Filter Cars'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget dropDownFilter(String title, List<String>? array, Function(String?) onChange, String? defaultValue, String? hintText) {
    return Column(
      children: [
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Text(title),
        ),
        Container(
          height: 42,
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButton<String>(
            hint: Text(hintText ?? ''),
            isExpanded: true,
            value: defaultValue,
            icon: const Icon(Icons.expand_more),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
            ),
            onChanged: onChange,
            items: array?.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
