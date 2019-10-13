import 'package:animator/animator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttery_interaction_design/dog_detail.dart';

final dogs = [
  DogViewModel(
      assetImagePath: 'assets/dog2.jpg',
      dogName: 'Bhow',
      numberOfLikes: '3,23,457',
      qualities: [
        'caring and cool',
        'cool',
        'cute'
      ],
      imageList: [
        'assets/card_back3.jpg',
        'assets/card_back2.png',
        'assets/card_back1.jpg'
      ]),
  DogViewModel(
      assetImagePath: 'assets/dog1.jpg',
      dogName: 'Terry',
      numberOfLikes: '2,41,676',
      qualities: [
        'caring',
        'cool',
        'cute'
      ],
      imageList: [
        'assets/card_back2.png',
        'assets/card_back3.jpg',
        'assets/card_back1.jpg'
      ]),
  DogViewModel(
      assetImagePath: 'assets/dog4.jpg',
      dogName: 'Shiels',
      numberOfLikes: '1,87,222',
      qualities: [
        'caring',
        'cool',
        'cute'
      ],
      imageList: [
        'assets/card_back1.jpg',
        'assets/card_back2.png',
        'assets/card_back3.jpg'
      ]),
  DogViewModel(
      assetImagePath: 'assets/dog3.jpg',
      dogName: 'Tom',
      numberOfLikes: '8,43,453',
      qualities: [
        'caring',
        'cool',
        'cute'
      ],
      imageList: [
        'assets/card_back1.jpg',
        'assets/card_back3.jpg',
        'assets/card_back2.png'
      ]),
];

class DogList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DogsListState();
  }

}

class DogsListState extends State<DogList> {
  Offset startTween = Offset(0, 0), endTween = Offset(0,10);
  ScrollController controller;

  @override
  void initState() {
    controller = ScrollController(
      keepScrollOffset: true,
    )
    ..addListener(() {
      if(controller.position.userScrollDirection == ScrollDirection.forward) {
        print('down');
        setState(() {
          startTween = Offset(0, 10);
          endTween = Offset(0,20);
        });
      } else if(controller.position.userScrollDirection == ScrollDirection.reverse) {
        print('up');
        setState(() {
          startTween = Offset(0, 10);
          endTween = Offset(0,0);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 16),
      child: ListView.builder(
        itemCount: 4,
        controller: controller,
        scrollDirection: Axis.vertical,
        reverse: false,
        dragStartBehavior: DragStartBehavior.start,
        itemBuilder: (context, position) {
          return DogCard(
            model: dogs[position],
            position: position,
            startOffset: startTween,
            endOffset: endTween,
          );
        },
      ),
    );
  }
}

class DogCard extends StatefulWidget {
  final DogViewModel model;
  final int position;
  final Offset startOffset, endOffset;
  DogCard({this.model, this.position, this.startOffset, this.endOffset});
  @override
  State<StatefulWidget> createState() {
    return DogCardState();
  }
}

class DogCardState extends State<DogCard> {

  final textStyle = TextStyle(
      color: Colors.black, fontSize: 18, fontFamily: 'NotoSans-Regular');

  final double _cardBorderRadius = 16;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'myHeroWidget${widget.position}',
            child: SingleChildScrollView(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(_cardBorderRadius),
                        bottomLeft: Radius.circular(_cardBorderRadius))),
                margin: EdgeInsets.only(left: 48, top: 32, bottom: 32),
                elevation: 16,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Animator(
                  duration: Duration(milliseconds: 500),
                  tween: Tween<Offset>(begin: widget.startOffset, end: widget.endOffset,),
                  builder: (anim) => Transform.translate(
                    offset: anim.value,
                    child: AnimatedImage(widget.model, widget.position),
                  ),
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
                  widget.model.dogName,
                  style: textStyle,
                ),
                Text(
                  widget.model.numberOfLikes,
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

class AnimatedImage extends StatefulWidget {
  final DogViewModel model;
  final int position;
  AnimatedImage(this.model, this.position);
  @override
  State<StatefulWidget> createState() {
    //print(model);
    return AnimatedImageState();
  }
}

class AnimatedImageState extends State<AnimatedImage> {
  double x = 1, y = 1.2;
  int z = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          x = 1.2;
          y = 1;
          z = 200;
        });
      },
      child: Animator(
        tween: Tween<double>(begin: x, end: y),
        duration: Duration(milliseconds: z),
        statusListener: (status, setup) {
          if (status == AnimationStatus.completed) {
            setup.controller.stop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DogDetail(widget.model, widget.position);
            }));
          }
        },
        builder: (anim) => Transform.scale(
              scale: anim.value,
              child: Image(
                image: AssetImage(widget.model.assetImagePath),
                fit: BoxFit.fill,
                height: 200,
                width: 400,
              ),
            ),
      ),
    );
  }
}

class DogViewModel {
  final String assetImagePath;
  final String dogName;
  final String numberOfLikes;
  final List<String> qualities;
  final List<String> imageList;

  DogViewModel(
      {this.assetImagePath,
      this.dogName,
      this.numberOfLikes,
      this.qualities,
      this.imageList});
}
