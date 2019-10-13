import 'dart:math';

import 'package:flutter/material.dart';

class PageReveal extends StatelessWidget {
  final Widget child;
  final double revealPercent;

  PageReveal({this.child, this.revealPercent});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: child,
      clipper: MyCustomClipper(revealPercent),
    );
  }
}


class MyCustomClipper extends CustomClipper<Rect> {
  final double revealPercent;
  MyCustomClipper(this.revealPercent);

  @override
  Rect getClip(Size size) {
    final epicenter = Offset(size.width/2, size.height);

    //calculate the distance between the epicenter and the top left corner of the screen
    double theta = atan(epicenter.dy/ epicenter.dx);
    final distanceToCorner = epicenter.dy/ sin(theta);

    final radius = distanceToCorner * revealPercent;
    final diameter = radius * 2;

    return Rect.fromLTWH(epicenter.dx - radius, epicenter.dy- radius, diameter, diameter);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }

}