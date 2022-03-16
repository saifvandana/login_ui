// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  //final ValueChanged onChanged;
  final GestureTapCallback press;

  const SearchWidget({Key? key, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
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
      ),
    );
  }
}
