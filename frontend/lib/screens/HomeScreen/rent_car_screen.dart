import 'dart:convert';

import 'package:carbnb/config/constants.dart';
import 'package:carbnb/models/car_model.dart';
import 'package:carbnb/network/car_api_manager.dart';
import 'package:carbnb/screens/product_info.dart';
import 'package:carbnb/screens/add_car_screen.dart';
import 'package:carbnb/utils/Util.dart';
import 'package:carbnb/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:async/async.dart';

class RentCarScreen extends StatefulWidget {
  @override
  State<RentCarScreen> createState() => _RentCarScreenState();
}

class _RentCarScreenState extends State<RentCarScreen> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  var _response;
  List<Car> filteredCars = [];
  Map<String, String>? filterData;
  var base_image_url = "http://localhost:3000/images/";
  Future? _fetchCarsWith(Map<String, String>? paramData) async {
    var carAPIManager = CarAPIManager();
    // var param = Map<String, String>();
    // param["city"] = selectedLocation;
    var response = await carAPIManager
        .getCarByFilterData(paramData ?? Map<String, String>());
    if (response != null) {
      // setState(() {
      final parsedJson = jsonDecode(response.body);
      List<dynamic> list = json.decode(response.body);
      filteredCars = [];
      for (var i = 0; i < list.length; i++) {
        filteredCars.add(Car.fromJson(list[i]));
      }
      return jsonDecode(response.body);
    }
  }

  Future<String> _fetchCars() async {
    return await this._memoizer.runOnce(() async {
      var carAPIManager = CarAPIManager();
      var response = await carAPIManager.getCars();

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
        title: Text("Carbnb"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Util.navigateView(context, new AddCarScreen());
                },
                child: Icon(Icons.add),
              )),
        ],
      ),
      endDrawer: MainDrawer(
        onResult: (value) {
          filterData = value as Map<String,String>;
          print(filterData);
          setState(() {

          });

        }, filterData: filterData ?? {},),
      body: new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: getHomePageBody(context),
      ),
    );
  }

  getHomePageBody(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _fetchCarsWith(filterData),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.separated(
              padding: EdgeInsets.all(8.0),
              itemCount: filteredCars.length,
              itemBuilder: (BuildContext context, int position) {
                return _getItemUI(context, position);
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: 20,
                  ),
          );
        } else {
          return Text("Loading...");
        }
      },
    );
  }

  Widget _getItemUI(BuildContext context, int index) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 17));
    return Card(
      margin: EdgeInsets.only(bottom: 5),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,
      child: Container(
        child: Column(
          children: [
            Container(
              height: 140.0,
              width: double.infinity,
              child:
                  // Image.asset("" + _allCities[index].image!, fit: BoxFit.cover),
                  FadeInImage.assetNetwork(
                placeholder: "${Constants.imagesPath}loading.gif",
                image:
                    "${Constants.base_image_url}${filteredCars[index].carId}.jpg",
                fit: BoxFit.cover,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.only(
                  left: 15.0, top: 8, right: 15.0, bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${filteredCars[index].brand} is available in ${filteredCars[index].city}', // _response[index]["brand"]!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${filteredCars[index].hourlyCost}€ per hour",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpandableText(
                    /*longDummyText*/
                    filteredCars[index].descriptionText,
                    trimLines: 1,
                  )
                ],
              ),
            ),
            Container(
              height: Theme.of(context).buttonTheme.height,
              child: ButtonTheme(
                minWidth: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProductPage(CarModel(car: filteredCars[index])),
                      ),
                    );
                  },
                  color: Colors.blue,
                  child: const Text(
                    'Get Details',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    Key? key,
    this.trimLines = 2,
  })  : assert(text != null),
        super(key: key);

  final String text;
  final int trimLines;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    final colorClickableText = Colors.blue;
    final widgetColor = Colors.black;
    TextSpan link = TextSpan(
        text: _readMore ? "... read more" : " read less",
        style: TextStyle(
          color: colorClickableText,
        ),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          text: widget.text,
        );
        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection.rtl,
          //better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int? endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset);
        var textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style: TextStyle(
              color: widgetColor,
            ),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
          );
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}
