// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, prefer_const_declarations, dead_code, avoid_print, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart' as dio;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:login_ui/data/data.dart';
import 'package:login_ui/pages/profile_page.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/theme_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class UploadData extends StatefulWidget {
  const UploadData({Key? key}) : super(key: key);

  @override
  State<UploadData> createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  Key _formKey = GlobalKey<FormState>();
  bool checkedValue = true;
  bool checkboxValue = true;
  bool checkedValue1 = true;
  bool checkboxValue1 = true;
  String description = '';
  String? category, process, state, location;

  TextEditingController _name = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _about = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _region = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _email = TextEditingController();

  List<Asset> images = [];
  //Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  String sha256RandomString() {
    final randomNumber = Random().nextDouble();
    final randomBytes = utf8.encode(randomNumber.toString());
    final randomString = sha256.convert(randomBytes).toString();
    return randomString;
  }

  var url = BASEURL + "upload.php";
  String email = '';

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email')!;
      _email.text = email;
    });
  }

  _saveImage() async {
    if (_title.text == "" ||
        category == "" ||
        _about.text == "" ||
        _name.text == "" || _phone.text == "") {
      Fluttertoast.showToast(
        msg: "required fields cannot be blank".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      if (images != null) {
        final uniqueString = sha256RandomString();
        String done = 'false';

        for (var i = 0; i < images.length; i++) {
          if (i == images.length - 1) {
            done = 'true';
          }

          ByteData byteData = await images[i].getByteData();
          List<int> imageData = byteData.buffer.asUint8List();

          dio.MultipartFile multipartFile = dio.MultipartFile.fromBytes(
            imageData,
            filename: images[i].name,
            contentType: MediaType('image', 'jpg'),
          );

          dio.FormData formData = dio.FormData.fromMap({
            "image": multipartFile,
            'name': _name.text,
            'title': _title.text,
            'about': _about.text,
            'phone': _phone.text,
            'email': _email.text,
            'price': _price.text,
            'category': category,
            'process': process,
            'state': state,
            'location': location,
            'region': _region.text,
            'postalCode': _postalCode.text,
            'unique_string': uniqueString,
            'address': _address.text,
            'done': done,
          });

          //EasyLoading.show(status: 'uploading...');

          var response = await dio.Dio().post(url, data: formData);
          if (response.statusCode == 200) {
            //EasyLoading.dismiss();
            //EasyLoading.showSuccess('Success! $count');
            if (done == 'true') {
              Fluttertoast.showToast(
                msg: "Listing added successfully".tr,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
              );
              //print(response.data);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            }  
          }
          // if (i == images.length - 1) {
          //   print(images.length);
          //   var response = await dio.Dio().post(
          //       'http://192.168.1.108/localconnect/insertPost.php',
          //       data: formData);
          //   if (response.statusCode == 200) {
          //     print(response.data);
          //   }
          // }
        }
      }
    }
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 7,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 100,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: '#2A6AB1',
          actionBarTitle: "Select Photos".tr,
          allViewTitle: "All Photos".tr,
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Listing".tr,
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
              ])),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(25, 60, 25, 10),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text('LISTING INFO'.tr),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Category *'.tr,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          iconEnabledColor: Theme.of(context).primaryColor,
                          items: categories
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: category,
                          onChanged: (value) {
                            setState(() {
                              category = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: width,
                          itemHeight: 40,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: TextFormField(
                        controller: _title,
                        decoration: ThemeHelper().textInputDecoration(
                            'Title *'.tr, 'Enter the title of your post'.tr),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: MarkdownTextInput(
                        (String value) => setState(() => description = value),
                        description,
                        label: 'Description *'.tr,
                        actions: MarkdownType.values,
                        controller: _about,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price'.tr,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        TextField(
                          controller: _price,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            CurrencyTextInputFormatter(
                                decimalDigits: 0, symbol: 'TL')
                          ],
                        ),
                      ],
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Process'.tr,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          iconEnabledColor: Theme.of(context).primaryColor,
                          items: processes
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: process,
                          onChanged: (value) {
                            setState(() {
                              process = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: width,
                          itemHeight: 40,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'State'.tr,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          iconEnabledColor: Theme.of(context).primaryColor,
                          items: states
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: state,
                          onChanged: (value) {
                            setState(() {
                              state = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: width,
                          itemHeight: 40,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('LOCATION INFO'.tr),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Location *'.tr,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          iconEnabledColor: Theme.of(context).primaryColor,
                          items: locations
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: location,
                          onChanged: (value) {
                            setState(() {
                              location = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: width,
                          itemHeight: 40,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: TextFormField(
                        controller: _region,
                        decoration: ThemeHelper()
                            .textInputDecoration("Region".tr, "".tr),
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: TextFormField(
                        controller: _postalCode,
                        decoration: ThemeHelper()
                            .textInputDecoration("Postal Code".tr, "".tr),
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: TextFormField(
                        controller: _address,
                        decoration: ThemeHelper()
                            .textInputDecoration("Address".tr, "".tr),
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 30.0),
                    Text('SELLER INFO'.tr),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        controller: _name,
                        decoration: ThemeHelper()
                            .textInputDecoration("Name *".tr, "".tr),
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: TextFormField(
                        controller: _phone,
                        decoration: ThemeHelper()
                            .textInputDecoration("Phone *".tr, "".tr),
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
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
                                  "Show phone number in post".tr,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            // Container(
                            //   alignment: Alignment.centerLeft,
                            //   child: Text(
                            //     state.errorText ?? '',
                            //     textAlign: TextAlign.left,
                            //     style: TextStyle(
                            //       color: Theme.of(context).errorColor,
                            //       fontSize: 12,
                            //     ),
                            //   ),
                            // )
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: TextFormField(
                        controller: _email,
                        //initialValue: email,
                        decoration: ThemeHelper().textInputDecoration(
                            "E-mail address *".tr, "Enter your email".tr),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    FormField<bool>(
                      builder: (state) {
                        return Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                    value: checkboxValue1,
                                    onChanged: (value) {
                                      setState(() {
                                        checkboxValue1 = value!;
                                        state.didChange(value);
                                      });
                                    }),
                                Text(
                                  "Show email adress in post".tr,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            // Container(
                            //   alignment: Alignment.centerLeft,
                            //   child: Text(
                            //     state.errorText ?? '',
                            //     textAlign: TextAlign.left,
                            //     style: TextStyle(
                            //       color: Theme.of(context).errorColor,
                            //       fontSize: 12,
                            //     ),
                            //   ),
                            // )
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20.0),
                    Container(
                        child: Column(
                      children: [
                        Text(
                          'PHOTOS'.tr,
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'A post can have at most 10 photos'.tr,
                          style: TextStyle(fontSize: 15),
                        ),
                        //Flexible(child: buildGridView()),
                        Container(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: buildGridView(),
                              ),
                              Positioned(
                                left: 90,
                                top: 200,
                                child: TextButton(
                                  onPressed: loadAssets,
                                  child: Text(
                                    'Click to Upload'.tr,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          height: 250,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 235, 235),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        RaisedButton(
                          child: Text(
                            'Upload Photos'.tr,
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: loadAssets),
                      ],
                    )),
                    SizedBox(height: 40.0),
                    Container(
                      decoration: ThemeHelper().buttonBoxDecoration(context),
                      child: ElevatedButton(
                        style: ThemeHelper().buttonStyle(),
                        onPressed: () {
                          _saveImage();
                        },
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
