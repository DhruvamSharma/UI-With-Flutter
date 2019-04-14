import 'package:flutter/material.dart';
import 'package:fluttery_interaction_design/dog_detail.dart';

class DogsList extends StatelessWidget {
  final dogImages = ['assets/dog4.jpg','assets/dog2.jpg','assets/dog3.jpg','assets/dog1.jpg'];
  final textStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 16
  );
  
  final double _cardBorderRadius = 16;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 16),
      child: ListView.builder(
        itemCount: 4,
          itemBuilder: (context, position) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DogDetail(dogImages[position], position);
                }));
              },
              child: Container(
                child: Column(
                  children: <Widget>[
                    Hero(
                      tag: 'myHeroWidget$position',
                      child: SingleChildScrollView(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(_cardBorderRadius), bottomLeft: Radius.circular(_cardBorderRadius))
                          ),
                          margin: EdgeInsets.only(left: 48,top: 32,bottom: 32),
                          elevation: 16,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: <Widget>[
                              Image(image: AssetImage(dogImages[position])),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 48),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('My Name', style: textStyle,),
                          Text('My Clicks', style: textStyle,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
      ),
    );
  }

}