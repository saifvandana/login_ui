// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_import, prefer_is_not_empty, deprecated_member_use, avoid_unnecessary_containers, unused_import, prefer_final_fields, avoid_print, unnecessary_null_comparison, prefer_const_declarations
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
import 'package:login_ui/pages/allPosts.dart';
import 'package:login_ui/common/theme_helper.dart';
import 'package:login_ui/data/data.dart';
import 'package:login_ui/pages/my_post.dart';
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

import '../constants/Theme.dart';
import 'forgot_password_verification_page.dart';
import 'post_screen.dart';
import 'widgets/card-small.dart';
import 'widgets/drawer.dart';
import 'widgets/mydrawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> catIds = [];
  List<String> cats = [];
  String name = '';
  String email = '';
  String phone = '';
  String id = '';
  String avg = '';
  String token = '';
  List<Asset> images = [];
  bool hasImage = false;
  String imageUrl = '';
  int count = 0;
  List myItem = [];
  List<String> itemImages = [];
  bool hasPosts = false;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future myPosts() async {
    itemImages.clear();
    String token = await getToken();
    final url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/user/my-items";
    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    final content = json.decode(response.body);
    myItem = content['items'];
    print(myItem);
    // myitem.removeWhere((element) => element["s_contact_email"] != email);
    count = myItem.length;
    if (count > 1) {
      hasPosts = true;
      for (int i = 0; i < 2; i++) {
        if (i < count) {
          if (myItem[i]["resources"].length > i) {
            String img = "https://allmenkul.com/" +
                myItem[i]["resources"][0]['s_path'] +
                myItem[i]["resources"][0]['pk_i_id'] +
                "." +
                myItem[i]["resources"][0]['s_extension'];
            itemImages.add(img);
          } else {
            itemImages.add("https://via.placeholder.com/200");
          }
        }
      }
    }
    print(count);
  }

  Future getAvgRating() async {
    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/rating/useravg/" +
            id;
    var response = await http.get(Uri.parse(url));
    var content = json.decode(response.body);
    if (content["d_average"].toString().isNotEmpty) {
      setState(() {
        avg = content["d_average"].toString().substring(0, 3);
      });
    }
    print('avg = ' + avg);
  }

  Future getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email') ?? '';
      name = preferences.getString('name') ?? '';
      phone = preferences.getString('phone') ?? '';
      id = preferences.getString('id') ?? '';
      getCategories(catIds, cats);
      getImage();
      myPosts();
      getAvgRating();
    });
  }

  Future deleteImage() async {
    if (hasImage) {
      var url =
          "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/profile_pic/delete/" +
              id;
      String token = await getToken();
      var response = await http.delete(
        Uri.parse(url),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // },
      );
      var content = json.decode(response.body);
      print(response.body);

      if (content['status'] == '1') {
        setState(() {
          // Fluttertoast.showToast(
          //   msg: "Profile photo has been deleted".tr,
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.SNACKBAR,
          // );
          hasImage = false;
          print('deleted image');
        });
      } else {
        print('not deleted image');
      }
    } else {
      print('no image');
    }
  }

  Future getImage() async {
    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/profile/" +
            id;
    var response = await http.get(Uri.parse(url));
    var content = json.decode(response.body);
    print(content);
    if (content['hasImage'] == 'true') {
      print('true');
      setState(() {
        imageUrl = content["url"];
        hasImage = true;
      });
    } else {
      print('false');
      print(content);
    }
    //print('image url ' + imageUrl);
  }

  Future uploadImage() async {
    if (hasImage) {
      deleteImage();
    }

    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/profile_pic/upload?id=" +
            id;

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
    //diio.options.headers["Authorization"] = "Bearer $token";

    var response = await diio.post(url, data: formData);
    //final content = jsonDecode(response.data);
    //imageUrl = response.data['url'];
    if (response.data['status'] == '1') {
      setState(() {
        hasImage = true;
        Fluttertoast.showToast(
          msg: "Profile photo updated".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
        );
      });
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(builder: (context) => ProfilePage()), (route) => false);
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
        //xselectedAssets: images,
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

  void addImages() {}

  @override
  Widget build(BuildContext context) {
    imageCache!.clear();

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor:
              Colors.transparent, //Color.fromARGB(255, 27, 120, 196), // 1
          elevation: 0,
          title: Text(
            "Profile".tr,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            Container(
              margin: EdgeInsets.only(
                top: 16,
                right: 16,
              ),
              child: Stack(
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications),
                  )
                ],
              ),
            )
          ],
        ),
        drawer: AppDrawer("Profile"),
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage("assets/images/profile-screen-bg.png"),
                      fit: BoxFit.fitWidth))),
          SafeArea(
            child: ListView(children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 74.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: .0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 85.0, bottom: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Align(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(avg,
                                                    style: TextStyle(
                                                        color: LoginUIColors
                                                            .warning,
                                                        fontSize: 20)),
                                              ),
                                              Icon(Icons.star_border,
                                                  color: LoginUIColors.warning,
                                                  size: 25)
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        Align(
                                          child: Text(name,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 93, 1),
                                                  fontSize: 28.0)),
                                        ),
                                        SizedBox(height: 10.0),
                                        Align(
                                          child: Text("Ankara, Turkey",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 93, 1),
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w200)),
                                        ),
                                        Divider(
                                          height: 40.0,
                                          thickness: 1.5,
                                          indent: 32.0,
                                          endIndent: 32.0,
                                        ),
                                        SizedBox(height: 25.0),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 25.0,
                                              left: 25.0,
                                              bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "My Posts".tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: LoginUIColors.text),
                                              ),
                                              GestureDetector(
                                                child: Text(
                                                  "View All".tr,
                                                  style: TextStyle(
                                                      color:
                                                          LoginUIColors.primary,
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyPost()));
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 24.0, left: 24.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                if (hasPosts) ...[
                                                  for (int i = 0;
                                                      i < itemImages.length;
                                                      i++) ...[
                                                    CardSmall(
                                                        cta: "View post".tr,
                                                        title: name,
                                                        img: itemImages[i],
                                                        tap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          MyPost()));
                                                        }),
                                                  ],
                                                ],
                                                if (!hasPosts) ...[
                                                  SizedBox(height: 150.0),
                                                  Text('No Posts yet'.tr),
                                                  SizedBox(height: 150.0),
                                                ]
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      FractionalTranslation(
                          translation: Offset(0.0, -0.5),
                          child: Align(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  showPopupMenu(context);
                                });
                              },
                              child: Container(
                                  //padding: EdgeInsets.all(5),
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    //border: Border.all(width: 5, color: Colors.white),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 20,
                                        offset: const Offset(5, 5),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: hasImage
                                        ? CircleAvatar(
                                            child: Image.network(
                                            "https://allmenkul.com/oc-content/plugins/profile_picture/images/" +
                                                imageUrl,
                                            fit: BoxFit.fill,
                                          ))
                                        : Icon(
                                            Icons.person,
                                            size: 100,
                                            color: Colors.grey.shade300,
                                          ),
                                  )),
                            ),
                            alignment: FractionalOffset(0.5, 0.0),
                          ))
                    ]),
                  ],
                ),
              ),
            ]),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UploadData()));
              },
              icon: Icon(Icons.add)),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {},
        ));
  }

  showPopupMenu(BuildContext context) {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
          -5, 200, 0, 0.0), //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(
            onTap: loadImage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.upload,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 2,
                ),
                Text('Update'.tr),
              ],
            ),
            value: '1'),
        if (hasImage) ...[
          PopupMenuItem<String>(
            onTap: deleteImage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 2,
                ),
                Text('Delete'.tr),
              ],
            ),
            value: '2',
          ),
        ],
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
