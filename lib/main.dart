// ignore_for_file: deprecated_member_use, prefer_final_fields, must_be_immutable, use_key_in_widget_constructors, unnecessary_import, prefer_const_constructors, unused_import, avoid_print, unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_ui/LocaleStrings.dart';
import 'package:login_ui/pages/home/home_screen.dart';
import 'package:login_ui/pages/home_page.dart';
import 'package:login_ui/pages/login_page.dart';
import 'package:login_ui/pages/post_screen.dart';
import 'package:login_ui/pages/upload_data.dart';
import 'package:login_ui/pages/widgets/map_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');
  var loggedIn = preferences.getString('loggedIn');
  print(email);
  print(loggedIn);
  // runApp(MaterialApp(
  //   home: email == null ? MyApp() : LoginPage(),
  // ));
  runApp(MyApp());
  //configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  Color _primaryColor =
      Color.fromARGB(255, 4, 28, 107); //Color.fromARGB(255, 45, 110, 45);
  // Color _accentColor =
  //     Color.fromARGB(167, 21, 17, 238); //Color.fromARGB(255, 55, 199, 27);

  //Color _primaryColor = HexColor('#2A6AB1');
  Color _accentColor = HexColor('#2A6AB1');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocaleStrings(),
      locale: Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        primarySwatch: Colors.grey,
      ),
      home: SplashScreen(
        title: '',
      ), //PostScreen(),//UploadData(), //SplashScreen(title: '',),
      builder: EasyLoading.init(),
    );
  }
}
