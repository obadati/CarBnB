import 'dart:convert';

import 'package:carbnb/App/login_pref.dart';
import 'package:carbnb/config/constants.dart';
import 'package:carbnb/models/car_model.dart';
import 'package:carbnb/models/user_model.dart';
import 'package:carbnb/network/order_api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:async/async.dart';
import '../product_info.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  var _response = [];

  Future<String> _fetchMyOrders() async {
    return await this._memoizer.runOnce(() async {
      var orderAPIManager = OrderAPIManager();

      UserModel? userModel = await UserPref.getUserData();

      var response =
          await orderAPIManager.getUserOrder(userModel?.user?.userId.toString() ?? '');

      if (response != null) {
        setState(() {
          _response = jsonDecode(response.body);
        });
        return jsonDecode(response.body);
      }
    });
  }

  void freeThisCar(int orderId) {
    var orderAPIManager = OrderAPIManager();
    orderAPIManager.updateOrderStatus(orderId, 3);
  }

  String getStatusString(int statusId) {
    String status = "";
    switch (statusId) {
      case 1:
        status = "Active";
        break;
      case 2:
        status = "Pending";
        break;
      case 3:
        status = "Finished";
        break;
      case 4:
        status = "Rejected";
        break;
      case 5:
        status = "Canceled";
        break;
    }

    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
      ),
      body: new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: getHomePageBody(context),
      ),
    );
  }

  getHomePageBody(BuildContext context) {
    return FutureBuilder<String>(
      future: _fetchMyOrders(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (_response.length == 0) {
            return const Text("You don't have any cars to list!");
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                padding: const EdgeInsets.all(8.0),
                  itemCount: _response.length,
                  itemBuilder: (BuildContext context, int position) {
                    return _getItemUI(context, position);
                  },
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
              ),
            );
          }
        } else {
          return const Text("Loading...");
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
              child: FadeInImage.assetNetwork(
                placeholder: "${Constants.imagesPath}loading.gif",
                image: (Constants.base_image_url +
                    '${_response[index]["carID"]}.jpg'),
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
                          _response[index]["brand"]! +
                              " " +
                              _response[index]["model"]!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          _response[index]["hourlyCost"]!.toString() +
                              "€ per hour",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Status: " +
                              getStatusString(_response[index]["statusID"]),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Visibility(
                          visible: _response[index]["statusID"] == 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: MaterialButton(
                              color: Colors.red,
                              child: const Text(
                                'Free this car',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              onPressed: () {
                                freeThisCar(_response[index]["orderID"]);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            super.widget));
                              },
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpandableText(
                    _response[index]["description"]!.toString(),
                    trimLines: 1,
                  ),
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
                            builder: (BuildContext context) => ProductPage(
                                CarModel.fromJson(_response[index]), false)));
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
