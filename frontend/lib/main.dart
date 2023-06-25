import 'package:flutter/material.dart';
import 'package:carbnb/screens/splash_screen.dart';

void main() {
//  runApp(MyApp());
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
//      title: 'Flutter Demo',
    home: SplashScreen(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //   production`
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
//      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}
