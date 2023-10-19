import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  dynamic content; // Accept dynamic content (could be an image asset or text)

  ResponsiveButton({super.key, this.isResponsive = false, required this.width, required this.content});

  @override
  Widget build(BuildContext context) {
    if (content is String) {
      // If the content is a String, display it as text
      return Container(
        width: width,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.brown,
        ),
        child: Center(
          child: Text(
            content,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else if (content is String) {
      // If the content is a String, display it as an image asset
      return Container(
        width: width,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.brown,
        ),
        child: Center(
          child: Image.asset(content),
        ),
      );
    } else {
      // Handle other types as needed
      return const SizedBox.shrink();
    }
  }
}
