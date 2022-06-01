// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_import, prefer_is_not_empty, deprecated_member_use, avoid_unnecessary_containers, unused_import, prefer_final_fields, avoid_print
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_ui/allPosts.dart';
import 'package:login_ui/common/theme_helper.dart';
import 'package:login_ui/data/data.dart';
import 'package:login_ui/my_post.dart';
import 'package:login_ui/pages/forgot_password_page.dart';
import 'package:login_ui/pages/home_page.dart';
import 'package:login_ui/pages/login_page.dart';
import 'package:login_ui/pages/logout_page.dart';
import 'package:login_ui/pages/registration_page.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:login_ui/pages/splash_screen.dart';
import 'package:login_ui/pages/upload_data.dart';
import 'package:login_ui/pages/widgets/header_widget.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password_verification_page.dart';
import 'post_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double _drawerIconSize = 20;
  double _drawerFontSize = 15;
  List<String> catIds = [];
  List<String> cats = [];
  String name = '';
  String email = '';
  String phone = '';
  String id = '';
  String token = '';
  List<Asset> images = [];
  bool hasImage = true;
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email')!;
      name = preferences.getString('name')!;
      phone = preferences.getString('phone')!;
      id = preferences.getString('pk_i_id')!;
      getCategories(catIds, cats);
    });
  }

  Future deleteImage() async {
    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/profile_pic/upload";
    String token = await getToken();
    var response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var content = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        Fluttertoast.showToast(
          msg: "Comment has been deleted".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
        );
        print(content);
      });
    } else {
      print(content);
    }
  }

  Future getImage() async {
    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/profile/" +
            id;
    var response = await http.get(Uri.parse(url));
    var content = json.decode(response.body);
    if (response.statusCode == 200) {
      if (content['hasImage'] == "true") {
        imageUrl = content["url"];
        hasImage = true;
      }
      print(imageUrl);
    } else {
      print(content);
    }
  }

  Future uploadImage() async {
    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/profile_pic/upload";

    String token = await getToken();

    ByteData byteData = await images[0].getByteData();
    List<int> imageData = byteData.buffer.asUint8List();

    dio.MultipartFile multipartFile = dio.MultipartFile.fromBytes(
      imageData,
      filename: images[0].name,
      contentType: MediaType('image', 'jpeg'),
    );

    dio.FormData formData = dio.FormData.fromMap({
      "userfile": multipartFile,
    });

    var diio = dio.Dio();
    diio.options.headers["Authorization"] = "Bearer $token";
    var response = await diio.post(url, data: formData);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(
        msg: "Profile photo updated".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
      );
      print(response.data);
    } else {
      EasyLoading.dismiss();
      Fluttertoast.showToast(
        msg: "Profile photo update error".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
      );
      print(response.data);
    }
  }

  Future<void> loadImage() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: '#2A6AB1',
          actionBarTitle: "Select Photo".tr,
          allViewTitle: "All Photos".tr,
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      uploadImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile".tr,
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
          actions: [
            Container(
              margin: EdgeInsets.only(
                top: 16,
                right: 16,
              ),
              child: Stack(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ThemeHelper().alartDialog("Notifications".tr,
                                "There are no notifications".tr, context);
                          },
                        );
                      });
                    },
                    icon: Icon(Icons.notifications),
                  )
                ],
              ),
            )
          ],
        ),
        drawer: Drawer(
          child: Container(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [
                            0.0,
                            1.0
                          ],
                          colors: [
                            Theme.of(context).primaryColor, //.withOpacity(0.2),
                            Theme.of(context).accentColor, //.withOpacity(0.2),
                          ])),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Allmenkul",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home_outlined,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Homepage'.tr,
                    style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Settings'.tr,
                    style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {},
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout_rounded,
                    size: _drawerIconSize,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    'Logout'.tr,
                    style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogoutPage()));
                  },
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 100,
                child: HeaderWidget(100, false, Icons.ac_unit_outlined),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          //padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 5, color: Colors.white),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 20,
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                          child: hasImage
                              ? Image.asset(
                                  'assets/images/google-logo.png',
                                  height: 110,
                                  width: 110,
                                )
                              : Icon(
                                  Icons.person,
                                  size: 110,
                                  color: Colors.grey.shade300,
                                ),
                        ),
                        GestureDetector(
                          onTap: loadImage,
                          child: Container(
                            height: 30,
                            width: 30,
                            //padding: EdgeInsets.fromLTRB(80, 90, 0, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 5, color: Colors.white),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 4.0),
                            alignment: Alignment.topLeft,
                            child: Center(
                              child: Text(
                                'User Information'.tr,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        ...ListTile.divideTiles(
                                            color: Colors.grey,
                                            tiles: [
                                              ListTile(
                                                leading:
                                                    Icon(Icons.my_location),
                                                title: Text("Location".tr),
                                                subtitle: Text("Turkey"),
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.email),
                                                title: Text("Email".tr),
                                                subtitle: Text(email),
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.phone),
                                                title: Text("Phone".tr),
                                                subtitle: Text(phone),
                                              ),
                                            ])
                                      ],
                                    )
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyPost()));
                                  },
                                  child: Text(
                                    'MY POSTS'.tr,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PostScreen()));
                                  },
                                  child: Text(
                                    'ALL POSTS'.tr,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: IconButton(
              onPressed: () {
                // print(catIds);
                // print(cats);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UploadData()));
              },
              icon: Icon(Icons.add)),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {},
        ));
  }
}
