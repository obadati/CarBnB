import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutUs extends StatelessWidget {
  var html = '''
    <h1>CarBnb</h1>
    <p style="font-size: 16px">We are a young start up team of experienced IT specialists from the area of Fulda, which sets itself the goal to make customers dreams come true.  Each of our specialists is responsible for a different area of expertise - from programming to our front layout design.</p>
    
    <p style="font-size: 16px">Our team includes:</p>
    <ul style="font-size: 16px">
      <li>Ahmed</li>
      <li>Joshua</li>
      <li>Julia</li>
      <li>Julian</li>
      <li>Obada</li>
    </ul>
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: const Text("About CarBnb"),
          automaticallyImplyLeading: false,
        ),
        body: (Container(
            padding: EdgeInsets.all(10),
            child: Html(
              data: html,
            ))));
  }
}
