import 'package:flutter/material.dart';

class DogDetail extends StatelessWidget {
  DogDetail(this.dogImage, this.position);
  final String dogImage;
  final int position;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150,
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            flexibleSpace: Hero(
                child: Image(image: AssetImage(dogImage),
                fit: BoxFit.fill,),
              tag: 'myHeroWidget$position',
            ),
          )
        ],
      ),
    );

  }

}