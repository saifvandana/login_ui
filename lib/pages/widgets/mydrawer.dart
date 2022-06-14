// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, curly_braces_in_flow_control_structures, use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:login_ui/pages/logout_page.dart';
import 'package:login_ui/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/Theme.dart';
import '../home_page.dart';
import 'drawer_tile.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer(this.currentPage);

  final String currentPage;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String loggedIn = '';
  String imageUrl = '', name = '', phone = '', avg = '', id = ''; //, img = '';
  bool hasImage = false, loading = true;

  @override
  void initState() {
    super.initState();
    getUserInfo();
    // if (loggedIn == 'true') {
    //   getAvgRating();
    // }
  }

  Future getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('loggedIn') != null) {
      loggedIn = preferences.getString('loggedIn')!;
    }

    if (loggedIn == 'true') {
      setState(() {
        name = preferences.getString('name')!;
        id = preferences.getString('id')!;
        getAvgRating();
      });

      var url =
          "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/profile/" +
              id;
      var response = await http.get(Uri.parse(url));
      var content = json.decode(response.body);
      print(content);
      if (content['hasImage'] == 'true') {
        print('true');
        setState(() {
          imageUrl = content["url"];
          hasImage = true;
        });
      } else {
        print('false');
        print(content);
      }
    }
    //email = preferences.getString('email');
  }

  Future getAvgRating() async {
    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/rating/useravg/" +
            id;
    var response = await http.get(Uri.parse(url));
    var content = json.decode(response.body);
    if (content["d_average"].toString().isNotEmpty) {
      setState(() {
        avg = content["d_average"].toString().substring(0, 3);
      });
    }
    print('avg = ' + avg);
  }

  Future logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var rToken = preferences.getString('refresh_token');
    Map data = {'refresh_token': rToken};

    String url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/user/logout";

    EasyLoading.show(status: 'loggin out...'.tr);
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
      EasyLoading.dismiss();
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
    } else {
      EasyLoading.dismiss();
      Fluttertoast.showToast(
        msg: "User cannot out".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          child: Column(children: [
        DrawerHeader(
            decoration: BoxDecoration(color: LoginUIColors.primary),
            child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: hasImage
                      ? CircleAvatar(
                          child: Image.network(
                          "https://allmenkul.com/oc-content/plugins/profile_picture/images/" +
                              imageUrl,
                          fit: BoxFit.fill,
                        ))
                      : Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey.shade300,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
                  child: Text(name,
                      style: TextStyle(color: Colors.white, fontSize: 21)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: LoginUIColors.label),
                            child: Text("Pro",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text("Seller",
                            style: TextStyle(
                                color: LoginUIColors.muted, fontSize: 16)),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(avg,
                                style: TextStyle(
                                    color: LoginUIColors.warning,
                                    fontSize: 16)),
                          ),
                          Icon(Icons.star_border,
                              color: LoginUIColors.warning, size: 20)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ))),
        Expanded(
            flex: 3,
            child: ListView(
              padding: EdgeInsets.only(top: 8, left: 8, right: 8),
              children: [
                DrawerTile(
                    icon: Icons.home,
                    onTap: () {
                      if (widget.currentPage != "Home")
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false);
                    },
                    iconColor: LoginUIColors.primary,
                    title: "Home".tr,
                    isSelected: widget.currentPage == "Home" ? true : false),
                DrawerTile(
                    icon: Icons.account_circle,
                    onTap: () {
                      if (widget.currentPage != "Profile")
                        Navigator.pushReplacementNamed(context, '/profile');
                    },
                    iconColor: Color.fromRGBO(255, 235, 59, 1),
                    title: "Profile".tr,
                    isSelected: widget.currentPage == "Profile" ? true : false),
                DrawerTile(
                    icon: Icons.settings,
                    onTap: () {
                      if (widget.currentPage != "Settings")
                        Navigator.pushReplacementNamed(context, '/settings');
                    },
                    iconColor: Colors.purple,
                    title: "Settings".tr,
                    isSelected:
                        widget.currentPage == "Settings" ? true : false),
                if (loggedIn == 'true') ...[
                  DrawerTile(
                      icon: Icons.logout,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return customDialog("Log Out".tr,
                                "Do you want to log out".tr, context);
                          },
                        );
                      },
                      iconColor: Colors.red,
                      title: "Log out".tr,
                      isSelected:
                          widget.currentPage == "Log out" ? true : false),
                ],
                if (loggedIn != 'true') ...[
                  DrawerTile(
                      icon: Icons.login,
                      onTap: () {},
                      iconColor: Colors.green,
                      title: "Log In".tr,
                      isSelected:
                          widget.currentPage == "Log In" ? true : false),
                  DrawerTile(
                      icon: Icons.person_add_alt_1,
                      onTap: () {},
                      iconColor: Colors.black,
                      title: "Register".tr,
                      isSelected:
                          widget.currentPage == "Register" ? true : false),
                ],
              ],
            )),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 4, thickness: 0, color: LoginUIColors.muted),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("DOCUMENTATION".tr,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 15,
                        )),
                  ),
                  DrawerTile(
                      icon: Icons.airplanemode_active,
                      onTap: () {},
                      iconColor: LoginUIColors.muted,
                      title: "Getting Started".tr,
                      isSelected: widget.currentPage == "Getting started"
                          ? true
                          : false),
                ],
              )),
        ),
      ])),
    );
  }

  AlertDialog customDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: Text(
            "Yes".tr,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            logOut();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            "No".tr,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(96, 0, 0, 0))),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
