// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'registration_page.dart';
import 'package:login_ui/pages/widgets/header_widget.dart';
import 'package:login_ui/common/theme_helper.dart';

import 'login_page.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  double _headerHeight = 130;

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
                    'Login or Register',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    decoration: ThemeHelper().buttonBoxDecoration(context),
                    child: ElevatedButton(
                      style: ThemeHelper().buttonStyle(),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: Text(
                          "Login".toUpperCase(),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationPage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: Text(
                          "Register".toUpperCase(),
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
            )
          )
        ]),
      ),
    );
  }
}
