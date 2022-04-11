// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, prefer_const_declarations, dead_code, avoid_print, unnecessary_null_comparison

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/data.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(this.newListing, this.index);

  final Listing newListing;
  final int index;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                  color: Colors.white,
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
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 180,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                width: 130,
                padding: EdgeInsets.symmetric(
                  vertical: 4,
                ),
                child: Center(
                  child: Text(
                    "FOR ".tr + widget.newListing.info[widget.index]['process'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 170,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.newListing.info[widget.index]['title'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
                    Divider(
                      color: Colors.grey[500],
                      height: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.all(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_pin,
                                size: 60,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.newListing.info[widget.index]
                                        ['name'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Property Owner".tr,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey[500],
                      height: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 24, left: 24, bottom: 24, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildFeature(Icons.hotel, "3 Bedroom".tr),
                          buildFeature(Icons.wc, "2 Bathroom".tr),
                          buildFeature(Icons.kitchen, "1 Kitchen".tr),
                          buildFeature(Icons.local_parking, "2 Parking".tr),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 24,
                        left: 24,
                        bottom: 16,
                      ),
                      child: Text(
                        "Photos",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: buildPhotos(widget.newListing.images),
                    ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: EdgeInsets.only(
                    //       bottom: 24,
                    //     ),
                    //     child: ListView(
                    //       physics: BouncingScrollPhysics(),
                    //       scrollDirection: Axis.horizontal,
                    //       shrinkWrap: true,
                    //       children: [],//buildPhotos(widget.newListing.images),
                    //     ),
                    //   ),
                    // ),
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
                ),
              );
            },
          ))),
        ],
      ),
    ));
  }

  Widget buildCarousel(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final List<Widget> imageSliders = widget.newListing.images
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.only(
                  left: 1,
                ),
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
                        Positioned.fill(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              '',
                              //'${widget.newListing.images.indexOf(item)}',
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
                widget.newListing.info[widget.index][subtitle],
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
    return SizedBox(
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(16),
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              url,
              height: 150,
              cacheHeight: 150,
              fit: BoxFit.cover,
              //opacity: 1,
            ),
          ),
        ),),
    );
  }

  Widget buildFeature(IconData iconData, String text) {
    return Column(
      children: [
        Icon(
          iconData,
          color: Colors.yellow[700],
          size: 28,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 14,
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
