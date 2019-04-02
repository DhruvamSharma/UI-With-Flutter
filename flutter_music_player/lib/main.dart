import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          canvasColor: Colors.white,
          backgroundColor: Colors.white),
      home: Playlist(),
    );
  }
}

class Playlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }

}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.only(top: 50),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/sound_wave.jpg'),
                          fit: BoxFit.cover)),
                ),
                elevation: 32,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  'Someone Like You',
                  style: TextStyle(fontSize: 32),
                ),
              ),
              Text(
                '19, Adele',
                style: TextStyle(color: Colors.indigo),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 84),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: Icon(Icons.shuffle, color: Colors.grey,)),
                    Expanded(child: Icon(Icons.skip_previous)),
                    Expanded(
                      child: Center(
                        child: Icon(
                          Icons.play_circle_outline,
                          color: Colors.black,
                          size: 54,
                        ),
                      ),
                    ),
                    Expanded(child: Icon(Icons.skip_next)),
                    Expanded(child: Icon(Icons.repeat, color: Colors.grey,)),
                  ],
                ),
              ),
              Container(
                width: 500,
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/small_sound_wave.jpg'))
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
