// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/Theme.dart';
import 'drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  final String currentPage;
  const MyDrawer({required this.currentPage});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: LoginUIColors.primary,
        child: Column(
          children: [
            SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 20.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                          'assets/images/allmenkul.jpg' //'assets/images/newlogo.svg',
                          ),),
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 5, color: Colors.white),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 20,
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: IconButton(
                          icon: Icon(Icons.menu,
                              color: LoginUIColors.white.withOpacity(0.82),
                              size: 24.0),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                  ],
                ),
              ),
            )),
            Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 36, left: 8, right: 16),
            children: [
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Home")
                      Navigator.pushReplacementNamed(context, '/home');
                  },
                  iconColor: LoginUIColors.primary,
                  title: "Home",
                  isSelected: currentPage == "Home" ? true : false),
              DrawerTile(
                  icon: Icons.settings_input_component,
                  onTap: () {
                    if (currentPage != "Components")
                      Navigator.pushReplacementNamed(context, '/components');
                  },
                  iconColor: LoginUIColors.error,
                  title: "Components",
                  isSelected: currentPage == "Components" ? true : false),
              DrawerTile(
                  icon: Icons.post_add_sharp,
                  onTap: () {
                    if (currentPage != "Articles")
                      Navigator.pushReplacementNamed(context, '/articles');
                  },
                  iconColor: LoginUIColors.primary,
                  title: "Articles",
                  isSelected: currentPage == "Articles" ? true : false),
              DrawerTile(
                  icon: Icons.person,
                  onTap: () {
                    if (currentPage != "Profile")
                      Navigator.pushReplacementNamed(context, '/profile');
                  },
                  iconColor: LoginUIColors.warning,
                  title: "Profile",
                  isSelected: currentPage == "Profile" ? true : false),
              DrawerTile(
                  icon: Icons.account_box,
                  onTap: () {
                    if (currentPage != "Account")
                      Navigator.pushReplacementNamed(context, '/account');
                  },
                  iconColor: LoginUIColors.info,
                  title: "Account",
                  isSelected: currentPage == "Account" ? true : false),
              DrawerTile(
                  icon: Icons.settings,
                  onTap: () {
                    if (currentPage != "Settings")
                      Navigator.pushReplacementNamed(context, '/settings');
                  },
                  iconColor:LoginUIColors.info,
                  title: "Settings".tr,
                  isSelected: currentPage == "Settings" ? true : false),
            ],
          ),
        ),
          ],
        ),
      ),
    );
  }
}
