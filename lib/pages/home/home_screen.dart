// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_import, prefer_is_not_empty, deprecated_member_use, avoid_unnecessary_containers, unused_import, prefer_final_fields, unnecessary_new

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/getwidget.dart';
import 'package:login_ui/pages/login_page.dart';
import 'package:login_ui/pages/widgets/banner_widget.dart';
import 'package:login_ui/pages/widgets/header_widget.dart';
import 'package:login_ui/pages/widgets/map_widget.dart';
import 'package:login_ui/pages/widgets/search_widget.dart';
import 'package:login_ui/pages/widgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOPtions = <Widget>[
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    LoginPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
              icon: Icon(Icons.login),
            )
          ],
          backgroundColor: Colors.white,
          elevation: 0.5,
          iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        ),
        body: SingleChildScrollView(
            child: Stack(
          children: <Widget>[
            //_widgetOPtions.elementAt(_selectedIndex)
            // Container(
            //   height: 200,
            //   child: HeaderWidget(200, false, Icons.house_rounded),
            // ),
            
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  //SearchWidget(onChanged: (value) {}),
                  SizedBox(height: 20,),
                  BannerWidget(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: SectionTitle(title: "Go to Options", press: () {},),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    child: GFCard(
                      boxFit: BoxFit.cover,
                      titlePosition: GFPosition.start,
                      image: Image.asset(
                        'assets/images/house_01.jpg',
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      showImage: true,
                      content: Text("Lorem ipsum dolo")
                    ),
                    onTap: () {
                      // Navigator.pushReplacement(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) => MapWidget()),);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: SectionTitle(title: "Go to Options", press: () {},),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    child: GFCard(
                      boxFit: BoxFit.cover,
                      titlePosition: GFPosition.start,
                      image: Image.asset(
                        'assets/images/house_01.jpg',
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      showImage: true,
                      content: Text("Lorem ipsum dolo")
                    ),
                    onTap: () {
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: SectionTitle(title: "Go to Options", press: () {},),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    child: Card(),
                  ),
                  InkWell(
                    child: GFCard(
                      colorFilter: ColorFilter.linearToSrgbGamma(),
                      boxFit: BoxFit.cover,
                      elevation: 20,
                      border: Border.all(width: 5, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                      titlePosition: GFPosition.start,
                      showOverlayImage: true,
                      imageOverlay: AssetImage('assets/images/maps.jpg'),
                      title: GFListTile(
                        titleText: 'Maps',
                        subTitleText: 'Search from maps',
                      ),
                      content: Text(
                        'Go to maps',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () {
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: SectionTitle(title: "Go to Options", press: () {},),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    child: GFCard(
                      boxFit: BoxFit.cover,
                      titlePosition: GFPosition.start,
                      image: Image.asset(
                        'assets/images/house_01.jpg',
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      showImage: true,
                      content: Text("Lorem ipsum dolo")
                    ),
                    onTap: () {
                    },
                  ),
                ],
              ),
            ),
          ],
        )),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_sharp),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Login',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedIconTheme:
              IconThemeData(color: Theme.of(context).accentColor, size: 30),
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.grey,
        ));
  }
}
