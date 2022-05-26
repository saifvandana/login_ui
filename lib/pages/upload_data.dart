// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, prefer_const_declarations, dead_code, avoid_print, unnecessary_null_comparison, unused_local_variable, import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
import 'package:path/path.dart';

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
  bool showButton = false;
  String description = '';
  String? process, state, location, category, altCategory, currency;
  //String category = 'Konut', altCategory = 'Daire';
  //     process = 'Sell',
  //     state = 'New',
  //     location = 'Ankara';

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

  var url =
      'https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/item/';

  String token = '';

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _email.text = preferences.getString('email')!;
      _name.text = preferences.getString('name')!;
      _phone.text = preferences.getString('phone')!;
    });
  }

  Future getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future uploadItem(BuildContext context) async {
    if (_title.text == "" ||
        category == "" ||
        _about.text == "" ||
        _name.text == "" ||
        _phone.text == "") {
      Fluttertoast.showToast(
        msg: "required fields cannot be blank".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      List<String> ajaxPhotos = [];

      for (int i = 0; i < images.length; i++) {
        ajaxPhotos.add(images[i].name as String);
      }
      EasyLoading.show(status: 'uploading...'.tr);

      String token = await getToken();
      var uri = Uri.parse(
          'https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/item/');
      http.MultipartRequest request = http.MultipartRequest('POST', uri);

      request.fields['contactName'] = _name.text;
      request.fields['title[tr_TR]'] = _title.text;
      request.fields['description[tr_TR]'] = _about.text;
      request.fields['contactPhone'] = _phone.text;
      request.fields['contactEmail'] = _email.text;
      request.fields['price'] = _price.text;
      request.fields['currency'] = currency as String;
      request.fields['catId'] =
          altCatIds[altCats.indexOf(altCategory as String)];
      request.fields['countryId'] = 'TR';
      request.fields['zip'] = _postalCode.text;
      request.fields['address'] = _address.text;
      request.fields['ajax_photos'] = ajaxPhotos[0];

      request.headers['Authorization'] = 'Bearer $token';
      List<http.MultipartFile> newList = <http.MultipartFile>[];

      for (int i = 0; i < images.length; i++) {
        var path =
            await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
        File imageFile = File(path);
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile("photos", stream, length,
            filename: basename(imageFile.path));
        newList.add(multipartFile);
      }

      request.files.addAll(newList);
      var response = await request.send();
      print(response.toString());
      // var res = await http.Response.fromStream(response);
      // print(res.body);
      // var content = json.decode(res.body);
      // print(content);
      var url = Uri.parse(
          'https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/item/image');

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
          msg: "Listing added successfully".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
      } else {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
          msg: "Listing could not be added".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
        );
      }
    }
  }

  Future _addListing(BuildContext context) async {
    if (_title.text == "" ||
        category == "" ||
        _about.text == "" ||
        _name.text == "" ||
        _phone.text == "") {
      Fluttertoast.showToast(
        msg: "required fields cannot be blank".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      // var thisUrl =
      //     'https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/item/image';

      // for (int i = 0; i < images.length; i++) {
      //   print("uploading images");
      //   var path =
      //       await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      //   File imageFile = File(path);
      //   var stream = http.ByteStream(imageFile.openRead());
      //   var length = await imageFile.length();
      //   var multipartFile = http.MultipartFile("qqfile", stream, length,
      //       filename: basename(imageFile.path));

      //   dio.FormData formData = dio.FormData.fromMap({
      //     'photos': multipartFile,
      //   });

      //   var reponse = await dio.Dio().post(thisUrl, data: formData);
      //   print(reponse.data);
      //   print("uploading done");
      // }

      //List<String> ajaxPhotos = [];

      // for (int i = 0; i < images.length; i++) {
      //   ajaxPhotos.add(images[i].name as String);
      // }

      // dio.FormData formData = dio.FormData.fromMap({
      //   // 'ajax_photos': ajaxPhotos,
      //   'contactName': _name.text,
      //   'title[tr_TR]': _title.text,
      //   'description[tr_TR]': _about.text,
      //   'contactPhone': _phone.text,
      //   'contactEmail': _email.text,
      //   'price': _price.text,
      //   'catId': altCatIds[altCats.indexOf(altCategory as String)],
      //   'currency': currency as String,
      //   'countryId': 'TR',
      //   // 'sTransaction': '',
      //   // 'sCondition': '',
      //   // 'cityId': '',
      //   // 'regionId': '',
      //   //'regionName': location,
      //   'zip': _postalCode.text,
      //   'address': _address.text,
      // });

      Map formData = {
        'contactName': _name.text,
        'title[tr_TR]': _title.text,
        'description[tr_TR]': _about.text,
        'contactPhone': _phone.text,
        'contactEmail': _email.text,
        'price': _price.text,
        'catId': altCatIds[altCats.indexOf(altCategory as String)],
        'currency': currency as String,
        'countryId': 'TR',
        // 'sTransaction': '',
        // 'sCondition': '',
        // 'cityId': '',
        'regionId': regionIds[regions.indexOf(location as String)],
        //'region': location,
        'zip': _postalCode.text,
        'address': _address.text,
      };

      EasyLoading.show(status: 'uploading...'.tr);

      String token = await getToken();
      // var diio = dio.Dio();
      // diio.options.headers["Authorization"] = "Bearer $token";

      var response = await http.post(Uri.parse(url), body: formData, headers: {
        'Authorization': 'Bearer $token',
      });

      // var response = await diio.post(
      //   url,
      //   data: formData,
      // );

      final content = jsonDecode(response.body);
      print(response.body);
      print(content['id']);

      if (response.statusCode == 200) {
        //uploading images
        final dburl = 'https://allmenkul.com/oc-admin/1upload.php';

        for (var i = 0; i < images.length; i++) {
          //print(images[i].name?.split(".").last);
          final uniqueString = sha256RandomString();

          ByteData byteData = await images[i].getByteData();
          List<int> imageData = byteData.buffer.asUint8List();

          dio.MultipartFile multipartFile = dio.MultipartFile.fromBytes(
            imageData,
            filename: images[i].name,
            contentType: MediaType('image', 'jpeg'),
          );

          dio.FormData formData = dio.FormData.fromMap({
            'fk_i_item_id': content['id'] as String,
            's_name': images[i].name,
            's_extension': images[i].name?.split(".").last,
            "s_content_type": "image/jpeg",
            "s_path": "oc-admin/images/",
            "image": multipartFile,
          });

          var reponse = await dio.Dio().post(dburl, data: formData);
          print(reponse.data);
        }

        EasyLoading.dismiss();
        Fluttertoast.showToast(
          msg: "Listing added successfully".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
      } else {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
          msg: "Listing not added successfully"
              .tr, //"${content['message']}", //"email or password invalid".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
        );
      }
    }
  }

  _saveImage(BuildContext context) async {
    final url =
        'https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/item/image'; //'http://192.168.1.111/localconnect/upload.php';
    final uniqueString = sha256RandomString();
    List<String> ajaxPhotos = [];

    for (var i = 0; i < images.length; i++) {
      ByteData byteData = await images[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();

      dio.MultipartFile multipartFile = dio.MultipartFile.fromBytes(
        imageData,
        filename: images[i].name,
        contentType: MediaType('image', 'jpeg'),
      );

      dio.FormData formData = dio.FormData.fromMap({
        "image": multipartFile,
      });

      EasyLoading.show(status: 'uploading...');

      var response = await dio.Dio().post(url, data: formData);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        print(response.data);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
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
                    showCats(context),
                    if (showButton) ...[
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            showButton = false;
                            showAlt = true;
                            altCategory = null;
                            print(altCatIds);
                            print(altCats);
                          });
                        },
                        child: Text(
                          'Choose sub category'.tr,
                          style: TextStyle(
                            //color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                    if (showAlt) ...[
                      SizedBox(
                        height: 30,
                      ),
                      showAlts(context),
                    ],
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
                    Row(
                      children: [
                        SizedBox(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: Text(
                                'Currency'.tr,
                                style: TextStyle(
                                  fontSize: 15,
                                  //backgroundColor: Colors.grey
                                ),
                              ),
                              iconEnabledColor: Theme.of(context).primaryColor,
                              isDense: true,
                              items: currencies
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
                              value: currency,
                              onChanged: (value) {
                                setState(() {
                                  currency = value as String;
                                });
                              },
                              buttonHeight: 40,
                              //buttonWidth: width / 4,
                              //itemHeight: 40,
                              //dropdownWidth: width / 2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: TextFormField(
                              controller: _price,
                              keyboardType: TextInputType.number,
                              decoration: ThemeHelper()
                                  .textInputDecoration("Price".tr, "".tr),
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                        ),
                      ],
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
                          items: regions
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
                        onPressed: () async {
                          _addListing(context);
                          //uploadItem(context);
                          //_saveImage(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showCats(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
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
          items: cats
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
              List<String> _altCats = [];
              List<String> _altCatIds = [];
              getAlts(_altCatIds, _altCats, category as String);
              showButton = true;
              showAlt = false;
              Future.delayed(const Duration(seconds: 5));
            });
          },
          buttonHeight: 40,
          buttonWidth: width,
          itemHeight: 40,
        ),
      ),
    );
  }

  Widget showAlts(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Sub-Category *'.tr,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          iconEnabledColor: Theme.of(context).primaryColor,
          items: altCats
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
          value: altCategory,
          onChanged: (value) {
            setState(() {
              altCategory = value as String;
            });
          },
          buttonHeight: 40,
          buttonWidth: width,
          itemHeight: 40,
        ),
      ),
    );
  }
}
