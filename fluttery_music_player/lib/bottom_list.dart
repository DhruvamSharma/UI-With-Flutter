import 'package:flutter/material.dart';
import 'package:fluttery_music_player/second_screen_bloc.dart';

import 'model/music_model.dart';
import 'player_screen.dart';

class BottomList extends StatefulWidget {
  @override
  _BottomListState createState() => _BottomListState();
}

class _BottomListState extends State<BottomList> {
  bool isClicked = false;
  ScrollController _scrollController = ScrollController();

  List<MusicModel> _musicList = [
    MusicModel('https://f4.bcbits.com/img/a2939269798_10.jpg', 'Elevator',
        '3:40', 'Barabas'),
    MusicModel(
        'https://is1-ssl.mzstatic.com/image/thumb/Music122/v4/de/77/39/de7739f3-a8ab-93d1-91c7-c4e3a4b632e7/886446291345.jpg/1200x630bb.jpg',
        'Shelana',
        '2:22',
        'Insecure'),
    MusicModel('https://m.media-amazon.com/images/I/81IBQNycOOL._SS500_.jpg',
        'Gary Barlow', '1:56', 'Finding everland'),
    MusicModel(
        'https://static1.squarespace.com/static/562add1fe4b00abcf44307b8/t/5bc098d7e2c4835e820fa616/1539348733329/ironbell_glorytogloy_albumart-copy.jpg',
        'IronMusic',
        '3:40',
        'Glory To Glory'),
    MusicModel(
        'https://is5-ssl.mzstatic.com/image/thumb/Music1/v4/ed/a3/22/eda322d7-1caf-a682-6d98-2566873aacd2/0617465594755.png/1200x630bb.jpg',
        'KYGO',
        '2:34',
        'ID'),
    MusicModel('https://f4.bcbits.com/img/a2939269798_10.jpg', 'Elevator',
        '3:40', 'Barabas'),
    MusicModel('https://f4.bcbits.com/img/a2939269798_10.jpg', 'Elevator',
        '3:40', 'Barabas'),
    MusicModel('https://f4.bcbits.com/img/a2939269798_10.jpg', 'Elevator',
        '3:40', 'Barabas'),
    MusicModel('https://f4.bcbits.com/img/a2939269798_10.jpg', 'Elevator',
        '3:40', 'Barabas'),
    MusicModel('https://f4.bcbits.com/img/a2939269798_10.jpg', 'Elevator',
        '3:40', 'Barabas'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ListView.builder(
              controller: _scrollController,
              //physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: _musicList.length,
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return PlayerScreen(position: i, musicInfo: _musicList[i]);
                    }));
                  },
                  leading: GestureDetector(
                      onTap: () {
                        if (!isClicked) {
                          secondBloc.show();
                        }
                        isClicked = false;
                      },
                      child: Hero(
                        tag: '${_musicList[i].thumbnail}$i',
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(_musicList[i].thumbnail),
                        ),
                      )),
                  title: Text(
                    _musicList[i].songName,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(_musicList[i].singer),
                );
              }),
        ],
      ),
    );
  }
}
