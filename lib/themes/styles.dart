import 'package:flutter/material.dart';

class Styles {
  static const TextStyle textTimeDisplay =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  static BoxDecoration boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.all(
      Radius.circular(10),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static const TextStyle titleStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
}
