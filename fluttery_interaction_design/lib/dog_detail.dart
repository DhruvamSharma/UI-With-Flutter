import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttery_interaction_design/dogs_list.dart';

class DogDetail extends StatelessWidget {
  DogDetail(this.model, this.position);
  final DogViewModel model;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.transparent,
          child: Hero(
            child: Image(
              image: AssetImage(model.assetImagePath),
              height: 300,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            tag: 'myHeroWidget$position',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(200),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
            ),
            body: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16),),
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                      ),
                      child: Text(
                        model.dogName,
                        style: TextStyle(fontSize: 46, letterSpacing: 1, fontWeight: FontWeight.w400),
                      ),
                    ),
                    GradientChips(
                      model: model,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 48,
                      ),
                      child: Swiper(

                        itemBuilder: (BuildContext context, int index) {
                          return MyVideosThumbnails(model: model, position: index);
                        },
                        itemHeight: 400,
                        itemCount: model.imageList.length,
                        itemWidth: 300.0,
                        layout: SwiperLayout.STACK,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}

class MyVideosThumbnails extends StatelessWidget {
  final DogViewModel model;
  final int position;
  MyVideosThumbnails({this.model, this.position});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          elevation: 16,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(
            model.imageList[position], fit: BoxFit.cover, width: 300, height: 400,),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('This is the title.\n And it is longer than',
                  style: TextStyle(
                    color: Colors.white, fontSize: 24,),
                  overflow: TextOverflow.clip,),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 30,
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          model.qualities[position],
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.indigo,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class GradientChips extends StatelessWidget {
  final DogViewModel model;
  GradientChips({this.model});
  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[];
    for (int i = 0; i < model.qualities.length; i++) {
      chips.add(Padding(
        padding: const EdgeInsets.only(top: 8, left: 16),
        child: Container(
          height: 30,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(
              model.qualities[i],
              style: TextStyle(color: Colors.white),
            ),
          )),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: [Colors.pink, Colors.indigo, Colors.teal]),
            //color: Colors.pink,
          ),
        ),
      ));
    }

    chips.add(
      SizedBox(
        width: 15,
      ),
    );

    chips.add(
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text('+12 more', style: TextStyle(color: Colors.indigo),),
      )
    );

    return Row(
      children: chips,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
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
