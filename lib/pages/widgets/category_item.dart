// ignore_for_file: unnecessary_new, deprecated_member_use, no_logic_in_create_state, prefer_final_fields, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_import, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(
      {Key? key, required this.data, this.selected = false, this.onTap})
      : super(key: key);
  final data;
  final bool selected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;
    Color cardColor = Color.fromARGB(255, 229, 226, 226);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
        margin: EdgeInsets.only(right: 10),
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: selected ? primary : cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 221, 218, 218).withOpacity(0.1),
              spreadRadius: .5,
              blurRadius: .5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(data["icon"],
                size: 25, color: selected ? Colors.white : primary),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Text(
                data["name"],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13, color: selected ? Colors.white : primary),
              ),
            ),
            // Visibility(
            //   visible: selected,
            //   child: Container(
            //     width: double.infinity, height: 2,
            //     decoration: BoxDecoration(
            //       color: primary,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
