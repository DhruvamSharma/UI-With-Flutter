import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'model/music_model.dart';

class PlayerScreen extends StatefulWidget {
  final MusicModel musicInfo;
  final int position;

  PlayerScreen({this.musicInfo, this.position});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> with TickerProviderStateMixin{
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 50000),
      vsync: this,
    );
    _controller.repeat();
    super.initState();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Ambient'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 54),
              child: CircularPercentIndicator(
                radius: 250,
                animation: true,
                percent: 0.3,
                lineWidth: 8,
                progressColor: Colors.indigo,
                backgroundColor: Colors.grey,
                animateFromLastPercent: true,
                center: Hero(
                    tag: '${widget.musicInfo.thumbnail}${widget.position}',
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(widget.musicInfo.thumbnail,),
                      ),
                    )
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Text(
                widget.musicInfo.songName,
                style: TextStyle(fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              widget.musicInfo.singer,
              style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: 16
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 84),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.fast_rewind),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: FloatingActionButton(
                        backgroundColor: Colors.indigo,
                        child: Icon(Icons.play_arrow),
                        onPressed: null,
                      )
                    ),
                  ),
                  Icon(Icons.fast_forward),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: Icon(Icons.shuffle, color: Colors.grey,)),
                  Expanded(child: Icon(Icons.share)),

                  Expanded(child: Icon(Icons.bookmark)),
                  Expanded(child: Icon(Icons.repeat, color: Colors.grey,)),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
