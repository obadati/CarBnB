import 'dart:convert';
import 'package:carbnb/network/misc_api_manager.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  static const String _title = 'FAQs';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
            Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool _customTileExpanded = false;

  final AsyncMemoizer _memoizer = AsyncMemoizer();
  var _response;

  Future<String> _fetchFAQs() async {
    return await this._memoizer.runOnce(() async {
      var faqAPIManager = MiscAPIManager();
      var response = await faqAPIManager.getFAQs();

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
    return FutureBuilder<String>(
      future: _fetchFAQs(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: _response.length,
            itemBuilder: (BuildContext context, int position) {
              return ExpansionTile(
                title: Text(_response.elementAt(position)["question"] == null ? "" : _response.elementAt(position)["question"]),
                children: <Widget>[
                  ListTile(title: Text(_response.elementAt(position)["answer"] == null ? "" : _response.elementAt(position)["answer"])),
                ]
              );
            }
          );
        } else {
          return Text("Loading...");
        }
      },
    );
  }
}