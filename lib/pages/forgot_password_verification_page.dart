// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/pages/profile_page.dart';
import 'package:login_ui/pages/widgets/header_widget.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../common/theme_helper.dart';

class ForgotPasswordVerificationPage extends StatefulWidget {
  const ForgotPasswordVerificationPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordVerificationPage> createState() =>
      _ForgotPasswordVerificationPageState();
}

class _ForgotPasswordVerificationPageState
    extends State<ForgotPasswordVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _pinSuccess = false;

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 150;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: _headerHeight,
            child:
                HeaderWidget(_headerHeight, true, Icons.privacy_tip_outlined),
          ),
          SafeArea(
              child: Container(
            margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Column(children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verification',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Enter the verification code we just sent on your email',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    OTPTextField(
                      length: 4,
                      width: 300,
                      fieldWidth: 50,
                      style: TextStyle(fontSize: 30),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.underline,
                      onCompleted: (pin) {
                        setState(() {
                          _pinSuccess = true;
                        });
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "If you did not recieve a code! ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                            text: 'Resend',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ThemeHelper().alartDialog(
                                        "Successful",
                                        "Verification code resend successful",
                                        context);
                                  },
                                );
                              },
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 40,),
                    Container(
                      decoration: _pinSuccess ? ThemeHelper().buttonBoxDecoration(context) : ThemeHelper().buttonBoxDecoration(context, "#AAAAAA", "#757575"),
                      child: ElevatedButton(
                        style: ThemeHelper().buttonStyle(),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                          child: Text(
                            "verify".toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: _pinSuccess ? () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => ProfilePage()), (route) => false);
                        } : null,
                      ),
                    )
                  ],
                ),
              )
            ]),
          ))
        ]),
      ),
    );
  }
}
