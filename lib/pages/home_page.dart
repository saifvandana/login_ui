// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/services.dart';
import 'package:footer/footer_view.dart';
import 'package:login_ui/pages/section_page.dart';

import 'package:login_ui/pages/login_page.dart';
import '../common/theme_helper.dart';
import '../data/data.dart';
import 'widgets/category_item.dart';
import 'widgets/search_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    double bgImageHeight = height / 2.8;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          centerTitle: true,
          title: SizedBox(
            child: Icon(
              Icons.android_outlined,
              color: Theme.of(context).primaryColor,
              size: 50,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              icon: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
          backgroundColor: Colors.white,
          elevation: 10,
          iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        ),
        body: FooterView(children: [
          Stack(children: [
            Container(
              height: bgImageHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/ankara_02.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: bgImageHeight - 90,
                    ),
                    child: Center(
                      child: RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "All",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 45,
                            )),
                        TextSpan(
                            text: "Menkul",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 45,
                            )),
                      ])),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: SearchWidget(onChanged: (value) {}),
                  ),

                  // Padding(
                  //   padding: EdgeInsets.only(top: 16, left: 30, right: 30),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [

                  //       Expanded(
                  //         child: Container(
                  //           height: 32,
                  //           child: Stack(
                  //             children: [
                  //               GestureDetector(
                  //                 child: ListView(
                  //                   physics: BouncingScrollPhysics(),
                  //                   scrollDirection: Axis.horizontal,
                  //                   children: [

                  //                     SizedBox(
                  //                       width: 24,
                  //                     ),
                  //                     buildFilter("House"),
                  //                     buildFilter("Price"),
                  //                     buildFilter("Rent"),
                  //                     buildFilter("Apartment"),
                  //                     buildFilter("Bedrooms"),
                  //                     SizedBox(
                  //                       width: 8,
                  //                     ),

                  //                   ],
                  //                 ),
                  //                 onTap: () {
                  //                   Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             SectionPage()));
                  //                 },
                  //               ),

                  //             ],
                  //           ),
                  //         ),
                  //       ),

                  //       // GestureDetector(
                  //       //   onTap: (){
                  //       //     _showBottomSheet();
                  //       //   },
                  //       //   child: Padding(
                  //       //     padding: EdgeInsets.only(left: 16, right: 24),
                  //       //     child: Text(
                  //       //       "Filters",
                  //       //       style: TextStyle(
                  //       //         fontSize: 18,
                  //       //         fontWeight: FontWeight.bold,
                  //       //       ),
                  //       //     ),
                  //       //   ),
                  //       // ),

                  //     ],
                  //   ),
                  // ),

                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0),
                    child: listCategories(),
                  ),
                ],
              ),
            ),
          ],)  
        ],
        footer: Footer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Copyright ©2022, All Rights Reserved.',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0, color: Color(0xFF162A49)),),
              Text('Powered by Allmenkul',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0,color: Color(0xFF162A49)),),
            ],
          )),
        ),
        floatingActionButton: FloatingActionButton(
          child: IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.chat)
          ),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            setState(() {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ThemeHelper().alartDialog(
                      "Chat with us",
                      "Log in to chat with us",
                      context);
                },
              );
            });
          },
        ));
  }

  Widget buildFilter(String filterName) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          )),
      child: Center(
        child: Text(
          filterName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return Wrap(
            children: [],
          );
        });
  }

  int selectedCategory = 0;
  listCategories() {
    List<Widget> lists = List.generate(
        categories.length,
        (index) => CategoryItem(
              data: categories[index],
              selected: index == selectedCategory,
              onTap: () {
                setState(() {
                  selectedCategory = index;
                });
              },
            ));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }
}
