import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, curly_braces_in_flow_control_structures, use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:login_ui/constants/Theme.dart';
import 'package:login_ui/pages/login.dart';
import 'package:login_ui/pages/logout_page.dart';
import 'package:login_ui/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardSmall extends StatelessWidget {
  CardSmall(
      {this.title = "Placeholder Title",
      this.cta = "",
      this.img = "https://via.placeholder.com/200",
      this.tap = defaultFunc});

  final String cta;
  final String img;
  final Function()? tap;
  final String title;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
      height: 235,
      child: GestureDetector(
        onTap: tap,
        child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 2,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6.0),
                                topRight: Radius.circular(6.0)),
                            image: DecorationImage(
                              image: NetworkImage(img),
                              fit: BoxFit.cover,
                            )))),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  color: LoginUIColors.header, fontSize: 13)),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(cta,
                                style: TextStyle(
                                    color: LoginUIColors.primary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                          )
                        ],
                      ),
                    ))
              ],
            )),
      ),
    ));
  }
}
