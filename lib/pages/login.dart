// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, avoid_print

import 'dart:convert';
import 'dart:ui';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:login_ui/constants/Theme.dart';
import 'package:login_ui/data/data.dart';
import 'package:login_ui/pages/forgot_password_page.dart';
import 'package:login_ui/pages/profile_page.dart';
import 'package:login_ui/pages/registration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot-password.dart';
import 'register.dart';
import 'widgets/input.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final double height = window.physicalSize.height;
  Key _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String email = "", password = "";

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //API
  login(email, password) async {
    email = _email.text;
    password = _password.text;

    if (email == "" || password == "") {
      Fluttertoast.showToast(
        msg: "email or password cannot be blank".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      Map data = {'email': email, 'password': password};

      //print(data.toString());
      String url =
          "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/user/login";

      EasyLoading.show(status: 'loggin in...'.tr);
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
      );

      final content = jsonDecode(response.body);
      //If data fetching is successful
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('email', email);
        preferences.setString('loggedIn', 'true');
        preferences.setString('name', content['user']['s_name']);
        preferences.setString('id', content['user']['pk_i_id']);
        if (content['user']['s_phone_mobile'].toString().isNotEmpty) {
          preferences.setString('phone', content['user']['s_phone_mobile']);
        }

        print(response.body);

        preferences.setString('refresh_token', content['refresh_token']);
        preferences.setString('access_token', content['access_token']);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
      } else {
        EasyLoading.dismiss();
        print(response.body);
        Fluttertoast.showToast(
          msg: "email or password invalid"
              .tr, //"${content['message']}", //"email or password invalid".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/register-bg.png"),
                      fit: BoxFit.cover)),
            ),
            SafeArea(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 25, left: 24.0, right: 24.0, bottom: 32),
                  child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                                color: LoginUIColors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        width: 0.5,
                                        color: LoginUIColors.muted))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.0,
                                  ),
                                  child: Text('Sign In with Google'.tr,
                                      style: TextStyle(
                                          color: LoginUIColors.text,
                                          fontSize: 15.0)),
                                )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, bottom: 8),
                                    child: FloatingActionButton.extended(
                                        onPressed: () {},
                                        icon: Image.asset(
                                          'assets/images/google-logo.png',
                                          height: 25,
                                          width: 25,
                                        ),
                                        label: Text('GOOGLE'.tr,
                                            style: TextStyle(
                                                color: LoginUIColors.primary,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13)),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ))),
                                //Divider(height: 1,)
                              ],
                            ),
                          ),
                          //ListView(children: [],),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              color: Color.fromRGBO(244, 245, 247, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 24.0, bottom: 0.0),
                                        child: Center(
                                            child: Column(
                                          children: [
                                            Text(
                                              'Welcome'.tr,
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Sign in to your account'.tr,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        )
                                            // Text(
                                            //     "Or sign up with the classic way",
                                            //     style: TextStyle(
                                            //         color: LoginUIColors.text,
                                            //         fontWeight: FontWeight.w200,
                                            //         fontSize: 16)),
                                            ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                                controller: _email,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                autofocus: false,
                                                cursorColor:
                                                    LoginUIColors.muted,
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color:
                                                        LoginUIColors.initial),
                                                textAlignVertical:
                                                    TextAlignVertical(y: 0.6),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        LoginUIColors.white,
                                                    hintStyle: TextStyle(
                                                      color:
                                                          LoginUIColors.muted,
                                                    ),
                                                    prefixIcon:
                                                        Icon(Icons.email),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                4.0),
                                                        borderSide: BorderSide(
                                                            color: LoginUIColors
                                                                .border,
                                                            width: 1.0,
                                                            style: BorderStyle
                                                                .solid)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                        borderSide: BorderSide(
                                                            color: LoginUIColors
                                                                .border,
                                                            width: 1.0,
                                                            style: BorderStyle
                                                                .solid)),
                                                    hintText: "Email".tr)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                                controller: _password,
                                                obscureText: _obscureText,
                                                autofocus: false,
                                                cursorColor:
                                                    LoginUIColors.muted,
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color:
                                                        LoginUIColors.initial),
                                                textAlignVertical:
                                                    TextAlignVertical(y: 0.6),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        LoginUIColors.white,
                                                    hintStyle: TextStyle(
                                                      color:
                                                          LoginUIColors.muted,
                                                    ),
                                                    prefixIcon: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 5),
                                                      child: GestureDetector(
                                                        child: _obscureText
                                                            ? Icon(Icons.lock)
                                                            : Icon(Icons
                                                                .lock_open),
                                                        onTap: _toggle,
                                                      ),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                        borderSide: BorderSide(
                                                            color: LoginUIColors
                                                                .border,
                                                            width: 1.0,
                                                            style: BorderStyle
                                                                .solid)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                        borderSide: BorderSide(
                                                            color: LoginUIColors
                                                                .border,
                                                            width: 1.0,
                                                            style: BorderStyle
                                                                .solid)),
                                                    hintText: "Password".tr)),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 10, 20),
                                            alignment: Alignment.topRight,
                                            child:
                                                Text.rich(TextSpan(children: [
                                              TextSpan(
                                                text:
                                                    'Forgot your password?'.tr,
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ForgotPassword()));
                                                      },
                                                style: TextStyle(
                                                    color: Colors.blueGrey),
                                              ),
                                            ])),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 20, 10, 20),
                                            //child: Text('Don\'t have an account? Create'),
                                            child:
                                                Text.rich(TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      "Don't have an account? "
                                                          .tr),
                                              TextSpan(
                                                text: 'Create'.tr,
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Register()));
                                                      },
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        LoginUIColors.primary),
                                              ),
                                            ])),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Center(
                                          child: FlatButton(
                                            textColor: LoginUIColors.white,
                                            color: LoginUIColors.primary,
                                            onPressed: () {
                                              login(email, password);
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                    top: 12,
                                                    bottom: 12),
                                                child: Text("LOGIN".tr,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16.0))),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      )),
                ),
              ]),
            )
          ],
        ));
  }
}
