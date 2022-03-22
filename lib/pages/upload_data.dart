// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, prefer_const_declarations, dead_code

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import '../common/theme_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class UploadData extends StatefulWidget {
  const UploadData({Key? key}) : super(key: key);

  @override
  State<UploadData> createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  Key _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  String description = '';
  String title = '',
      name = '',
      phone = '',
      email = '',
      price = '',
      category = '',
      about = '',
      process = '',
      state = '',
      location = '',
      region = '',
      postalCode = '',
      adress = '';

  TextEditingController _name = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _about = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _region = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _email = TextEditingController();

  String? selectedValue;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Post".tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ]
            )),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(25, 60, 25, 10),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Category*',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),),
                          iconEnabledColor: Theme.of(context).primaryColor,
                          items: items
                                  .map((item) =>
                                  DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                                  .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: width,
                          itemHeight: 40,
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      child: TextFormField(
                        controller: _title,
                        decoration: ThemeHelper().textInputDecoration(
                            'Title*'.tr, 'Enter the title of your post'.tr),
                      ),
                      //decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      child: MarkdownTextInput(
                          (String value) => setState(() => description = value),
                          description,
                          label: 'Description',
                          actions: MarkdownType.values,
                          controller: _about,
                        ),
                      //decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      child: TextField(
                        controller: _price,
                        inputFormatters: <TextInputFormatter>[
                          CurrencyTextInputFormatter(
                            decimalDigits: 0,
                            symbol: 'TL'
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
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
                    Container(
                      child: TextFormField(
                        controller: _name,
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
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      decoration: ThemeHelper().buttonBoxDecoration(context),
                      child: ElevatedButton(
                        style: ThemeHelper().buttonStyle(),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                          child: Text(
                            "UPLOAD".tr,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
