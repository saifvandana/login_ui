// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, prefer_is_not_empty, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_ui/pages/profile_page.dart';
import 'package:login_ui/pages/widgets/header_widget.dart';
import 'package:login_ui/common/theme_helper.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  Key _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  String username = "", password = "", email = "" ;
  bool isLoading = false;

  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  /*//API
  signup(name, email, password) async {
    setState(() {
      isLoading = true;
    });

    name = _name.text;
    email = _email.text;
    password = _password.text;

    if (name == "" || password == "" || email == "") {
      Fluttertoast.showToast(
        msg: "name, email or password cannot be blank".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email)) {
      Fluttertoast.showToast(
        msg: "Enter a valid email".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      Map data = {
        's_name': name,
        's_email': email,
        's_password': password,
        's_username': name,
        'fk_i_parent_id': '0',
        'b_enabled': '1',
        'b_active': '1'
      };

      //print(data.toString());

      final response = await http.post(
        Uri.parse("http://localhost:8080/osclass/add"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        //encoding: Encoding.getByName("utf-8")
      );

      //If registration is successful
      if (response.statusCode == 200) {
        print(response.body);

        Fluttertoast.showToast(
          msg: "User registered successfully".tr,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));

      } 
      else {
        Fluttertoast.showToast(
          msg: "User cannot be registered".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
        );
      }
    }
  }*/

  signup(username, email, password) async {
    setState(() {
      isLoading = true;
    });

    username = _username.text;
    email = _email.text;
    password = _password.text;

    if (username == "" || password == "" || email == "") {
      Fluttertoast.showToast(
        msg: "Username or password is blank".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      Map data = {'username': username, 'email': email, 'password': password};

      //print(data.toString());

      final response = await http.post(
          Uri.parse("http://192.168.0.101/localconnect/signup.php"),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: data,
          encoding: Encoding.getByName("utf-8"));

      //If data fetching is successful
      if (response.statusCode == 200) {
        print(response.body);
        final content = jsonDecode(response.body);

        if (!content['error']) {
          Fluttertoast.showToast(
            msg: "${content['message']}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
          );
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
        } else {
          Fluttertoast.showToast(
            msg: "${content['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
          );
        }
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
              child: HeaderWidget(130, false, Icons.person_add_alt_1_rounded),
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
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 70.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(75, 75, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _username,
                            decoration: ThemeHelper().textInputDecoration(
                                'Name'.tr, 'Enter your user name'.tr),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 30,
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
                        SizedBox(height: 20.0),
                        // Container(
                        //   child: TextFormField(
                        //     decoration: ThemeHelper().textInputDecoration(
                        //         "Mobile Number", "Enter your mobile number"),
                        //     keyboardType: TextInputType.phone,
                        //     validator: (val) {
                        //       if (!(val!.isEmpty) &&
                        //           !RegExp(r"^(\d+)*$").hasMatch(val)) {
                        //         return "Enter a valid phone number";
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        //   decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        // ),
                        // SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: _password,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password".tr, "Enter your password".tr),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text(
                                      "I accept all terms and conditions.".tr,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          // validator: (value) {
                          //   if (!checkboxValue) {
                          //     return 'You need to accept terms and conditions'.tr;
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            onPressed: () {
                              signup(username, email, password);
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
                        SizedBox(height: 30.0),
                        Text(
                          "Or create account using social media".tr,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: GestureDetector(
                                child: FaIcon(
                                  FontAwesomeIcons.googlePlus,
                                  size: 35,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  setState(() {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ThemeHelper().alartDialog(
                                            "Google Plus",
                                            "You tap on GooglePlus icon",
                                            context);
                                      },
                                    );
                                  });
                                },
                              ),
                            ),
                            
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.facebook,
                                size: 35,
                                color: Colors.blue[700],
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Facebook",
                                          "You tap on Facebook icon",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                          ],
                        ),
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
