import 'dart:convert';
import 'dart:ui';
import 'package:carbnb/App/app_state_manager.dart';
import 'package:carbnb/App/login_pref.dart';
import 'package:carbnb/models/user_model.dart';
import 'package:carbnb/network/user_api_manager.dart';
import 'package:carbnb/screens/HomeScreen/tab_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:carbnb/config/constants.dart';
import 'package:carbnb/utils/Util.dart';
import 'package:carbnb/utils/common_widget/progress_dialog.dart';
import 'package:carbnb/widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static GlobalKey<FormState> _firstNameKey = new GlobalKey<FormState>();
  static GlobalKey<FormState> _lastNameKey = new GlobalKey<FormState>();
  static GlobalKey<FormState> _phoneNameKey = new GlobalKey<FormState>();
  static GlobalKey<FormState> _emailNameKey = new GlobalKey<FormState>();
  static GlobalKey<FormState> _passwordNameKey = new GlobalKey<FormState>();
  static GlobalKey<FormState> _confirmPasswordNameKey =
      new GlobalKey<FormState>();

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController zipController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  showProgressDialog() => showDialog(
      context: context, builder: (BuildContext context) => ProgressDialog());

  @override
  void initState() {
    changeStatusBarColor(color: Colors.grey, isWhiteForground: false);

    super.initState();
  }

  bool validateAllFields() {
    if (firstNameController.text.isEmpty) {
      Util.showToast("Please enter your first name.");
      return false;
    } else if (lastNameController.text.isEmpty) {
      Util.showToast("Please enter your last name.");
      return false;
    } else if (emailController.text.isEmpty) {
      Util.showToast("Please enter your email name.");
      return false;
    } else if (passwordController.text.isEmpty) {
      Util.showToast("Please enter your password.");
      return false;
    } else if (confirmPasswordController.text.isEmpty) {
      Util.showToast("Confirm your password.");
      return false;
    } else if (!validateEmail(emailController.text)) {
      Util.showToast("Please enter valid email address");
      return false;
    } else if (passwordController.text != confirmPasswordController.text) {
      Util.showToast("Confirm password is not same as password.");
      return false;
    }
    return true;
  }

  bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  void registerUser() async {
    Util.showProgressDialog(context);

    var userAPIManager = UserAPIManager();
    var response = await userAPIManager.registerUserWith(
        emailController.text,
        passwordController.text,
        firstNameController.text,
        lastNameController.text,
        phoneController.text);

    Navigator.pop(context);
    if (response != null) {
      UserModel userModel = UserModel.fromJson(jsonDecode(response.body));
      UserPref.setLoginStatus(true);
      UserPref.setUserData(json.encode(userModel.toJson()));
      AppStateManager.shared.loginUser = userModel;
      Util.pushAndRemoveUntil(context, TabBarScreen());
    } else {
      Util.showToast("Registration failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.blue,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Text(
        "Create Account",
        style: TextStyle(color: Colors.white),
      ),
    );

    final body = SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("${Constants.imagesPath}splash-bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: ListView(
            children: <Widget>[
              buildCircularImage(),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: <Widget>[
                    buildTextField(
                      controller: firstNameController,
                      hint: "First Name",
                      inputType: TextInputType.text,
                      isObscureText: false,
                      key: _firstNameKey,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildTextField(
                      controller: lastNameController,
                      hint: "Last Name",
                      inputType: TextInputType.text,
                      isObscureText: false,
                      key: _lastNameKey,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildTextField(
                      controller: phoneController,
                      hint: "Phone Number (Optional)",
                      inputType: TextInputType.phone,
                      isObscureText: false,
                      key: _phoneNameKey,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildTextField(
                      controller: emailController,
                      hint: "Email",
                      inputType: TextInputType.emailAddress,
                      isObscureText: false,
                      key: _emailNameKey,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildTextField(
                      controller: passwordController,
                      hint: "Password",
                      inputType: TextInputType.visiblePassword,
                      isObscureText: true,
                      key: _passwordNameKey,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildTextField(
                      controller: confirmPasswordController,
                      hint: "Confirm Password",
                      inputType: TextInputType.visiblePassword,
                      isObscureText: true,
                      key: _confirmPasswordNameKey,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      onTap: () {
//                      Util.pushAndRemoveUntil(context, new MainScreen());
                        if (this.validateAllFields()) {
                          this.registerUser();
                        }
                      },
                      child: buildButton(
                          context: context, title: "Create Account"),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar,
      body: body,
    );
  }

  Widget buildTopBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      color: Colors.black,
    );
  }

  Widget buildCircularImage() {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15.0),
            width: 260.0,
            height: 160.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("${Constants.imagesPath}logo.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTopImage() {
    return Container(
        height: 250,
        child: Image.asset(
          "${Constants.imagesPath}logo.jpeg",
        ));
  }

  Widget buildTextField(
      {TextEditingController? controller,
      String? hint,
      TextInputType? inputType,
      required bool isObscureText,
      GlobalKey<FormState>? key}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: TextFormField(
          key: key,
          controller: controller,
          autofocus: false,
          obscureText: isObscureText,
          keyboardType: inputType,
          decoration: decoration(hint!),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  InputDecoration decoration(String title) {
    return InputDecoration(
      hintText: title,
      hintStyle: TextStyle(
          fontSize: 17.0,
          fontFamily: 'Poppins-Regular',
          color: const Color(0xff94A5A6)),
      border: InputBorder.none,
    );
  }
}
