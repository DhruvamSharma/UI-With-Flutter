import 'package:flutter/material.dart';
import 'package:fluttery_interaction_design/page_reveal.dart';
import 'dogs_list.dart';
import 'package:animator/animator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
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

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin<MyHomePage>{

  TabController tabController;
  MaterialColor color = Colors.teal;
  bool firstIndex = true, secondIndex, thirdIndex;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3)
    ..addListener(() {
      setState(() {
        switch (tabController.index) {
          case 0:
            color = Colors.teal;
            firstIndex = true;
            secondIndex = false;
            thirdIndex = false;
            break;
          case 1:
            color = Colors.pink;
            firstIndex = false;
            secondIndex = true;
            thirdIndex = false;
            break;
          case 2:
            color = Colors.blue;
            firstIndex = false;
            secondIndex = false;
            thirdIndex = true;
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        PageReveal(revealPercent: 0.5, child: Container(
                          color: Colors.black,
                          width: double.infinity,
                          height: double.infinity,
                        ));
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundImage: AssetImage('assets/dog3.jpg'),
                      ),
                    ),
                  )
                ],
                bottom: TabBar(tabs: <Widget>[
                  Tab(icon: Icon(firstIndex == true ? null : Icons.group, color: Colors.white,), child: Animator(
                    tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -20)),
                    duration: Duration(milliseconds: 1000),
                    statusListener: (status, setup) {
                      if(status == AnimationStatus.completed) {
                        setup.controller.stop();
                      }
                    },
                    builder: (anim) => Transform.translate(
                      offset: anim.value,
                      child: Text('Up', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  )),
                  Tab(icon: Icon(secondIndex == true ? null : Icons.group, color: Colors.white,), child: Animator(
                    tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -20)),
                    duration: Duration(milliseconds: 1000),
                    statusListener: (status, setup) {
                      if(status == AnimationStatus.completed) {
                        setup.controller.stop();
                      }
                    },
                    builder: (anim) => Transform.translate(
                      offset: anim.value,
                      child: Text('Up', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  )),
                  Tab(icon: Icon(thirdIndex == true ? null : Icons.group, color: Colors.white,), child: Animator(
                    tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -20)),
                    duration: Duration(milliseconds: 1000),
                    statusListener: (status, setup) {
                      if(status == AnimationStatus.completed) {
                        setup.controller.stop();
                      }
                    },
                    builder: (anim) => Transform.translate(
                      offset: anim.value,
                      child: Text('Up', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  )),
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
                DogList(),
                DogList(),
                Center(child: Text('my data 2')),
              ],
                controller: tabController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

