import 'dart:convert';
import 'dart:io';

import 'package:carbnb/App/app_state_manager.dart';
import 'package:carbnb/models/filter_data.dart';
import 'package:carbnb/models/user_model.dart';
import 'package:carbnb/network/car_api_manager.dart';
import 'package:carbnb/network/misc_api_manager.dart';
import 'package:carbnb/utils/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddCarScreen extends StatefulWidget {
  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  // dummy data
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

  String? selectedPickupDeliveryType;
  List<String> pickupDeliveryTypes = [
    'Pick Up',
    'Delivery',
  ];

  String? selectedCarType;

  String? selectedColor;

  String? selectedSeats;
  List<String> seats = [
    '1',
    '2',
    '4',
  ];

  String? selectedDoors;
  List<String> doors = [
    '2',
    '3',
    '4',
    '5'
  ];

  String? selectedFuelType;
  String? selectedTransmissionType;

  FilterData? filterData;

  static GlobalKey<FormState> _titleKey = new GlobalKey<FormState>();
  TextEditingController titleController = new TextEditingController();

  static GlobalKey<FormState> _descKey = new GlobalKey<FormState>();
  TextEditingController descController = new TextEditingController();

  static GlobalKey<FormState> _priceKey = new GlobalKey<FormState>();
  TextEditingController priceController = new TextEditingController();

  static GlobalKey<FormState> _numPlateKey = new GlobalKey<FormState>();
  TextEditingController numPlateController = new TextEditingController();

  ImagePicker picker = ImagePicker();
  var selectedImage;
  String? uploadImageText = 'Upload Image';
  @override
  void initState() {
    // TODO: implement initState
    _fetchCarsOnLocation();
    super.initState();


  }

  void _fetchCarsOnLocation() async {
    var miscAPIManager = MiscAPIManager();

    var response = await miscAPIManager.getFilterData();

    if (response != null) {
      // setState(() {
      final parsedJson = jsonDecode(response.body);
      filterData = FilterData.fromJson(parsedJson);
      setState(() {});
    }
  }

  bool validateAllFields() {
    if (this.titleController.text.isEmpty) {
      Util.showToast('Please enter title for you car!');
      return false;
    } else if (this.descController.text.isEmpty) {
      Util.showToast('Please enter description for you car!');
      return false;
    } else if (this.priceController.text.isEmpty) {
      Util.showToast('Please enter the price per hours for you car to be rented!');
      return false;
    } else if (this.numPlateController.text.isEmpty) {
      Util.showToast('Please enter your car number plate');
      return false;
    }  else if (selectedLocation == null && (selectedLocation ?? '').isEmpty) {
      Util.showToast('Please select car location');
      return false;
    }   else if (selectedBrand == null && (selectedBrand ?? '').isEmpty) {
      Util.showToast('Please select car brand');
      return false;
    }  else if (selectedPickupDeliveryType == null && (selectedPickupDeliveryType ?? '').isEmpty) {
      Util.showToast('Please select pickup or delivery type');
      return false;
    }  else if (selectedCarType == null && (selectedCarType ?? '').isEmpty) {
      Util.showToast('Please select your car type');
      return false;
    } else if (selectedColor == null && (selectedColor ?? '').isEmpty) {
      Util.showToast('Please select your car color');
      return false;
    }   else if (selectedSeats == null && (selectedSeats ?? '').isEmpty) {
      Util.showToast('Please select number of seats in your car');
      return false;
    }  else if (selectedDoors == null && (selectedDoors ?? '').isEmpty) {
      Util.showToast('Please select number of doors in your car');
      return false;
    }  else if (selectedFuelType == null && (selectedFuelType ?? '').isEmpty) {
      Util.showToast('Please select fuel type of your car');
      return false;
    } else if (selectedTransmissionType == null && (selectedTransmissionType ?? '').isEmpty) {
      Util.showToast('Please select your car transmission');
      return false;
    } else if (selectedImage == null) {
      Util.showToast('Please select your car image');
      return false;
    }
    return true;
  }

  void AddCar() async {
    Util.showProgressDialog(context);

    var user = AppStateManager().loginUser;
    Map<String, String> param = {
      "userId" : '${user?.user?.userId ?? ''}',
      "brandId" : "3",
      "carTypeId" : "6",
      "fuelTypeId" : "4",
      "color" : selectedColor ?? '',
      "description" : descController.text,
      "model" : selectedBrand ?? '',
      "plateNumber" : numPlateController.text,
      "hourlyCost" : priceController.text,
      "dailyCost" : "${int.parse(priceController.text) * 24}",
      "seats" : selectedSeats ?? '',
      "doors" : selectedDoors ?? '',
      "lat" : "53.558330",
      "long" : "9.949830",
      "gear" : "A",
      "city" : selectedLocation ?? '',
    };

    var carAPIManager = CarAPIManager();
    var response = await carAPIManager.addCar(param, selectedImage);
    Navigator.pop(context);
    if (response) {
      // success login
      print(response);
      print("car add success");
      showSuccessAlertDialog(context);
    } else {
      // fail login
      Util.showToast("Unable to add your car this time. Please try again or later!");
      print("fail login");
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
    double _currentSliderValue = 20;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your Car"),
      ),
      body: filterData == null ?
      const Center(child: CircularProgressIndicator()) :
      Padding(
        padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: AlignmentDirectional.centerStart,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text('Title'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildTextField(
                  controller: titleController,
                  hint: "Set title",
                  inputType: TextInputType.text,
                  isObscureText: false,
                  key: _titleKey,
                ),
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: const Text('Description'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildTextView(
                  controller: descController,
                  hint: "Description...",
                  inputType: TextInputType.text,
                  isObscureText: false,
                  key: _descKey,
                ),
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: const Text('Price - Per Hour (\$)'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildTextField(
                  controller: priceController,
                  hint: "Set price",
                  inputType: TextInputType.text,
                  isObscureText: false,
                  key: _priceKey,
                ),
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: const Text('Number Plate'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildTextField(
                  controller: numPlateController,
                  hint: "Enter your car number plate!",
                  inputType: TextInputType.text,
                  isObscureText: false,
                  key: _numPlateKey,
                ),
              ),
              dropDownFilter('City', locations,
                      (newValue) => {

                    selectedLocation = newValue!,
                    setState((){}),
                  },
                  selectedLocation, 'Select city'),
              dropDownFilter('Brand', filterData?.brand,
                      (newValue) => {selectedBrand = newValue!,
                    setState((){}),},
                  selectedBrand, 'Select Car Brand'),
              dropDownFilter(
                  'Pick-up/delivery type',
                  pickupDeliveryTypes,
                      (newValue) => {selectedPickupDeliveryType = newValue!,
                    setState((){}),},
                  selectedPickupDeliveryType, 'Select Pick-up/delivery type'),
              dropDownFilter('Car Type', filterData?.type,
                      (newValue) => {selectedCarType = newValue!,
                    setState((){}),}, selectedCarType, 'Select car type'),
              dropDownFilter('Color', filterData?.color,
                      (newValue) => {selectedColor = newValue!,
                    setState((){}),}, selectedColor, 'Select color'),
              dropDownFilter('Seats', seats,
                      (newValue) => {selectedSeats = newValue!,
                    setState((){}),}, selectedSeats, 'Select seats'),
              dropDownFilter('Doors', doors,
                      (newValue) => {selectedDoors = newValue!,
                    setState((){}),}, selectedDoors, 'Select doors'),
              dropDownFilter('Fuel Type', filterData?.fuel,
                      (newValue) => {selectedFuelType = newValue!,
                    setState((){}),}, selectedFuelType, 'Select fuel type'),
              dropDownFilter('Car Transmission', filterData?.gear,
                      (newValue) => {selectedTransmissionType = newValue!,setState((){}),}, selectedTransmissionType, 'Select car transmission'),
              Container(
                alignment: AlignmentDirectional.centerStart,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text('Upload Image'),
              ),
              GestureDetector(
                onTap: () async {
                  print('upload image');
                  selectedImage = await picker.pickImage(source: ImageSource.gallery);
                  var source = ImageSource.gallery;
                  XFile? image = await picker.pickImage(
                      source: source, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
                  uploadImageText = '1 Image selected';
                  setState(() {
                    selectedImage = File(image?.path ?? "");
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(uploadImageText ?? ''),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: style,
                onPressed: () {
                  if (validateAllFields()) {
                    print('good to go!');
                    AddCar();
                  }
                },
                child: const Text('Submit'),
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

  Widget buildTextField(
      {TextEditingController? controller,
        String? hint,
        TextInputType? inputType,
        required bool isObscureText,
        GlobalKey<FormState>? key}) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextFormField(
            key: key,
            controller: controller,
            autofocus: false,
            obscureText: isObscureText,
            keyboardType: inputType,
            decoration: decoration(hint!),
          ),
        ),
      ),
    );
  }


  Widget buildTextView(
      {TextEditingController? controller,
        String? hint,
        TextInputType? inputType,
        required bool isObscureText,
        GlobalKey<FormState>? key}) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: TextField(
          key: key,
          controller: controller,
          autofocus: false,
          obscureText: isObscureText,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: decoration(hint!),
        ),
      ),
    );
  }

  InputDecoration decoration(String title) {
    return InputDecoration(
      hintText: title,
      hintStyle: const TextStyle(
        fontSize: 17.0,
        fontFamily: 'Poppins-Regular',
        // color: Color(0xff94A5A6),
      ),
      border: InputBorder.none,
    );
  }

  showSuccessAlertDialog(BuildContext context) {
    // set up the buttons
    Widget doneButton = FlatButton(
      child: Text("Done"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Text("Your car has been added successfully"),
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
