import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'model/music_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class PlayerScreen extends StatefulWidget {
  final MusicModel musicInfo;
  final int position;

  PlayerScreen({this.musicInfo, this.position});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AudioPlayer audioPlayer;
  AudioCache audioCache;
  String localFilePath;
  bool isPlaying = false;
  bool isFirstTime = true;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 50000),
      vsync: this,
    );
    _controller.repeat();
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    audioCache = null;
    audioPlayer.release();
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
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 54),
              child: CircularPercentIndicator(
                radius: 250,
                animation: true,
                percent: _position.inMilliseconds / _duration.inMilliseconds,
                lineWidth: 8,
                progressColor: Colors.indigo,
                backgroundColor: Colors.grey,
                animateFromLastPercent: true,
                center: Hero(
                  tag: '${widget.musicInfo.thumbnail}${widget.position}',
                  child: isPlaying
                      ? RotationTransition(
                          turns:
                              Tween(begin: 0.0, end: 1.0).animate(_controller),
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(
                              widget.musicInfo.thumbnail,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(
                            widget.musicInfo.thumbnail,
                          ),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Text(
                widget.musicInfo.songName,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              widget.musicInfo.singer,
              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 16),
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
                      child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                      onPressed: () async {
                        if (!isPlaying) {
                          isFirstTime
                              ? audioCache.play('audios/music.mp3')
                              : audioPlayer.resume();
                        } else {
                          audioCache.fixedPlayer.pause();
                        }

                        setState(() {
                          isPlaying = !isPlaying;
                          isFirstTime = false;
                        });
                      },
                    )),
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
                  Expanded(
                      child: Icon(
                    Icons.shuffle,
                    color: Colors.grey,
                  )),
                  Expanded(child: Icon(Icons.share)),
                  Expanded(child: Icon(Icons.bookmark)),
                  Expanded(
                      child: Icon(
                    Icons.repeat,
                    color: Colors.grey,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
