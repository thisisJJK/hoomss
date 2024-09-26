import 'package:flutter/material.dart';

Widget hoomssTitle(double titleSize) {
  return Column(
    children: [
      Text(
        'HOOMSS',
        style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold),
      ),
      Text(
        'English',
        style: TextStyle(fontSize: titleSize/2, fontWeight: FontWeight.w300),
      ),
    ],
  );
}
