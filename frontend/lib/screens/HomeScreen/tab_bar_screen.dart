import 'package:carbnb/screens/about_us.dart';
import 'package:carbnb/screens/my_profile.dart';
import 'package:flutter/material.dart';

import 'rent_car_screen.dart';
import 'menu_screen.dart';
import 'map_screen.dart';


class TabBarScreen extends StatefulWidget {
  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
// class HomeController extends StatelessWidget {
   List<Map<String, Widget>> _pages = [
    {
      'page': RentCarScreen(),
    },
    {
      'page': MapScreen(),
    },
    {
      'page': MenuScreen(),
    }
  ];
  int _selectedIndex = 0; //New

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: (_pages[_selectedIndex]['page']),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '',
          ),
        ],
      ),
    );
  }
}