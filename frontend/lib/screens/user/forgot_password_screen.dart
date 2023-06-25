// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:meditationapp/config/constants.dart';
// import 'package:meditationapp/utils/MyColors.dart';
// import 'package:meditationapp/utils/Util.dart';
// import 'package:meditationapp/widget/widgets.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import '../../utils/Util.dart';
//
// class ForgotPasswordScreen extends StatefulWidget {
//   @override
//   _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
// }
//
// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   TextEditingController emailController = new TextEditingController();
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     changeStatusBarColor(color: Colors.black, isWhiteForground: true);
//
//     Widget buildTopImage() {
//       return Container(
//           height: 200,
//           child: Image.asset(
//             "${Constants.imagesPath}logo.png",
//           ));
//     }
//
//     final appBar = AppBar(
//       elevation: 0,
//       backgroundColor: Colors.black,
//       leading: IconButton(
//         onPressed: () {
//           Navigator.pop(context);
// //          Util.popAndRemoveUntil(context);
//         },
//         icon: Icon(
//           Icons.arrow_back_ios,
//           color: Colors.white,
//         ),
//       ),
//       title: Text(
//         "Forgot Password",
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//
//     final body = SafeArea(
//         child: Container(
//       width: MediaQuery.of(context).size.width,
//       color: Colors.black,
// //      decoration: BoxDecoration(
// ////        gradient: gradientBackgroundColor,
// //      ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
//         child: Column(
//           children: <Widget>[
//             Container(
//               height: (MediaQuery.of(context).size.height) * 0.25,
//               child: Container(
//                 height: 220,
//                 width: 220,
//                 child: buildTopImage(),
//               ),
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Text(
//               "Enter your registration email address to receive the instruction link resetting your password.",
//               style: TextStyle(fontSize: 17.0),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(
//               height: 30.0,
//             ),
// //            buildTextField(
// //              controller: emailController,
// //              hint: "Email Address",
// //              inputType: TextInputType.emailAddress,
// //              isObscureText: false,
// //            ),
//             buildEmailAdressField(),
//             SizedBox(
//               height: 30.0,
//             ),
//             InkWell(
//               onTap: () {
//                 if (emailController.text.isNotEmpty) {
//                   _auth
//                       .sendPasswordResetEmail(email: emailController.text)
//                       .then((value) => {
//                             Util.showToast(
//                                 "Reset Password email has been sent to your email address.")
//                           });
//                 }
//               },
//               child: buildButton(context: context, title: "Send Reset Link"),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//           ],
//         ),
//       ),
//     ));
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: appBar,
//       backgroundColor: Colors.black,
//       body: Container(color: Colors.black, child: body),
//     );
//   }
//
// //  Widget buildTextField(
// //      {TextEditingController controller,
// //      String hint,
// //      TextInputType inputType,
// //      bool isObscureText}) {
// //    return Container(
// //      decoration: BoxDecoration(
// //        color: Colors.black,
// //        border: Border.all(color: Colors.white),
// //        borderRadius: BorderRadius.circular(7.0),
// //      ),
// //      child: Padding(
// //        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
// //        child: TextFormField(
// //          key: new UniqueKey(),
// //          controller: controller,
// //          autofocus: false,
// //          obscureText: isObscureText,
// //          keyboardType: inputType,
// //          decoration: decoration(hint),
// //        ),
// //      ),
// //    );
// //  }
//
//   Widget buildEmailAdressField() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.black45,
//         border: Border.all(color: Colors.white),
//         borderRadius: BorderRadius.circular(5.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
//         child: TextFormField(
//           style: TextStyle(color: Colors.white),
//           controller: emailController,
//           autofocus: false,
//           obscureText: false,
//           keyboardType: TextInputType.emailAddress,
//           decoration: decoration("Email Address", Icons.email),
//         ),
//       ),
//     );
//   }
//
//   InputDecoration decoration(String title, IconData icon) {
//     return InputDecoration(
//       prefixIcon: Icon(
//         icon,
//         color: Colors.grey,
//       ),
//       hintText: title,
//       hintStyle: TextStyle(
//           fontSize: 17.0,
//           fontFamily: 'Poppins-Regular',
//           color: const Color(0xff94A5A6)),
//       border: InputBorder.none,
//     );
//   }
//
// //  InputDecoration decoration(String title) {
// //    return InputDecoration(
// //      hintText: title,
// //      prefixIcon: Icon(
// //        CupertinoIcons.mail,
// //        color: Colors.grey,
// //        size: 35,
// //      ),
// //      hintStyle: TextStyle(
// //          fontSize: 17.0,
// //          fontFamily: 'Poppins-Regular',
// //          color: const Color(0xff94A5A6)),
// //      border: InputBorder.none,
// //    );
// //  }
// }
