// ignore_for_file: prefer_const_constructors, avoid_print, avoid_unnecessary_containers, annotate_overrides

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:comment_box/comment/test.dart';
import 'package:comment_box/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage(this.itemId);

  final String itemId;

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  String id = '', name = '', loggedIn = '', email = '';
  List filedata = [
    {
      'name': 'Dummy',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code'
    },
  ];

  @override
  void initState() {
    super.initState();
    getComments(filedata);
    getInfo();
  }

  Future getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future getInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('id')!;
      name = prefs.getString('name')!;
      email = prefs.getString('email')!;
      loggedIn = prefs.getString('loggedIn')!;
    });
  }

  Future getComments(List filedata) async {
    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/item/allcomment/" + widget.itemId;
    var response = await http.get(Uri.parse(url));
    var content = json.decode(response.body);
    //print(content);
    for (int i = 0; i < content.length; i++) {
      var value = {
        'id' : content[i]['pk_i_id'],
        'name': content[i]['s_author_name'],
        'pic': 'https://picsum.photos/300/30',
        'message': content[i]['s_body']
      };
      setState(() {
        if (content[i]["b_active"] == "1") {
          filedata.insert(0, value);
        }
      });
    }
    //print(filedata);
  }

  Future addComments(String str) async {
    String token = await getToken();
    var url =
        "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/item/comment";

    Map data = {
      'id': widget.itemId,
      'authorName': name,
      'authorEmail': email,
      'body': str,
      'userId': id,
    };

    var response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: data);
    var content = json.decode(response.body);
    print(content);
  }

  Future deleteComment(String id) async {

    String token = await getToken();
    var url = "https://allmenkul.com/oc-content/plugins/Osclass-API-main/api/item/comment?id=" + widget.itemId + "&comment=" + id;
    var response = await http.delete(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },);
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

  @override
  Widget build(BuildContext context) {
    //getComments(filedata);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Comment".tr,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
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
        body: Container(
          child: CommentBox(
            userImage: "https://picsum.photos/300/30",
            child: commentChild(filedata),
            labelText: 'Write a comment...'.tr,
            errorText: 'Comment cannot be blank'.tr,
            sendButtonMethod: () {
              if (formKey.currentState!.validate()) {
                //print(commentController.text);
                setState(() {
                  var value = {
                    'name': 'New User',
                    'pic': 'https://picsum.photos/300/30',
                    'message': commentController.text
                  };
                  //filedata.insert(0, value);
                  addComments(commentController.text);
                });
                commentController.clear();
                FocusScope.of(context).unfocus();
              } else {
                print("Not validated");
              }
            },
            formKey: formKey,
            commentController: commentController,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
          ),
        ));
  }

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  //print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
              trailing: (data[i]['name'] == name)
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return customDialog(
                                "Delete Comment".tr,
                                "Do you want to delete comment".tr,
                                context,
                                data[i]['id']);
                          },
                        );
                      },
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      iconSize: 20,
                    )
                  : null,
            ),
          )
      ],
    );
  }

  AlertDialog customDialog(
      String title, String content, BuildContext context, String commentId) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: Text(
            "Yes".tr,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            setState(() {
              deleteComment(commentId);
              Navigator.of(context).pop();
            });
          },
        ),
        TextButton(
          child: Text(
            "No".tr,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(96, 0, 0, 0))),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
