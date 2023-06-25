import 'package:flutter/material.dart';
import 'package:carbnb/Utils/MyColors.dart';

changeStatusBarColor({required Color color, required bool isWhiteForground}) async {
  // await FlutterStatusbarcolor.setStatusBarColor(color);
  // if (useWhiteForeground(color)) {
  //   FlutterStatusbarcolor.setStatusBarWhiteForeground(isWhiteForground);
  // } else {
  //   FlutterStatusbarcolor.setStatusBarWhiteForeground(!isWhiteForground);
  // }
}

Widget buildButton({required BuildContext context, required String title}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical: 15.0),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Center(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
