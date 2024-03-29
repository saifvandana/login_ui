// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_ui/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:login_ui/pages/widgets/header_widget.dart';
import 'package:login_ui/common/theme_helper.dart';
import 'package:get/get.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  double _headerHeight = 130;

  Future logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var rToken = preferences.getString('refresh_token');
    Map data = {'refresh_token': rToken};

    String url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/user/logout";

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: data,
    );
    
    final content = jsonDecode(response.body);

    if (content['status'] == 1) {

      preferences.remove('email');
      preferences.remove('loggedIn');
      preferences.remove('access_token');
      preferences.remove('refresh_token');
      
      Fluttertoast.showToast(
      msg: "User Logged out".tr,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: _headerHeight,
            child: HeaderWidget(_headerHeight, true, Icons.logout),
          ),
          SafeArea(
              child: Container(
            child: Column(
              children: [
                Text(
                  'Do you want to log out?'.tr,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30.0),
                Container(
                  decoration: ThemeHelper().buttonBoxDecoration(context),
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(),
                    onPressed: () {
                      logOut();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Text(
                        "YES".tr,
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
                  decoration: ThemeHelper().buttonBoxDecoration(context),
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Text(
                        "NO".tr,
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
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
