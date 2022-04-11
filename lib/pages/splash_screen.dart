// ignore_for_file: deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, unused_field, unnecessary_import

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/pages/home_page.dart';
import 'package:login_ui/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState(){

    new Timer(const Duration(milliseconds: 2000), (){
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
      });
    });

    new Timer(
      Duration(milliseconds: 10),(){
        setState(() {
          _isVisible = true; // Now it is showing fade effect and navigating to Login page
        });
      }
    );

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white
            //Theme.of(context).accentColor,
            //Theme.of(context).primaryColor
          ],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 1200),
        child: Center(
          child: SizedBox(
            height: 100.0,
            width: size.width * 0.6,
            child: Center(
              child: ClipRect(
                child: Image.asset('assets/images/all.jpg')//ImageIcon(
                //   AssetImage('assets/images/logo.png'), 
                //   //color: Theme.of(context).primaryColor,
                //   size: 120,
                // ),
                // child: Icon(
                //   Icons.android_outlined,
                //   size: 128,
                // ),  //put logo here
              ),
            ),
            // decoration: BoxDecoration(
            //     shape: BoxShape.rectangle,
            //     color: Colors.white,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Theme.of(context).accentColor,
            //         blurRadius: 2.0,
            //         offset: Offset(5.0, 3.0),
            //         spreadRadius: 2.0,
            //       )
            //     ]),
          ),
        ),
      ),
    );
  }
}
