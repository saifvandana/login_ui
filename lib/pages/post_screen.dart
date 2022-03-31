// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, prefer_const_declarations, dead_code, avoid_print, unused_local_variable, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:login_ui/data/data.dart';
import 'package:login_ui/post_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  var url = BASEURL + "viewAll.php";
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
    Map data = {'email': email};
    var response = await http.post(Uri.parse(url), body: data);
    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Posts",
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
                      Listing newListing = new Listing(list, images);
                      return GestureDetector(
                        child: buildListing(context, list, index),
                        // child: Card(
                        //   child: ListTile(
                        //       title: Container(
                        //         margin: EdgeInsets.fromLTRB(25, 60, 25, 10),
                        //         padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        //         child: Image.network(
                        //             BASEURL + "img/${list[index]['image']}"),
                        //         width: 100,
                        //         height: 100,
                        //       ),
                        //       subtitle: Center(
                        //           child: Column(
                        //         children: [
                        //           Text("Posted by " + list[index]['name']),
                        //           Text("On: " + list[index]['datetime']),
                        //         ],
                        //       ))),
                        // ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostDetail(
                                      newListing: newListing, index: index,
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
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage(BASEURL + "img/${list[0]['image']}"),
              //     fit: BoxFit.cover,
              //   ),
              // ),
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(0, 26, 26, 26),
                          Color.fromARGB(255, 29, 29, 29).withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 38, 64, 148),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            width: 100,
                            padding: EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            child: Center(
                              child: Text(
                                "FOR ".tr + list[index]['process'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(list[index]['title'],
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

                    SizedBox(
                      height: 4,
                    ),

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
                              width: 8,
                            ),

                            SizedBox(
                              width: 4,
                            ),
                          ],
                        ),
                     
                  ],
                ),
                ])
              
              )],
          ))
    );
  }
}
