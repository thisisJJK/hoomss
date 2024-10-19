import 'package:flutter/material.dart';

Widget hoomssTitle(double titleSize, BuildContext context) {
  return Column(
    children: [
      Text(
        'HOOMSS',
        style: TextStyle(
          fontSize: titleSize,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      Text(
        'English',
        style: TextStyle(
          fontSize: titleSize / 2,
          fontWeight: FontWeight.w300,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    ],
  );
}
