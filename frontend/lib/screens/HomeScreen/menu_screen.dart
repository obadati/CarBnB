import 'package:carbnb/screens/my_requests.dart';
import 'package:carbnb/App/app_preferences.dart';
import 'package:carbnb/screens/product_info.dart';
import 'package:carbnb/screens/user/login_screen.dart';
import 'package:carbnb/screens/user/my_cars_screen.dart';
import 'package:carbnb/screens/user/my_orders.dart';

import 'package:carbnb/screens/FAQ.dart';
import 'package:carbnb/screens/about_us.dart';
import 'package:carbnb/screens/my_profile.dart';

import 'package:carbnb/utils/Util.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen() : super();

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  AppPreferences _appPreferences = AppPreferences();
  
  showLogoutAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("NO"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("YES"),
      onPressed: () {
        _appPreferences.clearPreferences();
        Util.pushAndRemoveUntil(context, new LoginScreen());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure want to logout?"),
      actions: [
        cancelButton,
        continueButton,
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
  
  Widget _myListView(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Messages'),
          subtitle: Text('Check Messages of Users')
        ),
        GestureDetector(
          onTap: (){
            Util.navigateView(context, My_Profile());
          },
          child: ListTile(
            title: Text('My Profile'),
          ),
        ),

        GestureDetector(
          onTap: () {
            Util.navigateView(context, MyCarsScreen());
          },
          child: const ListTile(
            title: Text('My Cars'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Util.navigateView(context, MyOrdersScreen());
          },
          child: ListTile(
            title: Text('My Orders'),
          ),
        ),
        GestureDetector(
         onTap: () {
           Util.navigateView(context, MyRequestsScreen());
          },
        child: ListTile(
          title: Text('My Requests'),
        ),
        ),
        GestureDetector(
          onTap: (){
            Util.navigateView(context, FAQ());
          },
          child: ListTile(
            title: Text('FAQs'),
              subtitle: Text('Check out the most frequently asked questions')
          ),
        ),
        GestureDetector(
          onTap: (){
            Util.navigateView(context, AboutUs());
          },
          child: ListTile(
            title: Text('About Us'),
          ),
        ),
        GestureDetector(
          onTap: (){
            this.showLogoutAlertDialog(context);
          },
          child: ListTile(
            title: Text('Logout'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carbnb"),
        automaticallyImplyLeading: false,
      ),
      body: _myListView(context),
    );
  }


}
