// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Filter extends StatefulWidget {
  const Filter({ Key? key }) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {

  var selectedRange = RangeValues(400, 1000);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 24, left: 24, top: 32, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Text(
                "Filter".tr,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                width: 8,
              ),

              Text(
                "your search".tr,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),

            ],
          ),

          SizedBox(
            height: 32,
          ),

          Row(
            children: [

              Text(
                "Price".tr,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                width: 8,
              ),

              Text(
                "range".tr,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),

            ],
          ),

          RangeSlider(
            values: selectedRange,
            onChanged: (RangeValues newRange) {
              setState(() {
                selectedRange = newRange;
              });
            },
            min: 70,
            max: 1000,
            activeColor: Colors.blue[900],
            inactiveColor: Colors.grey[300],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                r"TL70k",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),

              Text(
                r"TL1000k",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),

            ],
          ),

          SizedBox(
            height: 16,
          ),

          Text(
            "Rooms".tr,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            height: 16,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              buildOption("Any".tr, false),
              buildOption("1", false),
              buildOption("2", true),
              buildOption("3+", false),

            ],
          ),

          SizedBox(
            height: 16,
          ),

          Text(
            "Bathrooms".tr,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            height: 16,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              buildOption("Any".tr, true),
              buildOption("1", false),
              buildOption("2", false),
              buildOption("3+", false),

            ],
          ),

        ],
      ),
    );
  }

  Widget buildOption(String text, bool selected){
    return Container(
      height: 45,
      width: 65,
      decoration: BoxDecoration(
        color: selected ? Colors.blue[900] : Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(
          width: selected ? 0 : 1,
          color: Colors.grey,
        )
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}