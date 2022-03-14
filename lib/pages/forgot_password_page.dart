// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_import, prefer_is_not_empty, deprecated_member_use, avoid_unnecessary_containers

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:login_ui/common/theme_helper.dart';
import 'package:login_ui/pages/forgot_password_verification_page.dart';
import 'package:login_ui/pages/login_page.dart';
import 'package:login_ui/pages/widgets/header_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 130;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.password_rounded),
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child:  Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:  CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Enter the email address associated with your account.',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'We will email you a verification code.',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black38
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                              decoration: ThemeHelper().textInputDecoration("Email", "Enter your email"),
                              validator: (val) {
                              if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                return "Enter a valid email address";
                              }
                              return null;
                              },
                            ),
                            decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 40,),
                          Container(
                            decoration: ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              onPressed: () {
                                if (_formKey.currentState!.validate()){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgotPasswordVerificationPage()),);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  "Send".toUpperCase(),
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
                            margin: EdgeInsets.fromLTRB(10,20,10,20),
                            //('Remember your password?'),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Remembered your password? "),
                                  TextSpan(
                                    text: 'Login',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                      },
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                  ),
                                ]
                              )
                            ),
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
