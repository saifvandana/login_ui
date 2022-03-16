// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import

import 'package:flutter/material.dart';
import 'package:login_ui/common/theme_helper.dart';
import 'package:login_ui/search_page.dart';

import 'widgets/section_title.dart';

class SectionPage extends StatefulWidget {
  const SectionPage({ Key? key }) : super(key: key);

  @override
  State<SectionPage> createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

     return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const CircleAvatar(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Good morning",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Admin",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 101, 10, 117),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          color: Color.fromARGB(255, 101, 10, 117),
                          onPressed: () {
                            setState(() {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ThemeHelper().alartDialog(
                                      "Notifications", "Log in to see notifications", context);
                                },
                              );
                            });
                          },
                          icon: const Icon(
                            Icons.notifications,
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: SectionTitle(
                      title: "Go to Options", 
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        );
                      },),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: SizedBox(
                      height: 320,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 280,
                            child: Card(
                              elevation: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                                      child:  Image.asset(
                                        'assets/images/house_02.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text("Sunny Apartment"),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 4),
                                          child: Text(
                                            "Ankara, Turkey",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "\TL9000",
                                                style: TextStyle(
                                                  color: Colors.brown,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              TextSpan(
                                                text: " /month",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: SectionTitle(
                      title: "Recommended", 
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        );
                      },),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                            },
                            child: SizedBox(
                              width: 280,
                              child: Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Hero(
                                        tag: "img_$index",
                                        child: SizedBox(
                                          width: 84,
                                          height: 84,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(9),
                                            child:  Image.asset(
                                              'assets/images/house_03.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: SectionTitle(
                      title: "Go to Options", 
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        );
                      },),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: SizedBox(
                      height: 320,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 200,
                            child: Card(
                              elevation: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                                      child:  Image.asset(
                                        'assets/images/house_08.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text("Sunny Apartment"),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 4),
                                          child: Text(
                                            "Ankara, Turkey",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "\TL9000",
                                                style: TextStyle(
                                                  color: Colors.brown,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              TextSpan(
                                                text: " /month",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: SectionTitle(
                      title: "Recommended", 
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        );
                      },),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                            },
                            child: SizedBox(
                              width: 280,
                              child: Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Hero(
                                        tag: "img_$index",
                                        child: SizedBox(
                                          width: 84,
                                          height: 84,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(9),
                                            child:  Image.asset(
                                              'assets/images/house_05.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                ],
              )
            ),
          ],
        ),
      )
     );
  }
}
      