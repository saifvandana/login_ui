// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, avoid_print

import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:login_ui/constants/Theme.dart';
import 'package:login_ui/pages/login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  TextEditingController _email = TextEditingController();

  Future forgotPassword() async {
    var url =
        'https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/user/forgot';

    if (_email.text == "") {
      Fluttertoast.showToast(
        msg: "email cannot be blank".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      Map data = {'s_email': _email.text};
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
        Fluttertoast.showToast(
          msg: "Password reminder has been sent to your email".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        Fluttertoast.showToast(
          msg: "${content['message']}", //"email or password invalid".tr,
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
                            height: MediaQuery.of(context).size.height * 0.1,
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
                                  child: Text('Forgot Password?'.tr,
                                      style: TextStyle(
                                          color: LoginUIColors.text,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                )),
                              ],
                            ),
                          ),
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
                                            top: 24.0, bottom: 0.0, left: 8),
                                        child: Center(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Enter the email address associated with your account.'
                                                  .tr,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                              child: Text(
                                                'We will email you a password recovery.'
                                                    .tr,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black38),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                          ],
                                        )),
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
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Center(
                                          child: FlatButton(
                                            textColor: LoginUIColors.white,
                                            color: LoginUIColors.primary,
                                            onPressed: () {
                                              forgotPassword();
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
                                                child: Text("SEND".tr,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16.0))),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 20, 10, 20),
                                        //child: Text('Don\'t have an account? Create'),
                                        child: Text.rich(TextSpan(children: [
                                          TextSpan(
                                              text: "Remembered your password? "
                                                  .tr),
                                          TextSpan(
                                            text: 'Login'.tr,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Login()));
                                              },
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: LoginUIColors.primary),
                                          ),
                                        ])),
                                      ),
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
