// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, curly_braces_in_flow_control_structures, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_ui/pages/logout_page.dart';
import 'package:login_ui/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/Theme.dart';
import '../home_page.dart';
import 'drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  final String currentPage;
  MyDrawer({required this.currentPage});

  String loggedIn = '';
  Future getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('loggedIn') != null) {
      loggedIn = preferences.getString('loggedIn')!;
    }
    //email = preferences.getString('email');
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo();

    return Drawer(
        child: Container(
      color: LoginUIColors.white,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 26),
                  child: Image.asset(
                    'assets/images/allmenkul.jpg',
                    height: 40,
                  ),
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 44, left: 16, right: 16),
            children: [
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Home")
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false);
                  },
                  iconColor: LoginUIColors.primary,
                  title: "Home".tr,
                  isSelected: currentPage == "Home" ? true : false),
              DrawerTile(
                  icon: Icons.pie_chart,
                  onTap: () {
                    if (currentPage != "Profile")
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                  },
                  iconColor: LoginUIColors.warning,
                  title: "Profile".tr,
                  isSelected: currentPage == "Profile" ? true : false),
              DrawerTile(
                  icon: Icons.settings,
                  onTap: () {
                    if (currentPage != "Settings") {}
                  },
                  iconColor: LoginUIColors.success,
                  title: "Settings".tr,
                  isSelected: currentPage == "Settings" ? true : false),
              //if (loggedIn == 'true') ...[
                DrawerTile(
                  icon: Icons.logout,
                  onTap: () {
                    if (currentPage != "Logout") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogoutPage()));
                    }
                  },
                  iconColor: LoginUIColors.error,
                  title: "Logout".tr,
                  isSelected: currentPage == "Settings" ? true : false),
              //],
            ],
          ),
        ),
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
                      isSelected:
                          currentPage == "Getting started" ? true : false),
                ],
              )),
        ),
      ]),
    ));
  }
}
