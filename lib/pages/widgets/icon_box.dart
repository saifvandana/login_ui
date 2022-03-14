// ignore_for_file: unnecessary_new, deprecated_member_use, no_logic_in_create_state, prefer_final_fields, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_import, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  IconBox({ Key? key, required this.child, this.bgColor, this.onTap, this.borderColor = Colors.transparent, this.radius = 50}) : super(key: key);
  final Widget child;
  final Color borderColor;
  final Color? bgColor;
  final double radius;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}