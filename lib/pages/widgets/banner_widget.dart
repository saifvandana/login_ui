// ignore_for_file: unnecessary_const, deprecated_member_use

import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text.rich(
        const TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(text: "Lorem ipsum\n"),
            TextSpan(
              text: "New Sales",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )
            )
          ]
        )
      ),
    );
  }
}