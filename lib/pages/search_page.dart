// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_ui/pages/Detail.dart';
import 'package:login_ui/data/data.dart';
import 'package:login_ui/pages/filter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Property> properties = getPropertyList();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: EdgeInsets.only(top: 48, left: 24, right: 24, bottom: 16),
            child: TextField(
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,             
              ),
              decoration: InputDecoration(
                hintText: 'Search'.tr,
                hintStyle: TextStyle(
                  fontSize: 17,
                  color: Colors.grey[400],
                ),
                enabledBorder: UnderlineInputBorder(      
                  borderSide: BorderSide(color: Color.fromARGB(255, 190, 189, 189)),   
                ),  
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 189, 189, 189)),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 189, 189, 189)),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16,),
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
                            buildFilter("House".tr),
                            buildFilter("Price".tr),
                            buildFilter("Bedrooms".tr),
                            buildFilter("Garage".tr),
                            buildFilter("Swimming Pool".tr),
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

                GestureDetector(
                  onTap: (){
                    _showBottomSheet();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 24),
                    child: Text(
                      "Filters".tr,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

          // Padding(
          //   padding: EdgeInsets.only(right: 24, left: 24, top: 24, bottom: 12),
          //   child: Row(
          //     children: [

          //       Text(
          //         "53",
          //         style: TextStyle(
          //           fontSize: 15,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),

          //       SizedBox(
          //         width: 8,
          //       ),

          //       Text(
          //         "Results found",
          //         style: TextStyle(
          //           fontSize: 15,
          //         ),
          //       ),

          //     ],
          //   ),
          // ),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: buildProperties(),
              ),
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
          Radius.circular(5),
        ),
        border: Border.all(
          color: Color.fromARGB(255, 224, 224, 224),
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

  List<Widget> buildProperties(){
    List<Widget> list = [];
    for (var i = 0; i < properties.length; i++) {
      list.add(
        Hero(
          tag: properties[i].frontImage, 
          child: buildProperty(properties[i], i)
        )
      );
    }
    return list;
  }

  Widget buildProperty(Property property, int index){
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(property: property)),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 24),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Container(
          height: 210,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(property.frontImage), 
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  width: 80,
                  padding: EdgeInsets.symmetric(vertical: 4,),
                  child: Center(
                    child: Text(
                      "FOR ".tr + property.label,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          property.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          r"TL" + property.price,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          children: [

                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 13,
                            ),

                            SizedBox(
                              width: 4,
                            ),

                            Text(
                              property.location,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),

                            SizedBox(
                              width: 8,
                            ),

                            Icon(
                              Icons.zoom_out_map,
                              color: Colors.white,
                              size: 14,
                            ),

                            SizedBox(
                              width: 4,
                            ),

                            Text(
                              property.sqm + " sq/m",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),

                          ],
                        ),

                        Row(
                          children: [

                            Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                              size: 13,
                            ),

                            SizedBox(
                              width: 4,
                            ),

                            Text(
                              property.review + " Reviews".tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ],
                ),

              ],
            ),
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
            Filter(),
          ],
        );
      }
    );
  }

}