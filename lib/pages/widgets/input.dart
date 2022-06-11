import 'package:flutter/material.dart';
import 'package:login_ui/constants/Theme.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final Widget suffixIcon;
  //final Widget prefixIcon;
  final Function onTap;
  final Function onChanged;
  final TextEditingController controller;
  final bool autofocus;
  final Color borderColor;

  Input(
      {required this.placeholder,
      required this.suffixIcon,
      //required this.prefixIcon,
      required this.onTap,
      required this.onChanged,
      this.autofocus = false,
      this.borderColor = LoginUIColors.border,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
        cursorColor: LoginUIColors.muted,
        onTap: (){},
        //onChanged: (){},
        controller: controller,
        autofocus: autofocus,
        style:
            const TextStyle(height: 0.85, fontSize: 14.0, color: LoginUIColors.info),
        textAlignVertical: const TextAlignVertical(y: 0.6),
        decoration: InputDecoration(
            filled: true,
            fillColor: LoginUIColors.white,
            hintStyle: const TextStyle(
              color: LoginUIColors.muted,
            ),
            suffixIcon: suffixIcon,
            //prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            hintText: placeholder));
  }
}
