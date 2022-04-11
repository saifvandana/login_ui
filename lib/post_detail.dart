// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, unused_element, avoid_print, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'data/data.dart';

class PostDetail extends StatelessWidget {
  PostDetail({required this.newListing, required this.index});

  final Listing newListing;
  final int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _percent = 0.0;

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Positioned.fill(
            bottom: size.height * 0.45,
            child: buildCarousel(context),
          ),
          Positioned(
            left: 20,
            top: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                        Color.fromARGB(0, 0, 0, 19),
                        Colors.black.withOpacity(0.7),
                    ],
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  //color: Color.fromARGB(0, 221, 38, 38),
                ),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Color.fromARGB(255, 219, 214, 214),
                  size: 30,
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                        Color.fromARGB(0, 0, 0, 19),
                        Colors.black.withOpacity(0.7),
                    ],
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  //color: Color.fromARGB(0, 221, 38, 38),
                ),
                child: Icon(
                  Icons.more_horiz_outlined,
                  color: Color.fromARGB(255, 219, 214, 214),
                  size: 30,
                ),
              ),
            ),
          ),
          Positioned.fill(
              child: NotificationListener<DraggableScrollableNotification>(
                  // onNotification: (notification) {
                  //   // setState(() {
                  //   //   _percent = 2 * notification.extent - 0.8;
                  //   // });

                  //   // return true;
                  // },
                  child: DraggableScrollableSheet(
            maxChildSize: 0.9,
            minChildSize: 0.5,
            initialChildSize: 0.7,
            builder: (_, controller) {
              return Material(
                  elevation: 10,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Colors.white,
                  child: ListView(
                    controller: controller,
                    children: [
                      Center(
                          child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 4,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 212, 209, 209),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 24, left: 24, bottom: 16, top: 15),
                            child: Text(
                              "Listing Info".tr,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )),
                      buildInfo(context, 'Property Owner'.tr, 'name'),
                      buildInfo(context, 'Title'.tr, 'title'),
                      buildInfo(context, 'About'.tr, 'about'),
                      buildInfo(context, 'Phone'.tr, 'phone'),
                      buildInfo(context, 'Email'.tr, 'email'),
                      buildInfo(context, 'Price'.tr, 'price'),
                      buildInfo(context, 'Process'.tr, 'process'),
                      buildInfo(context, 'State'.tr, 'state'),
                      buildInfo(context, 'Address'.tr, 'address'),
                      buildInfo(context, 'Posted on'.tr, 'datetime'),
                    ],
                  ));
            },
          ))),
          Positioned(
            left: 0,
            right: 0,
            top: -170 * (1 - _percent),
            child: Opacity(opacity: _percent, child: appBar(context)),
          ),
        ],
      )),
    );
  }

  Widget buildCarousel(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final List<Widget> imageSliders = newListing.images
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.only(left: 1, top: 1),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          item,
                          fit: BoxFit.cover,
                          width: 1000.0,
                          height: 1000,
                          //cacheWidth: (size.width * 1).toInt(),
                          //cacheHeight: (size.height * 0.6).toInt(),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              //'',
                              '${newListing.images.indexOf(item)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    return CarouselSlider(
      options: CarouselOptions(
        //aspectRatio: 1,
        //viewportFraction: 0.79,
        autoPlay: true,
        height: size.height * 0.6,
        autoPlayCurve: Curves.fastOutSlowIn,
        //enlargeCenterPage: true,
        // enlargeStrategy: CenterPageEnlargeStrategy.scale,
      ),
      items: imageSliders,
    );
  }

  Widget buildInfo(BuildContext context, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: Colors.grey[500],
          height: 1,
        ),
        Padding(
          padding: EdgeInsets.only(right: 24, left: 24, bottom: 16, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                newListing.info[index][subtitle],
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget appBar(BuildContext context) {
    return Material(
        elevation: 10,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 24,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.more_horiz,
                color: Colors.black,
                size: 24,
              ),
            ),
          ],
        ));
  }
}
