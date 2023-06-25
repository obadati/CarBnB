import 'dart:convert';
import 'dart:ui';

import 'package:carbnb/App/app_state_manager.dart';
import 'package:carbnb/App/login_pref.dart';
import 'package:carbnb/models/user_model.dart';
import 'package:carbnb/network/user_api_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carbnb/config/constants.dart';
import 'package:carbnb/screens/user/signup_screen.dart';
import 'package:carbnb/utils/Util.dart';
import 'package:carbnb/utils/common_widget/progress_dialog.dart';
import 'package:carbnb/widgets/widgets.dart';
import '../HomeScreen/tab_bar_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool validateAllFields() {
    if (emailController.text.isEmpty) {
      Util.showToast("Please enter email address");
      return false;
    } else if (passwordController.text.isEmpty) {
      Util.showToast("Please enter password");
      return false;
    }
    return true;
  }

  void loginUser() async {
    Util.showProgressDialog(context);
    var userAPIManager = UserAPIManager();
    var response = await userAPIManager.loginUserWith(emailController.text, passwordController.text);
    Navigator.pop(context);
    if (response != null) {
      // success login
      print(response.body);
      UserModel userModel = UserModel.fromJson(jsonDecode(response.body));
      UserPref.setLoginStatus(true);
      UserPref.setUserData(json.encode(userModel.toJson()));
      AppStateManager.shared.loginUser = userModel;
      Util.pushAndRemoveUntil(context, TabBarScreen());
    } else {
      // fail login
      Util.showToast("Login fail");
      print("fail login");
    }
  }

  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(color: Colors.transparent, isWhiteForground: false);
    final size = MediaQuery.of(context).size;
    final body = Center(child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("${Constants.imagesPath}splash-bg.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.7),BlendMode.dstATop)
          // colorFilter: ColorFilter(),
        ),
      ),
      child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
              child: ListView(
                children: <Widget>[

                  buildTopImage(),
                  SizedBox(
                    height: 50.0,
                  ),
                  buildEmailAdressField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  buildPasswordField(),
                  SizedBox(
                    height: 15.0,
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
//                    Util.pushAndRemoveUntil(context, ForgotPasswordScreen());
//                     Util.navigateView(context, ForgotPasswordScreen());
                        },
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    onTap: () {
                      // emailController.text = 'Ahmed@gmail.com';
                      // passwordController.text = '123456';
                      if (this.validateAllFields()) {
                        this.loginUser();
                      }
                    },
                    child: buildButton(context: context, title: "Login"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    onTap: () {
                      Util.navigateView(context, new SignUpScreen());
                    },
                    child: Center(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Register Now',
                            style: TextStyle(color: Colors.white, fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
//                   Center(
//                     child: InkWell(
//                       onTap: () {
// //                  Util.pushAndRemoveUntil(context, new SignUpScreen());
//                         Util.navigateView(context, new SignUpScreen());
//                       },
//                       child: Text(
//                         'Sign Up',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 22,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
                ],
              ),
            ),
          )
      ),
    ),);

    return Scaffold(
//      backgroundColor: Colors.black,
      body: body,
    );
  }

  Widget buildTopImage() {
    return Container(
        height: 250,
        child: Image.asset(
          "${Constants.imagesPath}logo.png",
        ));
  }

  Widget buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          controller: passwordController,
          autofocus: false,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          decoration: decoration("Password", Icons.lock),
        ),
      ),
    );
  }

  Widget buildEmailAdressField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          controller: emailController,
          autofocus: false,
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          decoration: decoration("Email Address", Icons.email),
        ),
      ),
    );
  }

  InputDecoration decoration(String title, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.grey,
      ),
      hintText: title,
      hintStyle: TextStyle(
          fontSize: 17.0,
          fontFamily: 'Poppins-Regular',
          color: const Color(0xff94A5A6)),
      border: InputBorder.none,
    );
  }
}
