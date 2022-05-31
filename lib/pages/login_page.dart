// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, avoid_print

import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:login_ui/data/data.dart';
import 'package:login_ui/pages/forgot_password_page.dart';
import 'package:login_ui/pages/profile_page.dart';
import 'package:login_ui/pages/registration_page.dart';
import 'package:login_ui/pages/widgets/header_widget.dart';
import 'package:login_ui/common/theme_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 130;
  Key _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String email = "", password = "";

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  // Toggles the password show status
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
        //preferences.setString('phone', content['user']['s_phone_mobile']);

        print(response.body);

        preferences.setString('refresh_token', content['refresh_token']);
        preferences.setString('access_token', content['access_token']);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));

        // else {
        //   Fluttertoast.showToast(
        //     msg: "email or password invalid".tr,
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.SNACKBAR,
        //   );
        // }
      } else {
        EasyLoading.dismiss();
        print(response.body);
        Fluttertoast.showToast(
          msg: "email or password invalid".tr, //"${content['message']}", //"email or password invalid".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
        );
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
                                  controller: _email,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Email'.tr, 'Enter your email'.tr),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextField(
                                  controller: _password,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                      labelText: "Password".tr,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400)),
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: GestureDetector(
                                          child: _obscureText
                                              ? Icon(Icons.lock)
                                              : Icon(Icons.lock_open),
                                          onTap: _toggle,
                                        ),
                                      )),
                                ),
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
                                    login(email, password);
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
                              ),
                              SizedBox(height: 20),
                              FloatingActionButton.extended(
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/images/google-logo.png',
                                  height: 25,
                                  width: 25,
                                ),
                                label: Text(
                                  'Sign In with Google'.tr,
                                  style: TextStyle(
                                    color: Colors.black
                                  )),
                                backgroundColor: Colors.white,
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
