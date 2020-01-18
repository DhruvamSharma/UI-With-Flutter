import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'package:fluttery_music_player/second_screen_bloc.dart';

import 'bottom_list.dart';
import 'bottom_player_helper.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  ScrollController _scrollController = ScrollController();
  bool isAnimated = false;

  @override
  void initState() {
    super.initState();
  }

  void animateScrollOnClick() {
    _scrollController.animateTo(_scrollController.offset + 200,
        duration: Duration(milliseconds: 400),
        curve: Cubic(100, 100, 100, 100));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Ambient',
                            style:
                                Theme.of(context).textTheme.display3.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                          ),
                          Text(
                            '72 Listeners, created by Fatima',
                            style: Theme.of(context).textTheme.title.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SongListContainer(),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: StreamBuilder<bool>(
                stream: secondBloc.visibilityStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Visibility(
                      visible: snapshot.data,
                      child: BottomPlayerHelper(),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        ],
      ),
    );
  }

}

class SongListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(_sliverChildren()),
    );
  }

  List<Widget> _sliverChildren() {
    print('here');
    return [
      Animator(
        tween: Tween<Offset>(begin: Offset(0, 500), end: Offset(0, 0)),
        duration: Duration(milliseconds: 300),
        builder: (anim) => Transform.translate(
          offset: anim.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(100))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BottomList(),
                  )),
            ],
          ),
        ),
      ),
    ];
  }
}

