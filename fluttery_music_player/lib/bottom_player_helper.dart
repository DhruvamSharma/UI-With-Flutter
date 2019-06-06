import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class BottomPlayerHelper extends StatefulWidget {
  @override
  _BottomPlayerHelperState createState() => _BottomPlayerHelperState();
}

class _BottomPlayerHelperState extends State<BottomPlayerHelper> {
  @override
  Widget build(BuildContext context) {
    return Animator(
      tween: Tween<Offset>(begin: Offset(0, 100), end: Offset(0, 0)),
      duration: Duration(milliseconds: 100),
      builder: (anim) => Transform.translate(
        offset: anim.value,
        child: BottomWidget(),
      ),
    );
  }
}

class BottomWidget extends StatefulWidget {
  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  double _width = 250;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius:
          BorderRadius.only(topLeft: Radius.circular(30))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _width = 700;
                });
              }),
          IconButton(
              icon: Icon(
                Icons.shop,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
    );
  }
}
