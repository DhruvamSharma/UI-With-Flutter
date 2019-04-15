import 'package:flutter/material.dart';
import 'package:fluttery_interaction_design/dogs_list.dart';

class DogDetail extends StatelessWidget {
  DogDetail(this.model, this.position);
  final DogViewModel model;
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
                child: Image(image: AssetImage(model.assetImagePath),
                fit: BoxFit.fill,),
              tag: 'myHeroWidget$position',
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(<Widget>[
            Text(model.dogName, style: TextStyle(color: Colors.teal, fontSize: 32),),
          ]))
        ],
      ),
    );

  }

}

//class MyAnimatedContainer extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => MyAnimatedContainerState();
//
//}
//
//class MyAnimatedContainerState extends State<MyAnimatedContainer> with TickerProviderStateMixin<MyAnimatedContainer> {
//  AnimationController controller;
//
//  @override
//  void initState() {
//    super.initState();
//    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
//  }
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return PositionedTransition(
//        rect: Animation<>,
//        child: Text('My world'),
//    );
//  }
//}