// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, prefer_const_declarations, dead_code

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:footer/footer.dart';
import 'package:flutter/services.dart';
import 'package:footer/footer_view.dart';
import 'package:login_ui/allPosts.dart';
import 'package:login_ui/pages/forgot_password_page.dart';
import 'package:login_ui/pages/login_page.dart';
import 'package:login_ui/pages/logout_page.dart';
import 'package:login_ui/pages/registration_page.dart';
import 'package:login_ui/pages/section_page.dart';
import 'package:login_ui/pages/splash_screen.dart';
import 'package:login_ui/search_page.dart';
import 'forgot_password_verification_page.dart';
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
  double _drawerIconSize = 15;
  double _drawerFontSize = 15;

  final List locale = [
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'Türkçe', 'locale': Locale('tr', 'TR')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Choose Your Language'.tr),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(locale[index]['name']),
                        onTap: () {
                          //print(locale[index]['name']);
                          updateLanguage(locale[index]['locale']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

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
            child: Image.asset(
              'assets/images/allmenkul.jpg'//'assets/images/newlogo.svg',
              ),
            height: 30,
            // child: ImageIcon(
            //   AssetImage('assets/images/newlogo.svg'),
            //   //color: Theme.of(context).primaryColor,
            //   size: 40,
            // ),
            // child: Icon(
            //   Icons.android_outlined,
            //   color: Theme.of(context).primaryColor,
            //   size: 50,
            // ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            TextButton(
              onPressed: () {
                buildLanguageDialog(context);
              },
              child: Text('ENG'.tr),
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
        drawer: buildDrawer(context),
        body: FooterView(
          children: [
            Stack(
              children: [
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
                        padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                        child: SearchWidget(
                          //onChanged: (value) {},
                          press: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => SearchPage()),
                            // );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Center(
                          //child: listCategories(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: buildCategory(context, FontAwesomeIcons.boxes, "All".tr),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => AllPosts()),
                                  );
                                },
                              ),
                              GestureDetector(
                                child: buildCategory(context, FontAwesomeIcons.home, "Buy".tr),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => AllPosts()),
                                  );
                                },
                              ),
                              GestureDetector(
                                child: buildCategory(context, FontAwesomeIcons.building, "Rent".tr),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => AllPosts()),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
          footer: Footer(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Copyright ©2022, All Rights Reserved.'.tr,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12.0,
                    color: Color(0xFF162A49)),
              ),
              Text(
                'Powered by Allmenkul'.tr,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12.0,
                    color: Color(0xFF162A49)),
              ),
            ],
          )),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: IconButton(
        //       onPressed: () {
        //         setState(() {
        //           showDialog(
        //             context: context,
        //             builder: (BuildContext context) {
        //               return ThemeHelper().alartDialog("Chat with us".tr,
        //                   "Log in to chat with us".tr, context);
        //             },
        //           );
        //         });
        //       },
        //       icon: Icon(Icons.chat)),
        //   backgroundColor: Theme.of(context).primaryColor,
        //   onPressed: () {},
        // )
        // 
    );
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

  Widget buildDrawer(BuildContext context) {
    return Drawer(
        child: Container(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0.0,
                      1.0
                    ],
                    colors: [
                      Theme.of(context).primaryColor, //.withOpacity(0.2),
                      Theme.of(context).accentColor, //.withOpacity(0.2),
                    ])),
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Allmenkul",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.screen_lock_landscape_rounded,
              size: _drawerIconSize,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Splash Screen'.tr,
              style: TextStyle(
                  fontSize: _drawerFontSize,
                  color: Theme.of(context).accentColor),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SplashScreen(title: "Splash Screen".tr)));
            },
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.login_rounded,
              size: _drawerIconSize,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Login'.tr,
              style: TextStyle(
                  fontSize: _drawerFontSize,
                  color: Theme.of(context).accentColor),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: 5,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.person_add_alt_1,
              size: _drawerIconSize,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Registration Page'.tr,
              style: TextStyle(
                  fontSize: _drawerFontSize,
                  color: Theme.of(context).accentColor),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()));
            },
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.password_rounded,
              size: _drawerIconSize,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Forgot Password Page'.tr,
              style: TextStyle(
                  fontSize: _drawerFontSize,
                  color: Theme.of(context).accentColor),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordPage()));
            },
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: 10,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.password_rounded,
              size: _drawerIconSize,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Password Verification Page'.tr,
              style: TextStyle(
                  fontSize: _drawerFontSize,
                  color: Theme.of(context).accentColor),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordVerificationPage()));
            },
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.logout_rounded,
              size: _drawerIconSize,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Logout'.tr,
              style: TextStyle(
                  fontSize: _drawerFontSize,
                  color: Theme.of(context).accentColor),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LogoutPage()));
            },
          ),
        ],
      ),
    ));
  }

  int selectedCategory = 0;

  buildCategory(BuildContext context, IconData icon, String title) {
    Color primary = Theme.of(context).primaryColor;
    Color cardColor = Color.fromARGB(255, 229, 226, 226);
    final bool selected = true;

    return Container(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        margin: EdgeInsets.only(right: 10),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: selected ? primary : cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon,
                size: 15, color: selected ? Colors.white : primary),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13, color: selected ? Colors.white : primary),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SectionPage()),
                );
              },
            ));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }
}
