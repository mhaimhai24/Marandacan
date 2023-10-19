
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  final TextAlign textAlign;

  AppLargeText({Key? key, this.size = 30, required this.text, this.color = Colors.black, this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
      textAlign: textAlign,
    );
  }
}
