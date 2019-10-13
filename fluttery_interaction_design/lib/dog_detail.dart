import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttery_interaction_design/dogs_list.dart';

class DogDetail extends StatefulWidget {
  DogDetail(this.model, this.position);
  final DogViewModel model;
  final int position;

  @override
  State<StatefulWidget> createState() {
    return DogDetailState();
  }
}

class DogDetailState extends State<DogDetail> {
  double opacityStart = 0, opacityEnd = 1;
  Offset translationStart = Offset(0, 30), translationEnd = Offset(0,0);
  bool backButtonPressed = false;
  int duration = 1000;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.transparent,
          child: Hero(
            child: Image(
              image: AssetImage(widget.model.assetImagePath),
              height: 300,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            tag: 'myHeroWidget${widget.position}',
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
                automaticallyImplyLeading: false,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white,),
                    onPressed: () {
                      setState(() {
                        double random = opacityStart;
                        opacityStart = opacityEnd;
                        opacityEnd = random;

                        Offset randomOffset = translationStart;
                        translationStart = translationEnd;
                        translationEnd = randomOffset;

                        duration = 400;

                        backButtonPressed = true;
                      });
                    }
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                   topRight: Radius.circular(16),
                   ),
                ),
                child: Animator(
                  tweenMap: {
                    'opacity': Tween<double>(begin: opacityStart, end: opacityEnd),
                    'translation': Tween<Offset>(begin: translationStart, end: translationEnd),
                  },
                  duration: Duration(milliseconds: duration),
                  statusListener: (status, setup) {
                    if(status == AnimationStatus.completed) {
                      setup.controller.stop();
                      if(backButtonPressed) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  repeats: 0,
                  cycles: 0,
                  builderMap: (Map<String, Animation> anim) => FadeTransition(
                    opacity: anim['opacity'],
                    child: Transform.translate(
                        offset: anim['translation'].value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 16,
                                left: 16,
                              ),
                              child: Text(
                                widget.model.dogName,
                                style: TextStyle(fontSize: 46, letterSpacing: 1, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 16,
                                left: 8,
                              ),
                              child: GradientChips(
                                model: widget.model,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 48,
                              ),
                              child: Swiper(

                                itemBuilder: (BuildContext context, int index) {
                                  return MyVideosThumbnails(model: widget.model, position: index);
                                },
                                itemHeight: 400,
                                itemCount: widget.model.imageList.length,
                                itemWidth: 300.0,
                                layout: SwiperLayout.STACK,
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ),
              ),
            ),
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
