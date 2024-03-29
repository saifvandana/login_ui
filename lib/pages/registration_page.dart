// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, prefer_is_not_empty, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_ui/pages/login_page.dart';
import 'package:login_ui/pages/profile_page.dart';
import 'package:login_ui/pages/widgets/header_widget.dart';
import 'package:login_ui/common/theme_helper.dart';

import '../data/data.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  Key _formKey = GlobalKey<FormState>();
  bool obscure = true;
  bool obscure2 = true;
  String username = "", password = "", password2 = "", phone = "", email = "" ;

  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _password2 = TextEditingController();
  TextEditingController _phone = TextEditingController();

  void _toggle() {
    setState(() {
      obscure = !obscure;
    });
  }

  signup(username, email, password, password2, phone) async {

    username = _username.text;
    email = _email.text;
    password = _password.text;
    password2 = _password2.text;
    phone = _phone.text;

    if (username == "" || password == "" || password2 == "" || email == "") {
      Fluttertoast.showToast(
        msg: "Username, email or password is blank".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      Map data = {'s_name': username, 's_email': email, 's_password': password, 's_password2': password2, 's_phone_mobile' : phone};

      String url = "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/user/";

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
      );

      final content = jsonDecode(response.body);

      //If data fetching is successful
      if (response.statusCode == 200) {
        print(response.body);

        Fluttertoast.showToast(
          msg: "${content['message']}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        Fluttertoast.showToast(
          msg: "${content['message']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(130, true, Icons.person_add_alt_1_rounded)
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 60, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120,
                        ),
                        Text(
                        'Create account'.tr,
                        style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: TextFormField(
                            controller: _username,
                            decoration: ThemeHelper().textInputDecoration(
                                'Name'.tr, 'Enter your user name'.tr),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _email,
                            decoration: ThemeHelper().textInputDecoration(
                                "E-mail address".tr, "Enter your email".tr),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _password,
                            obscureText: obscure,
                            decoration: InputDecoration(
                              labelText: "Password".tr, 
                              contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: GestureDetector(
                                  child: obscure ? Icon(Icons.lock) : Icon(Icons.lock_open),
                                  onTap: _toggle,
                                ),)
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _password2,
                            obscureText: obscure,
                            decoration: InputDecoration(
                              labelText: "Confirm Password".tr, 
                              contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: GestureDetector(
                                  child: obscure ? Icon(Icons.lock) : Icon(Icons.lock_open),
                                  onTap: _toggle,
                                ),)
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _phone,
                            decoration: ThemeHelper().textInputDecoration(
                                "Phone".tr, "Phone".tr),
                            keyboardType: TextInputType.phone,
                            // validator: (val) {
                            //   if (!(val!.isEmpty) &&
                            //       !RegExp(r"^(\d+)*$").hasMatch(val)) {
                            //     return "Enter a valid phone number";
                            //   }
                            //   return null;
                            // },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            onPressed: () {
                              signup(username, email, password, password2, phone);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "REGISTER".tr,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(height: 30.0),
                        // Text(
                        //   "Or create account using social media".tr,
                        //   style: TextStyle(color: Colors.grey),
                        // ),
                        // SizedBox(height: 25.0),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Padding(
                        //       padding: EdgeInsets.all(10),
                        //       child: GestureDetector(
                        //         child: Icon(
                        //           FontAwesomeIcons.google,
                        //           size: 25,
                        //           color: Colors.red,
                        //         ),
                        //         onTap: () {
                        //           setState(() {
                        //             showDialog(
                        //               context: context,
                        //               builder: (BuildContext context) {
                        //                 return ThemeHelper().alartDialog(
                        //                     "Google Plus",
                        //                     "You tap on GooglePlus icon",
                        //                     context);
                        //               },
                        //             );
                        //           });
                        //         },
                        //       ),
                        //     ),
                            
                        //     GestureDetector(
                        //       child: FaIcon(
                        //         FontAwesomeIcons.facebook,
                        //         size: 25,
                        //         color: Colors.blue[700],
                        //       ),
                        //       onTap: () {
                        //         setState(() {
                        //           showDialog(
                        //             context: context,
                        //             builder: (BuildContext context) {
                        //               return ThemeHelper().alartDialog(
                        //                   "Facebook",
                        //                   "You tap on Facebook icon",
                        //                   context);
                        //             },
                        //           );
                        //         });
                        //       },
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
