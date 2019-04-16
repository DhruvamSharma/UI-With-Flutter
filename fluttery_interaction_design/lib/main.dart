import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'dogs_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black,),
        canvasColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'NotoSans'
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin<MyHomePage>{

  TabController tabController;
  MaterialColor color = Colors.teal;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4)
    ..addListener(() {
      setState(() {
        switch (tabController.index) {
          case 0:
            color = Colors.teal;
            break;
          case 1:
            color = Colors.pink;
            break;
          case 2:
            color = Colors.blue;
            break;
          case 3:
            color = Colors.amber;
            break;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Stack(
        children: <Widget>[
          Container(
            child: Image.asset('assets/background.jpg', fit: BoxFit.cover, width: double.infinity, height: 300,),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(200),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text("My Pet Stories",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundImage: AssetImage('assets/dog3.jpg'),
                    ),
                  )
                ],
                bottom: TabBar(tabs: <Widget>[
                  Tab(icon: Icon(Icons.group, color: Colors.white,), text: 'List',),
                  Tab(icon: Icon(Icons.repeat, color: Colors.white,), text: 'Donate',),
                  Tab(icon: Icon(Icons.repeat, color: Colors.white,), text: 'Meet',),
                  //Tab(icon: Icon(Icons.repeat, color: Colors.white,), text: 'Adopt',),
                ],
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: color, width: 4.0),
                      insets: EdgeInsets.fromLTRB(80, 20, 80, 0)
                  ),
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                  labelColor: Colors.white,
                  unselectedLabelStyle: TextStyle(fontSize: 0),
                  controller: tabController,
                ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                color: Colors.white,
              ),
              child: TabBarView(children: <Widget>[
                DogsList(),
                DogsList(),
                Center(child: Text('my data 2')),
                Center(child: Text('my data 2')),
              ],
                controller: tabController,),
            ),
          ),
        ],
      ),
    );
  }
}

