import 'package:flutter/material.dart';
import 'package:fluttery_interaction_design/dog_detail.dart';

final dogs = [
  DogViewModel(assetImagePath: 'assets/dog2.jpg', dogName: 'Bhow', numberOfLikes: '3,23,457'),
  DogViewModel(assetImagePath: 'assets/dog1.jpg', dogName: 'Terry', numberOfLikes: '2,41,676'),
  DogViewModel(assetImagePath: 'assets/dog4.jpg', dogName: 'Shiels', numberOfLikes: '1,87,222'),
  DogViewModel(assetImagePath: 'assets/dog3.jpg', dogName: 'Tom', numberOfLikes: '8,43,453'),
];

class DogsList extends StatelessWidget {
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
                return DogDetail(dogs[position], position);
              }));
            },
            child: DogCard(model: dogs[position], position: position,),
          );
        },
      ),
    );
  }
}

class DogCard extends StatelessWidget {

  final DogViewModel model;
  final int position;
  DogCard({this.model, this.position});

  final textStyle =
  TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'NotoSans-Regular');

  final double _cardBorderRadius = 16;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'myHeroWidget$position',
            child: SingleChildScrollView(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(_cardBorderRadius),
                        bottomLeft:
                        Radius.circular(_cardBorderRadius))),
                margin: EdgeInsets.only(left: 48, top: 32, bottom: 32),
                elevation: 16,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  children: <Widget>[
                    Image(
                      image: AssetImage(model.assetImagePath),
                      fit: BoxFit.fill,
                      height: 200,
                      width: 400,
                    ),
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
                Text(
                  model.dogName,
                  style: textStyle,
                ),
                Text(
                  model.numberOfLikes,
                  style: textStyle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}

class DogViewModel {
  final String assetImagePath;
  final String dogName;
  final String numberOfLikes;

  DogViewModel({this.assetImagePath, this.dogName, this.numberOfLikes});
}
