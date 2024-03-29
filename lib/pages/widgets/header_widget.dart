// ignore_for_file: unnecessary_new, deprecated_member_use, no_logic_in_create_state, prefer_final_fields, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HeaderWidget extends StatefulWidget {
  final double _height;
  final bool _showIcon;
  final IconData _icon;

  const HeaderWidget(this._height, this._showIcon, this._icon);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  // double _height;
  // bool _showIcon;
  // IconData _icon;

  // _HeaderWidgetState(this._height, this._showIcon, this._icon);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      child: Stack(
        children: [
          // ClipPath(
          //   child: Container(
          //     decoration: new BoxDecoration(
          //       gradient: new LinearGradient(
          //           colors: [
          //             Theme.of(context).primaryColor.withOpacity(0.4),
          //             Theme.of(context).accentColor.withOpacity(0.4),
          //           ],
          //           begin: const FractionalOffset(0.0, 0.0),
          //           end: const FractionalOffset(1.0, 0.0),
          //           stops: [0.0, 1.0],
          //           tileMode: TileMode.clamp
          //       ),
          //     ),
          //   ),
          //   clipper: new ShapeClipper(
          //       [
          //         Offset(width / 5, _height),
          //         Offset(width / 10 * 5, _height - 60),
          //         Offset(width / 5 * 4, _height + 20),
          //         Offset(width, _height - 18)
          //       ]
          //   ),
          // ),
          // ClipPath(
          //   child: Container(
          //     decoration: new BoxDecoration(
          //       gradient: new LinearGradient(
          //           colors: [
          //             Theme.of(context).primaryColor.withOpacity(0.4),
          //             Theme.of(context).accentColor.withOpacity(0.4),
          //           ],
          //           begin: const FractionalOffset(0.0, 0.0),
          //           end: const FractionalOffset(1.0, 0.0),
          //           stops: [0.0, 1.0],
          //           tileMode: TileMode.clamp
          //       ),
          //     ),
          //   ),
          //   clipper: new ShapeClipper(
          //       [
          //         Offset(width / 3, _height + 20),
          //         Offset(width / 10 * 8, _height - 60),
          //         Offset(width / 5 * 4, _height - 60),
          //         Offset(width, _height - 20)
          //       ]
          //   ),
          // ),
          ClipPath(
            child: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget._showIcon,
            child: Container(
              height: widget._height - 20,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.only(
                    left: 5.0,
                    top: 20.0,
                    right: 5.0,
                    bottom: 20.0,
                  ),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    border: Border.all(width: 5, color: Colors.white, style: BorderStyle.solid),
                  ),
                  child: widget._showIcon ? Icon(
                    widget._icon,
                    color: Colors.white,
                    size: 35.0,
                  ) : Image.asset(
                        'assets/images/google-logo.png',
                        height: 25,
                        width: 25,
                      ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class ShapeClipper extends CustomClipper<Path> {
  List<Offset> _offsets = [];
  ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height-20);

    // path.quadraticBezierTo(size.width/5, size.height, size.width/2, size.height-40);
    // path.quadraticBezierTo(size.width/5*4, size.height-80, size.width, size.height-20);

    path.quadraticBezierTo(_offsets[0].dx, _offsets[0].dy, _offsets[1].dx,_offsets[1].dy);
    path.quadraticBezierTo(_offsets[2].dx, _offsets[2].dy, _offsets[3].dx,_offsets[3].dy);

    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.close();


    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}