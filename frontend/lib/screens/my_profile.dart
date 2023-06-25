import 'package:carbnb/App/login_pref.dart';
import 'package:carbnb/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class My_Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile',
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
          title: const Text('My Profile'),
        ),
        body: new MyStatefulWidget(),
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
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  late User _user;

  Future<String> _getUserData() async {
    return await this._memoizer.runOnce(() async {
      UserModel? userModel = await UserPref.getUserData();
      User? user = userModel?.user;
      if (userModel != null) {
        setState(() {
          _user = user!;
        });
        return user;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getUserData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blue.shade300],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.5, 0.9],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          minRadius: 60.0,
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _user.firstName + " " + _user.lastName,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _user.email,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'User name',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _user.firstName + " " + _user.lastName,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Phone number',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        (() {
                          if (_user.phoneNumber != null) {
                            var buffer = StringBuffer();
                            buffer.write(_user.phoneNumber);
                            return buffer.toString();
                          } else {
                            return "";
                          }
                        }()),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Birth date',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        (() {
                          if (_user.birthdate != null) {
                            // var buffer = StringBuffer();
                            // buffer.write(_user.birthdate.day.toString());
                            // buffer.write(".");
                            // buffer.write(_user.birthdate?.month.toString());
                            // buffer.write(".");
                            // buffer.write(_user.birthdate?.year.toString());
                            // return buffer.toString();
                            return _user.birthdate!;
                          } else {
                            return "";
                          }
                        }()),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        } else {
          return Text("Loading...");
        }
      },
    );
  }
}
