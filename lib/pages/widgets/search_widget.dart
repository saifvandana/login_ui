// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final ValueChanged onChanged;

  const SearchWidget({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.all(20),
      // padding: EdgeInsets.symmetric(
      //   horizontal: 10,
      //   vertical: 4,
      // ),
      padding: EdgeInsets.all(8),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: Padding(
            padding: EdgeInsets.zero,
            child: Icon(
              Icons.search,
              color: Colors.grey,
              size: 22,
            ),
          ),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
        ),
      ),
    );
  }
}