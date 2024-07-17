import 'package:flutter/material.dart';

import '../constants.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatefulWidget {
  ButtonWidget({super.key, required this.text, required this.onTap});

  final String text;
  VoidCallback onTap;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(right: 8, left: 8, top: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: kButtonColor,
        ),
        child: Text(
          widget.text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
