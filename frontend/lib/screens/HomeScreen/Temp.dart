import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<bool> purchaseType = [false, false, false];
  String propertyType = 'Apartment & Unit';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 1, 8, 1),
                      height: 50,
                      width: 100,
                      color: Colors.grey,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 1, 8, 1),
                      height: 50,
                      width: 100,
                      color: Colors.grey,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 1, 8, 1),
                      height: 50,
                      width: 100,
                      color: Colors.grey,
                    ),
                  ],
                ),
                ToggleButtons(
                  renderBorder: false,
                  selectedColor: Colors.white,
                  disabledColor: Colors.black,
                  highlightColor: Colors.black54,
                  fillColor: Colors.black,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                  isSelected: purchaseType,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 36,
                        width: 100,
                        child: Center(child: Text('Buy')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 36,
                        width: 100,
                        child: Center(child: Text('Rent')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 36,
                        width: 100,
                        child: Center(child: Text('Sell')),
                      ),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      var cursor = purchaseType.length - 1;
                      while (cursor >= 0) {
                        if (cursor == index) {
                          purchaseType[index] = !purchaseType[index];
                        } else {
                          purchaseType[cursor] = false;
                        }
                        cursor--;
                      }
                      // isSelected[index] = !isSelected[index];
                    });
                  },
                ),
              ],
            ),
            Container(
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: const Text('Property Type'),
            ),
            Container(
              height: 62,
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: propertyType,
                icon: const Icon(Icons.expand_more),
                iconSize: 24,
                elevation: 16,
                underline: Container(
                  height: 2,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    propertyType = newValue!;
                  });
                },
                items: <String>[
                  'Apartment & Unit',
                  'High-rise Unit',
                  'Single-family Home',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}