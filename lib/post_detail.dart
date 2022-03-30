// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, unused_element, avoid_print, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data/data.dart';

class PostDetail extends StatelessWidget {
  // PostDetail({required this.posts});
  PostDetail({required this.str});

  //final List posts;
  final String str;

  @override
  Widget build(BuildContext context) {
    var url = BASEURL + "getImages.php";

    Future getImages() async {
      Map data = {'unique_string': str};
      var response = await http.post(Uri.parse(url), body: data);

      print(response.body);
      final content = json.decode(response.body);
     
      return json.decode(response.body);
    }

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
          future: getImages(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      List list = snapshot.data;
                      return Card(
                        child: ListTile(
                          title: Container(
                            margin: EdgeInsets.fromLTRB(25, 60, 25, 10),
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Image.network(
                                BASEURL + "img/${list[index]['image']}"),
                            width: 100,
                            height: 100,
                          ),
                          // subtitle: Center(
                          //     child: Column(
                          //   children: [
                          //     Text("Posted by " + list[index]['name']),
                          //     Text("On: " + list[index]['datetime']),
                          //   ],
                          // ))
                        ),
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }

  List<Widget> buildPhotos(List<String> images) {
    List<Widget> list = [];
    list.add(SizedBox(
      width: 24,
    ));
    for (var i = 0; i < images.length; i++) {
      list.add(buildPhoto(images[i]));
    }
    return list;
  }

  Widget buildPhoto(String url) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        margin: EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          image: DecorationImage(
            image: AssetImage(url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}