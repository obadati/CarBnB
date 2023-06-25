import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:async/async.dart';
import 'package:carbnb/config/constants.dart';
import 'package:carbnb/models/car_model.dart';
import 'package:carbnb/network/car_api_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../product_info.dart';

const LatLng SOURCE_LOCATION = LatLng(50.564376, 9.692645);
const LatLng DEST_LOCATION = LatLng(50.562277, 9.694662);

const LatLng CAR_4 = LatLng(50.561596, 9.684534);
const LatLng CAR_5 = LatLng(50.555270, 9.695692);

class MapScreen extends StatefulWidget {
  static GlobalKey<FormState> _firstNameKey = new GlobalKey<FormState>();

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  TextEditingController firstNameController = new TextEditingController();

  String selectedLocation = 'Frankfurt';

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

  var initLatLng;

  final AsyncMemoizer _memoizer = AsyncMemoizer();
  List<Car> filterCars = [];

  @override
  void initState() {
    super.initState();
  }

  Future? _fetchCarsOnLocation() async {
    // return await this._memoizer.runOnce(() async {
    var carAPIManager = CarAPIManager();
    var param = Map<String, String>();
    param["city"] = selectedLocation;
    var response = await carAPIManager.getCarByFilterData(param);

    if (response != null) {
      // setState(() {
      final parsedJson = jsonDecode(response.body);
      List<dynamic> list = json.decode(response.body);
      filterCars = [];
      for (var i = 0; i < list.length; i++) {
        filterCars.add(Car.fromJson(list[i]));
      }
      initLatLng = getInitialLatLng(selectedLocation);
      // });
      return jsonDecode(response.body);
    }
    // });
  }

  LatLng getInitialLatLng(String city) {
    switch (city) {
      case 'Frankfurt':
        {
          return LatLng(50.105160, 8.677560);
        }
        break;
      case 'Berlin':
        {
          return LatLng(52.521751, 13.411500);
        }
        break;
      case 'Hamburg':
        {
          return LatLng(53.550724, 9.981607);
        }
        break;
      case 'Munich':
        {
          return LatLng(48.134365, 11.563115);
        }
        break;
      case 'Cologne':
        {
          return LatLng(50.923349, 6.932998);
        }
        break;
      case 'Düsseldorf':
        {
          return LatLng(51.209267, 6.79653);
        }
        break;
      case 'Leipzig':
        {
          return LatLng(51.331647, 12.379598);
        }
        break;
      case 'Nuremberg':
        {
          return LatLng(49.447295, 11.079753);
        }
        break;
      case 'Fulda':
        {
          return LatLng(50.105160, 8.677560);
        }
        break;
      default:
        {
          return LatLng(50.105160, 8.677560);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carbnb"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.add,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: FutureBuilder(
          future: _fetchCarsOnLocation(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: dropDownFilter(
                        'Location',
                        locations,
                        (newValue) => {
                              // setState((){
                              selectedLocation = newValue!,
                              setState(() {})
                              // })
                            },
                        selectedLocation),
                  ),
                  Flexible(
                      flex: 1,
                      child: /*createMap()*/ MapSample(filterCars, initLatLng)),
                ],
              );
            } else {
              return Text("Loading...");
            }
          }),
    );
  }

  Widget buildTextField(
      {TextEditingController? controller,
      String? hint,
      TextInputType? inputType,
      required bool isObscureText,
      GlobalKey<FormState>? key}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.location_searching),
          labelText: 'Search Car by location',
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
        key: key,
        controller: controller,
        autofocus: false,
        obscureText: isObscureText,
        keyboardType: inputType,
        // decoration: decoration(hint!),
      ),
    );
  }

  InputDecoration decoration(String title) {
    return InputDecoration(
      hintText: title,
      hintStyle: TextStyle(
          fontSize: 17.0,
          fontFamily: 'Poppins-Regular',
          color: const Color(0xff94A5A6)),
      border: InputBorder.none,
    );
  }

  Widget dropDownFilter(String title, List<String> array,
      Function(String?) onChange, String defaultValue) {
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
            isExpanded: true,
            value: defaultValue,
            icon: const Icon(Icons.expand_more),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
            ),
            onChanged: onChange,
            items: array.map<DropdownMenuItem<String>>((String value) {
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

class MapSample extends StatefulWidget {
  final List<Car> carsData;
  final LatLng initLatLng;

  const MapSample(this.carsData, this.initLatLng);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  GoogleMapController? _controller;

  late BitmapDescriptor car1Pin;
  List<LatLng> carlocations = [];
  Set<Marker> _markers = Set<Marker>();

  var _pageController;
  int? prevPage;

  @override
  void initState() {
    super.initState();

    setInitialLocation();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController!.page!.toInt() != prevPage) {
      prevPage = _pageController!.page!.toInt();
      moveCamera();
    }
  }

  void setInitialLocation() {
    for (var i = 0; i < widget.carsData.length; i++) {
      var car = widget.carsData[i];
      carlocations.add(LatLng(double.parse(car.lat), double.parse(car.long)));
    }
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double x0 = 0.0;
    double x1 = 0.0;
    double y0 = 0.0;
    double y1 = 0.0;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }

  void setMarkerIcons(BuildContext context) async {
    car1Pin = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.0),
        '${Constants.imagesPath}car_3.png');
  }

  @override
  Widget build(BuildContext context) {
    setMarkerIcons(context);

    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: widget.initLatLng,
            zoom: 13.5,
            bearing: 45,
            tilt: 45,
          ),
          onMapCreated: mapCreated,
          markers: _markers,
          onTap: (LatLng loc) {
            setState(() {
              // this.pinPillPosition = PIN_INVISIBLE_POSITION;
              // this.userBadgeSelected = false;
            });
          },
        ),
        Positioned(
          bottom: 20.0,
          child: Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.carsData.length,
              itemBuilder: (BuildContext context, int index) {
                return _carsViewList(index);
              },
            ),
          ),
        )
      ],
    );
  }

  _carsViewList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, widget) {
        double value = 1;
        if (_pageController!.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            // moveCamera();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProductPage(
                  CarModel(car: widget.carsData[index]),
                ),
              ),
            );
            print('car press at index: ${index}');
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                            height: 90.0,
                            width: 90.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    "${Constants.base_image_url}${widget.carsData[index].carId}.jpg",
                                  ),

                                  // coffeeShops[index].thumbNail),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.carsData[index].brand,
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${widget.carsData[index].hourlyCost}€ per hour',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  width: 170.0,
                                  child: Text(
                                    widget.carsData[index].descriptionText,
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ])
                        ]))))
          ])),
    );
  }

  void showPinsOnMap() {
    setState(() {
      for (var i = 0; i < carlocations.length; i++) {
        _markers.add(Marker(
            infoWindow: InfoWindow(
                title: widget.carsData[i].brand,
                snippet: "${widget.carsData[i].hourlyCost}€ per hour"),
            markerId: MarkerId('${widget.carsData[i].carId}'),
            icon: car1Pin,
            position: carlocations[i],
            onTap: () {
              print('marker tap');
            }));
      }
      print(_markers.length);
    });
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
      showPinsOnMap();
    });
  }

  moveCamera() {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: carlocations[_pageController!.page!.toInt()],
        zoom: 16.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}
