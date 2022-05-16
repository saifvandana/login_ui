// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, prefer_const_declarations, dead_code, avoid_print, unused_local_variable, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:login_ui/data/data.dart';
import 'package:login_ui/details_page.dart';
import 'package:login_ui/post_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/theme_helper.dart';

class MyPost extends StatefulWidget {
  const MyPost({Key? key}) : super(key: key);

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  var url =
      "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/search";
  String email = '';
  String itemId = '';
  //List<String> images = [];
  List<String> testurl = [
    "https://cdn.vox-cdn.com/thumbor/0Evrn26bKYe5IA19SwiQ96ZrrF4=/0x0:1086x724/970x728/filters:focal(457x276:629x448):format(webp):no_upscale()/cdn.vox-cdn.com/uploads/chorus_image/image/62581501/1_1118165_18_1496251977.0.0.jpg",
    "https://seattledreamhomes.com/wp-content/uploads/2021/04/Fancy-house-636x500.jpg",
    "https://cdn.vox-cdn.com/thumbor/dK9BJ2AUCPUk10X-DKpqlmFZGA0=/0x0:1113x706/970x728/filters:focal(468x264:646x442):format(webp):no_upscale()/cdn.vox-cdn.com/uploads/chorus_image/image/62581502/1_1186768_0_1504892016.0.0.jpg",
    "https://cdn.vox-cdn.com/thumbor/AxFn_bDwvaDm189mxO7lbXOnFlE=/0x0:1086x724/970x728/filters:focal(457x276:629x448):format(webp):no_upscale()/cdn.vox-cdn.com/uploads/chorus_image/image/62581504/1_1115943_0_1502982217.0.0.jpg",
    "https://cdn.vox-cdn.com/thumbor/l6ePj_qoPFK4RrfwWZTw4oLqNEo=/0x0:1086x723/970x728/filters:focal(457x276:629x448):format(webp):no_upscale()/cdn.vox-cdn.com/uploads/chorus_image/image/62581505/1_1148514_0_1499470467.0.0.jpg",
    "https://cdn.vox-cdn.com/thumbor/tFM0x9Nq_Qb5bKMNOtFBlC-JxXs=/0x0:1086x724/970x728/filters:focal(457x276:629x448):format(webp):no_upscale()/cdn.vox-cdn.com/uploads/chorus_image/image/62581506/1_1185203_0_1503983744.0.0.jpg",
  ];

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email')!;
    });
  }

  Future getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future myPosts() async {
    String token = await getToken();
    final url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/user/my-items";
    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    final content = json.decode(response.body);
    var myitem = content['items'];
    print(myitem);
    // myitem.removeWhere((element) => element["s_contact_email"] != email);
    print(myitem.length);
    return myitem;
  }

  Future deletePost(String itemId) async {
    String token = await getToken();

    final url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/item/" + itemId;
    var response = await http.delete(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    final content = json.decode(response.body);

    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        Fluttertoast.showToast(
          msg: "Listing has been deleted".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
        );
      });
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => MyPost()));
    } else {
      Fluttertoast.showToast(
        msg: "${content['message']}", //"email or password invalid".tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
      );
    }
  }

  void getImages(List list, List<String> images) {
    for (var i = 0; i < list.length; i++) {
      images.add("https://allmenkul.com/" +
          list[i]['s_path'] +
          list[i]['pk_i_id'] +
          "." +
          list[i]['s_extension']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Listings".tr,
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
      body: FutureBuilder(
          future: myPosts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      List list = snapshot.data;
                      List<String> images = [];
                      getImages(list[index]['resources'], images);

                      // print("length of resources: " +
                      //     list[index]['resources'].length.toString());
                      // print(images);
                      Listing newListing = (images.isNotEmpty)
                          ? new Listing(list, images)
                          : new Listing(list, testurl);
                      return GestureDetector(
                        child: (images.isNotEmpty)
                            ? buildListing(context, list, index, images[0])
                            : buildListing(context, list, index, testurl[0]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      newListing,
                                      index,
                                    )),
                          );
                        },
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }

  Widget buildListing(BuildContext context, List list, int index, String img) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
        child: Card(
            elevation: 4,
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.antiAlias,
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)),
                        child: Image.network(
                          img,
                          cacheHeight: 250,
                          cacheWidth: (width - 30).toInt(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(0, 19, 19, 19),
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Notifications".tr,
                                          "There are no notifications".tr,
                                          context);
                                    },
                                  );
                                });
                              },
                              color: Colors.white,
                              icon: Icon(Icons.notifications_none_sharp),
                              iconSize: 30,
                            ),
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 210, left: 10),
                      child: Text(
                        list[index]["s_user_name"] ??
                            list[index]["s_contact_name"],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.brown,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    list[index]["s_region"] ?? "Ankara",
                                    style: TextStyle(
                                      color: Colors.brown,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 110,
                                  ),
                                  Text(
                                    list[index]["dt_pub_date"],
                                    style: TextStyle(
                                      color: Colors.brown,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            list[index]["s_title"] ?? "No Title",
                            style: TextStyle(
                              color: Colors.brown,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: list[index]["i_price"] == null
                                        ? "TL5000000"
                                        : list[index]["i_price"] + (list[index]["fk_c_currency_code"] ?? 'TL'),
                                    style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                //setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return customDialog(
                                          "Delete Listing".tr,
                                          "Do you want to delete listing".tr,
                                          context, list[index]["pk_i_id"]);
                                    },
                                  );
                                //});
                              },
                              color: Colors.red,
                              icon: Icon(Icons.delete),
                              iconSize: 30,
                            ),
                          ],)
                        ]))
              ],
            )));
  }

  AlertDialog customDialog(String title, String content, BuildContext context, String itemId) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            deletePost(itemId);
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color.fromARGB(96, 0, 0, 0))),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
