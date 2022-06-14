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


class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool obscure = true;
  bool obscure2 = true;
  String username = "", password = "", password2 = "", phone = "", email = "" ;

  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _password2 = TextEditingController();
  TextEditingController _phone = TextEditingController();

  void _toggle() {
    setState(() {
      obscure = !obscure;
    });
  }

  signup(username, email, password, password2, phone) async {

    username = _username.text;
    email = _email.text;
    password = _password.text;
    password2 = _password2.text;
    phone = _phone.text;

    if (username == "" || password == "" || password2 == "" || email == "") {
      Fluttertoast.showToast(
        msg: "Username, email or password is blank".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      Map data = {'s_name': username, 's_email': email, 's_password': password, 's_password2': password2, 's_phone_mobile' : phone};

      String url = "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/user/";

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
        print(response.body);

        Fluttertoast.showToast(
          msg: "${content['message']}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        Fluttertoast.showToast(
          msg: "${content['message']}",
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
                            height: MediaQuery.of(context).size.height * 0.08,
                            decoration: BoxDecoration(
                                color: LoginUIColors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        width: 0.5,
                                        color: LoginUIColors.muted))),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                 Center(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Text("Create account".tr,
                                        style: TextStyle(
                                            color: LoginUIColors.text,
                                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                                  )),
                                // Divider(height: 1,)     
                              ],
                            ),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.7,
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: _username,
                                              autofocus: false,
                                              cursorColor: LoginUIColors.muted,
                                              style:TextStyle(fontSize: 14.0, color: LoginUIColors.initial),
                                                textAlignVertical: TextAlignVertical(y: 0.6),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: LoginUIColors.white,
                                                hintStyle: TextStyle(
                                                  color: LoginUIColors.muted,
                                                ),
                                                prefixIcon: Icon(Icons.school),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.0),
                                                    borderSide: BorderSide(
                                                        color: LoginUIColors.border, width: 1.0, style: BorderStyle.solid)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.0),
                                                    borderSide: BorderSide(
                                                        color: LoginUIColors.border, width: 1.0, style: BorderStyle.solid)),
                                                hintText: "Name".tr)
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: _email,
                                              keyboardType: TextInputType.emailAddress,
                                              autofocus: false,
                                              cursorColor: LoginUIColors.muted,
                                              style:TextStyle(fontSize: 14.0, color: LoginUIColors.initial),
                                                textAlignVertical: TextAlignVertical(y: 0.6),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: LoginUIColors.white,
                                                hintStyle: TextStyle(
                                                  color: LoginUIColors.muted,
                                                ),
                                                prefixIcon: Icon(Icons.email),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.0),
                                                    borderSide: BorderSide(
                                                        color: LoginUIColors.border, width: 1.0, style: BorderStyle.solid)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.0),
                                                    borderSide: BorderSide(
                                                        color: LoginUIColors.border, width: 1.0, style: BorderStyle.solid)),
                                                hintText: "Email".tr)
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: _password,
                                              obscureText: obscure,
                                              autofocus: false,
                                              cursorColor: LoginUIColors.muted,
                                              style:TextStyle(fontSize: 14.0, color: LoginUIColors.initial),
                                                textAlignVertical: TextAlignVertical(y: 0.6),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: LoginUIColors.white,
                                                hintStyle: TextStyle(
                                                  color: LoginUIColors.muted,
                                                ),
                                                prefixIcon: Padding(
                                                  padding: EdgeInsets.only(right: 5),
                                                  child: GestureDetector(
                                                    child: obscure
                                                        ? Icon(Icons.lock)
                                                        : Icon(Icons.lock_open),
                                                    onTap: _toggle,
                                                  ),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.0),
                                                    borderSide: BorderSide(
                                                        color: LoginUIColors.border, width: 1.0, style: BorderStyle.solid)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.0),
                                                    borderSide: BorderSide(
                                                        color: LoginUIColors.border, width: 1.0, style: BorderStyle.solid)),
                                                hintText: "Password".tr)
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: _password2,
                                              obscureText: obscure,
                                              autofocus: false,
                                              cursorColor: LoginUIColors.muted,
                                              style:TextStyle(fontSize: 14.0, color: LoginUIColors.initial),
                                                textAlignVertical: TextAlignVertical(y: 0.6),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: LoginUIColors.white,
                                                hintStyle: TextStyle(
                                                  color: LoginUIColors.muted,
                                                ),
                                                prefixIcon: Padding(
                                                  padding: EdgeInsets.only(right: 5),
                                                  child: GestureDetector(
                                                    child: obscure
                                                        ? Icon(Icons.lock)
                                                        : Icon(Icons.lock_open),
                                                    onTap: _toggle,
                                                  ),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.0),
                                                    borderSide: BorderSide(
                                                        color: LoginUIColors.border, width: 1.0, style: BorderStyle.solid)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.0),
                                                    borderSide: BorderSide(
                                                        color: LoginUIColors.border, width: 1.0, style: BorderStyle.solid)),
                                                hintText: "Confirm Password".tr)
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: _phone,
                                              autofocus: false,
                                              cursorColor: LoginUIColors.muted,
                                              style:TextStyle(fontSize: 14.0, color: LoginUIColors.initial),
                                                textAlignVertical: TextAlignVertical(y: 0.6),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: LoginUIColors.white,
                                                hintStyle: TextStyle(
                                                  color: LoginUIColors.muted,
                                                ),
                                                prefixIcon: Icon(Icons.phone),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.0),
                                                    borderSide: BorderSide(
                                                        color: LoginUIColors.border, width: 1.0, style: BorderStyle.solid)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.0),
                                                    borderSide: BorderSide(
                                                        color: LoginUIColors.border, width: 1.0, style: BorderStyle.solid)),
                                                hintText: "Phone".tr)
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                            //child: Text('Don\'t have an account? Create'),
                                            child: Text.rich(TextSpan(children: [
                                              TextSpan(text: "You have an account? ".tr),
                                              TextSpan(
                                                text: 'Sign in'.tr,
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
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Center(
                                          child: FlatButton(
                                            textColor: LoginUIColors.white,
                                            color: LoginUIColors.primary,
                                            onPressed: () {
                                              signup(username, email, password, password2, phone);
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
                                                child: Text("REGISTER".tr,
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