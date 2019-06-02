import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'package:fluttery_music_player/second_screen_bloc.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    secondBloc.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Animator(
            tween: Tween<Offset>(begin: Offset(0,500), end: Offset(0, 0)),
            duration: Duration(milliseconds: 300),
            builder: (anim) => Transform.translate(
              offset: anim.value,
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 32),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Ambient',
                              style: Theme.of(context).textTheme.display3.copyWith(
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

                  Spacer(
                    flex: 1,
                  ),

                  Flexible(
                    flex: 8,
                    child: BottomList(),
                  ),
                ],
              ),
            ),
          ),

          StreamBuilder<bool>(
            stream: secondBloc.visibilityStream,
            builder: (context, snapshot) {
              return Visibility(
                visible: snapshot.data,
                child: _buildBottomContainer(),
              );
            }
          ),
        ],
      ),
    );
  }

  Widget _buildBottomContainer() {

    return Animator(
      tween: Tween<Offset>(begin: Offset(0, 10), end: Offset(0, 0)),
      duration: Duration(milliseconds: 100),
      builder: (anim) => Transform.translate(
        offset: anim.value,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: 100,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(icon: Icon(Icons.shopping_cart, color: Colors.white,), onPressed: () {}),
                IconButton(icon: Icon(Icons.shop, color: Colors.white,), onPressed: () {})
              ],
            ),
          ),
        ),
      ),

    );
  }
}

class BottomList extends StatefulWidget {
  @override
  _BottomListState createState() => _BottomListState();
}

class _BottomListState extends State<BottomList> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(100))
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, i) {
                    return ListTile(
                      onTap: () => secondBloc.show(),
                      leading: CircleAvatar(
                        child: Icon(Icons.description),
                      ),
                      title: Text('Live in forever', style: Theme.of(context).textTheme.title.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                      ),
                      subtitle: Text('In here'),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

