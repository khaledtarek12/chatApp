import 'package:flutter/material.dart';

dynamic showSnackBar(
    {required BuildContext context,
    required String text,
    required IconData icon,
    required Color backColor,
    double? textSize}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: textSize ?? 15,
          ),
        ),
        Icon(
          icon,
          color: Colors.white,
          size: 40,
        )
      ],
    ),
    backgroundColor: backColor,
    duration: const Duration(seconds: 3),
  ));
}
