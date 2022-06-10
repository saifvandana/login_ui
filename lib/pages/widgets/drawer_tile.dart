import 'package:flutter/material.dart';
import 'package:login_ui/constants/Theme.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final bool isSelected;
  final Color iconColor;

  DrawerTile(
      {required this.title,
      required this.icon,
      required this.onTap,
      this.isSelected = false,
      this.iconColor = LoginUIColors.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          margin: EdgeInsets.only(top: 6),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: isSelected
                        ? LoginUIColors.black.withOpacity(0.07)
                        : Colors.transparent,
                    offset: Offset(0, 0.5),
                    spreadRadius: 3,
                    blurRadius: 10)
              ],
              color: isSelected ? LoginUIColors.white : LoginUIColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(54))),
          child: Row(
            children: [
              // Icon(icon,
              //     size: 18,
              //     color: isSelected
              //         ? LoginUIColors.primary
              //         : LoginUIColors.white.withOpacity(0.6)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(title,
                    style: TextStyle(
                        letterSpacing: .3,
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        color: isSelected
                            ? LoginUIColors.primary
                            : LoginUIColors.white.withOpacity(0.8))),
              )
            ],
          )),
    );
  }
}
