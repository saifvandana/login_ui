// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_import, prefer_is_not_empty, deprecated_member_use, avoid_unnecessary_containers, unused_import, prefer_final_fields, avoid_print, unnecessary_null_comparison, use_key_in_widget_constructors
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/constants/Theme.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/theme_helper.dart';
import 'widgets/drawer.dart';
import 'widgets/header_widget.dart';

class UserProfile extends StatefulWidget {
  const UserProfile(this.id);

  final String id;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String imageUrl = '',
      name = '',
      phone = '',
      avg = '',
      myId = ''; //, img = '';
  bool hasImage = false, loading = true;

  @override
  void initState() {
    super.initState();
    getImage();
    getUserInfo();
    getAvgRating();
  }

  Future getProfile(String img, String id) async {
    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/profile/" +
            id;
    var response = await http.get(Uri.parse(url));
    var content = json.decode(response.body);
    print(content);
    if (content['hasImage'] == 'true') {
      setState((){ 
        img = content["url"];
        loading = false; });
    } else {
      setState((){ loading = false; });
      // print('false');
      // print(content);
    }
  }

  String imgString(String id) {
    String img = '';
    getProfile(img, id);
    return img;
  }

  Future getImage() async {
    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/profile/" +
            widget.id;
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

  Future getUserInfo() async {
    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/user/" +
            widget.id;
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var content = json.decode(response.body);
      name = content["s_name"];
      phone = content["s_phone_mobile"];
      print(content);
    } else {
      print('user error');
    }
  }

  Future getUsername(String name, String id) async {
    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/user/" +
            id;
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var content = json.decode(response.body);
      name = content["s_name"];
      ///phone = content["s_phone_mobile"];
      //print(content);
    } else {
      print('user error');
    }
  }

  Future getRating() async {
    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/rating/userid/" +
            widget.id;
    var response = await http.get(Uri.parse(url));
    var content = json.decode(response.body);
    return content;
  }

  Future getAvgRating() async {
    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/rating/useravg/" +
            widget.id;
    var response = await http.get(Uri.parse(url));
    var content = json.decode(response.body);
    if (content["d_average"].toString().isNotEmpty) {
      setState(() {
        avg = content["d_average"].toString().substring(0, 3);
      });
    }
    print('avg = ' + avg);
  }

  Future getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    myId = prefs.getString('id') as String;
    return prefs.getString('access_token');
  }

  Future postRating(String rating, String comment) async {
    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/rating/";

    Map data = {'user_id': widget.id, 'cat0': rating, 'comment': comment};

    String token = await getToken();
    var response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: data);

    print(response.body);

    var content = json.decode(response.body);
    if (content['status'] == '1') {
      setState(() {
        Fluttertoast.showToast(
          msg: "Rating has been posted".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
        );
      });
    } else {
      Fluttertoast.showToast(
        msg: "Rating was not posted".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
      );
    }
  }

  void _showRatingDialog() {
    final _dialog = RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: Text(
        "Rate User".tr,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        'Tap a star to set your rating. Add more description here if you want.'
            .tr,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 13),
      ),
      // your app's logo?
      //image: const FlutterLogo(size: 50),
      submitButtonText: 'Submit'.tr,
      commentHint: 'Write a comment...'.tr,
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        postRating(response.rating.toInt().toString(), response.comment);
        print(
            'rating: ${response.rating.toInt().toString()}, comment: ${response.comment}');
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 27, 120, 196), // 1
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
                    onPressed: () {
                      // setState(() {
                      //   showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return ThemeHelper().alartDialog("Notifications".tr,
                      //           "There are no notifications".tr, context);
                      //     },
                      //   );
                      // });
                    },
                    icon: Icon(Icons.message),
                  )
                ],
              ),
            )
          ],
        ),
        drawer: MyDrawer(currentPage: 'Profile'.tr),
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 20,
                                            ),
                                            Text(
                                              avg,
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Card(
                                                                child: Column(
                                                                  children: [
                                                                    Text(name,
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              50, 50, 93, 1),
                                                                          fontSize: 25.0, fontWeight: FontWeight.bold), ),
                                                                    SizedBox(height: 30,),
                                                                    Text(avg,
                                                                    style: TextStyle(
                                                                        color: Color.fromRGBO(
                                                                            50, 50, 93, 1),
                                                                        fontSize: 28.0, fontWeight: FontWeight.bold)),
                                                                    SizedBox(height: 10,),
                                                                    RatingBarIndicator(
                                                                      itemBuilder: (context, index) => Icon(
                                                                        Icons.star,
                                                                        color: Colors.amber,
                                                                      ),
                                                                      itemSize: 30.0,
                                                                      unratedColor: Colors.amber.withAlpha(50),
                                                                      rating: double.parse(avg),
                                                                    ),
                                                                  ]),
                                                              ),
                                                            ),
                                                          ),
                                                          content:
                                                              setupAlertDialoadContainer(
                                                                  context),
                                                        );
                                                      });
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: LoginUIColors.info,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      spreadRadius: 1,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Text(
                                                  "RATINGS".tr,
                                                  style: TextStyle(
                                                      color:
                                                          LoginUIColors.white,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0,
                                                    vertical: 8.0),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30.0,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // Respond to button press
                                                _showRatingDialog();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: LoginUIColors.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      spreadRadius: 1,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Text(
                                                  "RATE USER".tr,
                                                  style: TextStyle(
                                                      color:
                                                          LoginUIColors.white,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0,
                                                    vertical: 8.0),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
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
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 32.0, right: 32.0),
                                          child: Align(
                                            child: Text(
                                                "An artist of considerable range, I provide quality service",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        82, 95, 127, 1),
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w200)),
                                          ),
                                        ),
                                        SizedBox(height: 15.0),
                                        Align(
                                            child: Text("Show more",
                                                style: TextStyle(
                                                    color:
                                                        LoginUIColors.primary,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0))),
                                        SizedBox(height: 25.0),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 25.0, left: 25.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Listings".tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: LoginUIColors.text),
                                              ),
                                              Text(
                                                "View All".tr,
                                                style: TextStyle(
                                                    color:
                                                        LoginUIColors.primary,
                                                    fontSize: 13.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 250,
                                          child: GridView.count(
                                              primary: false,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24.0,
                                                  vertical: 15.0),
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              crossAxisCount: 3,
                                              children: <Widget>[
                                                Container(
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  6.0)),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://images.unsplash.com/photo-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80"),
                                                          fit: BoxFit.cover),
                                                    )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1551798507-629020c81463?fit=crop&w=240&q=80"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?fit=crop&w=240&q=80"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1503642551022-c011aafb3c88?fit=crop&w=240&q=80"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=240&q=80"),
                                                      fit: BoxFit.cover),
                                                )),
                                              ]),
                                        )
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
                            alignment: FractionalOffset(0.5, 0.0),
                          ))
                    ]),
                  ],
                ),
              ),
            ]),
          ),
        ]));
  }

  Widget setupAlertDialoadContainer(BuildContext context) {
    return FutureBuilder(
        // height: 300.0, // Change as per your requirement
        // width: 300.0, // Change as per your requirement
        future: getRating(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? Container(
                  height: 200.0, // Change as per your requirement
                  width: 300.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    //shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      List list = snapshot.data;
                      String img = "";
                      getProfile(img, list[index]["fk_i_from_user_id"]);
                      print('img ' + img);
                      return Card(
                          child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CircleAvatar(
                                  child: Image.network(
                                  "https://allmenkul.com/oc-content/plugins/profile_picture/images/profile"+ list[index]["fk_i_from_user_id"] + ".jpg",
                                  fit: BoxFit.fill,
                                )),
                          // (img.isNotEmpty)
                          //     ? CircleAvatar(
                          //         child: Image.network(
                          //         "https://allmenkul.com/oc-content/plugins/profile_picture/images/" +
                          //             img,
                          //         fit: BoxFit.fill,
                          //       ))
                          //     : Icon(
                          //         Icons.person,
                          //         size: 30,
                          //         color: Colors.grey.shade300,
                          //       ),
                        ),
                        title: RatingBarIndicator(
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemSize: 20.0,
                          unratedColor: Colors.amber.withAlpha(50),
                          rating: double.parse(list[index]["i_cat0"]),
                        ), //Text('Two-line ListTile')
                        subtitle: Text(list[index]["s_comment"]),
                        trailing: Text(list[index]["d_datetime"].substring(0, 10), style: TextStyle(fontSize: 10),),
                      ));
                    },
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
