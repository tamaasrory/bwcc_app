import 'package:flutter/material.dart';

Widget richLable(context, String A, String B) {
  return RichText(
    text: TextSpan(
      style: TextStyle(
        fontSize: 14.0,
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      children: <TextSpan>[
        TextSpan(
          text: A,
        ),
        TextSpan(
          text: B,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ],
    ),
  );
}
