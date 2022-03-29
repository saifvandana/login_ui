// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, prefer_const_declarations, dead_code, avoid_print, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_ui/data/data.dart';
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
    var response = await http.post(
      Uri.parse(url), 
      body: data);
     print(response.body);
     //print(email);
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
                            subtitle: Center(
                                child: Column(
                              children: [
                                Text("Posted by " + list[index]['name']),
                                Text("On: " + list[index]['datetime']),
                              ],
                            ))),
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}
