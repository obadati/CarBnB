import 'package:carbnb/App/login_pref.dart';
import 'package:carbnb/screens/HomeScreen/tab_bar_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:carbnb/app/login_pref.dart';
import 'package:carbnb/config/constants.dart';
import 'package:carbnb/utils/MyColors.dart';
import 'package:carbnb/utils/Util.dart';
import 'package:carbnb/Widgets/Widgets.dart';

import 'User/login_screen.dart';

//import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
//class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    changeStatusBarColor(color: gradientStartColor, isWhiteForground: true);
//     final size = MediaQuery.of(context).size;
    Future.delayed(const Duration(seconds: 3), () {
      // Util.pushAndRemoveUntil(context, new LoginScreen());
      UserPref.getLoginStatus().then((value) => {
            if (value)
              {
                Util.pushAndRemoveUntil(context, TabBarScreen()),
              }
            else
              {
                Util.pushAndRemoveUntil(context, LoginScreen()),
              }
          });
    });

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("${Constants.imagesPath}splash-bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 120),
                child: Text(
                  "IT'S TIME TO GO!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
      ),
    );
  }
}
