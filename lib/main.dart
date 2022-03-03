// ignore_for_file: deprecated_member_use, prefer_final_fields, must_be_immutable, use_key_in_widget_constructors, unnecessary_import, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login_ui/pages/home/home_screen.dart';
import 'package:login_ui/pages/login_page.dart';
import 'package:login_ui/pages/widgets/map_widget.dart';

import '/pages/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color _primaryColor = Color.fromARGB(255, 45, 110, 45);
  Color _accentColor = Color.fromARGB(255, 55, 199, 27); 

  // Color _primaryColor = HexColor('#DC54FE');
  // Color _accentColor = HexColor('#8A02AE');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Colors.grey[50],
        primarySwatch: Colors.grey,
      ),
      home: HomeScreen(),
    );
  }
}
