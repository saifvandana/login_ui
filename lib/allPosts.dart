// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, prefer_const_declarations, dead_code, avoid_print, unused_local_variable, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:login_ui/data/data.dart';
import 'package:login_ui/details_page.dart';
import 'package:login_ui/post_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/theme_helper.dart';

class AllPosts extends StatefulWidget {
  const AllPosts({Key? key}) : super(key: key);

  @override
  State<AllPosts> createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  var url = BASEURL + "allPosts.php";
  String email = '';

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

  Future allPosts() async {
    var response = await http.post(Uri.parse(url),);
    print(response.body);
    return json.decode(response.body);
  }

  Future getImages(List list, List<String> images, int index) async {
    var url = BASEURL + "getImages.php";

    Map data = {'unique_string': list[index]['unique_string']};
    var response = await http.post(Uri.parse(url), body: data);

    final content = json.decode(response.body);

    for (var i = 0; i < content.length; i++) {
      if (images.length < content.length) {
        images.add(BASEURL + "img/" + content[i]['image']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Posts".tr,
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
          future: allPosts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      List list = snapshot.data;
                      List<String> images = [];
                      getImages(list, images, index);

                      Listing newListing = new Listing(list, images);
                      return GestureDetector(
                        child: buildListing(context, list, index),
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

  Widget buildListing(BuildContext context, List list, int index) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
        child: Card(
            elevation: 4,
            margin: EdgeInsets.all(16),
            // //clipBehavior: Clip.antiAlias,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(15),
            //   ),
            // ),
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
                          BASEURL + "img/${list[index]['image']}",
                          cacheHeight: 250,
                          cacheWidth: (width - 30).toInt(),
                          fit: BoxFit.cover,
                          //opacity: 1,
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
                            // Container(
                            //   decoration: BoxDecoration(
                            //     color: Colors.yellow[700],
                            //     borderRadius: BorderRadius.all(
                            //       Radius.circular(5),
                            //     ),
                            //   ),
                            //   width: 100,
                            //   padding: EdgeInsets.symmetric(
                            //     vertical: 4,
                            //   ),
                            //   child: Center(
                            //     child: Text(
                            //       "FOR ".tr + list[index]['process'],
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: 14,
                            //         //fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                });
                              },
                              color: Colors.yellow[700], 
                              icon: Icon(Icons.favorite_border),
                            ),
                          ]),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 210, left: 10),
                      child: Text(
                        list[index]['name'],
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
                                    list[index]['location'],
                                    style: TextStyle(
                                      color: Colors.brown,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 110,
                                  ),
                                  Text(
                                    list[index]['datetime'],
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
                            list[index]['title'],
                            style: TextStyle(
                              color: Colors.brown,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: list[index]['price'],
                                  style: TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),  
                        ]))
              ],
            )));
  }
}
