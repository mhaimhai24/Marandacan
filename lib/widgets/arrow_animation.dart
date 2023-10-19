import 'dart:async';

import 'package:flutter/material.dart';

class ArrowAnimation extends StatefulWidget {
  final double width;
  final double rotation;

  ArrowAnimation({required this.width, required this.rotation});

  @override
  _ArrowAnimationState createState() => _ArrowAnimationState();
}

class _ArrowAnimationState extends State<ArrowAnimation> {
  int imageIndex = 1;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        imageIndex = (imageIndex % 6) + 1; // Reset index when it reaches the end
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: widget.rotation * (3.14159265359 / 180), // Convert degrees to radians
        child: Image.asset(
          'assets/swipe-$imageIndex.png',
          width: widget.width,
          height: null,
        ),
      ),
    );
  }
}
