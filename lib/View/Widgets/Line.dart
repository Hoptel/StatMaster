import 'dart:math';

import 'package:flutter/material.dart';

///A line used to separate numbers in comparisons (15/20 for example)
class Line extends StatelessWidget {
  ///thickness of the line
  final double thickness;

  ///length of the line
  final double length;

  ///in degrees
  final double rotation;

  ///color of the line
  final Color color;

  Line({
    this.thickness = 1.0,
    this.length = 100.0,
    this.rotation = 0.0,
    this.color = const Color(0xff000000),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: length,
      height: thickness,
      transform: Matrix4.rotationZ(-(rotation / 180.0) * pi),
      color: color,
    );
  }
}
