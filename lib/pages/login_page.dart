// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:login_ui/pages/forgot_password_page.dart';
import 'package:login_ui/pages/profile_page.dart';
import 'package:login_ui/pages/registration_page.dart';
import 'package:login_ui/pages/widgets/header_widget.dart';
import 'package:login_ui/common/theme_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 130;
  Key _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String username = "", password = "";

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  /*//API
  login(username, password) async {
    username = _username.text;
    password = _password.text;

    if (username == "" || password == "") {
      Fluttertoast.showToast(
        msg: "username or password cannot be blank".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(username)) {
      Fluttertoast.showToast(
        msg: "Enter a valid username".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      Map data = {'s_username': username, 's_password': password};

      print(data.toString());

      final response = await http.post(
        Uri.parse("http://localhost:8080/osclass/login"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        //encoding: Encoding.getByName("utf-8")
      );

      //If data fetching is successful
      if (response.statusCode == 200) {
        print(response.body);
        final content = jsonDecode(response.body);

        if (content['pk_i_id'] != null) {                         //if (!content['error']) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
        } 
      }
      else if (response.statusCode == 500) {
        Fluttertoast.showToast(
          msg: "username or password invalid",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
        );
      }
    }
  }*/

  //API
  login(username, password) async {
    username = _username.text;
    password = _password.text;

    if (username == "" || password == "") {
      Fluttertoast.showToast(
        msg: "username or password cannot be blank".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      Map data = {'username': username, 'password': password};

      //print(data.toString());

      final response = await http.post(
          Uri.parse("http://192.168.0.102/localconnect/signin.php"),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: data,
          encoding: Encoding.getByName("utf-8"));

      //If data fetching is successful
      if (response.statusCode == 200) {
        print(response.body);
        final content = jsonDecode(response.body);

        if (!content['error']) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
        } else {
          Fluttertoast.showToast(
            msg: "Username or password invalid".tr,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: _headerHeight,
            child: HeaderWidget(_headerHeight, true, Icons.login_rounded),
          ),
          SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Text(
                        'Welcome'.tr,
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Sign in to your account'.tr,
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextField(
                                  controller: _username,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Name'.tr, 'Enter your user name'.tr),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextField(
                                  controller: _password,
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "Password".tr, "Enter your password".tr),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: 'Forgot your password?'.tr,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPasswordPage()));
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey),
                                  ),
                                ])),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  onPressed: () {
                                    login(username, password);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ProfilePage()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      "LOGIN".tr,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: "Don't have an account? ".tr),
                                  TextSpan(
                                    text: 'Create'.tr,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegistrationPage()));
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).accentColor),
                                  ),
                                ])),
                              )
                            ],
                          ))
                    ],
                  )))
        ]),
      ),
    );
  }
}
