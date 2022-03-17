// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchWidget extends StatelessWidget {
  //final ValueChanged onChanged;
  final GestureTapCallback press;

  const SearchWidget({Key? key, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(40),
      ),
      child: GestureDetector(
        child: TextField(
          //onChanged: onChanged,
          onTap: press,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.search,
                color: Colors.grey,
                size: 22,
              ),
            ),
            hintText: 'Search'.tr,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
