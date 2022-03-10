// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_page.dart';
import 'widgets/search_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          child: Icon(
            Icons.android_outlined,
            size: 50,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage()),);
            },
            icon: Icon(Icons.person),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: height / 3.5,),
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: <TextSpan> [
                    TextSpan(
                      text: "All",
                      style: TextStyle(
                        color: Color.fromARGB(255, 16, 238, 23), 
                        fontWeight: FontWeight.bold,
                        fontSize: 50,)
                    ),
                    TextSpan(
                      text: "Menkul",
                      style: TextStyle(
                        color: Color.fromARGB(255, 24, 100, 26), 
                        fontWeight: FontWeight.bold,
                        fontSize: 50,)
                    ),
                  ]
                )
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(top: 15, left: 30, right: 30),
            child: SearchWidget(onChanged: (value) {}),
          ), 

          Padding(
            padding: EdgeInsets.only(top: 16, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: Container(
                    height: 32,
                    child: Stack(
                      children: [

                        ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: [

                            SizedBox(
                              width: 24,
                            ),
                            buildFilter("House"),
                            buildFilter("Price"),
                            buildFilter("Security"),
                            buildFilter("Bedrooms"),
                            buildFilter("Bedrooms"),
                            SizedBox(
                              width: 8,
                            ),

                          ],
                        ),  

                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 28,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                    Theme.of(context).scaffoldBackgroundColor,
                                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        ),                      

                      ],
                    ),
                  ),
                ),

                // GestureDetector(
                //   onTap: (){
                //     _showBottomSheet();
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.only(left: 16, right: 24),
                //     child: Text(
                //       "Filters",
                //       style: TextStyle(
                //         fontSize: 18,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),

              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget buildFilter(String filterName){
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
        )
      ),
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

  void _showBottomSheet(){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context){ 
        return Wrap(
          children: [
          ],
        );
      }
    );
  }
}