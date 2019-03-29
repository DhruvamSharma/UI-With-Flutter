import 'package:flutter/material.dart';
import 'package:fluttery_bank/src/ui/home_screen/bank_card_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluttery Bank',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.amber,
        fontFamily: 'NotoSans',
        brightness: Brightness.dark,
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Colors.white
          )
        ),
      ),
      home: MyHomePage(title: 'Fluttery Bank'),
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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var children = <Widget> [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Be slow to promise and quick to perform.',
          style: TextStyle(
            fontSize: 48,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ] ;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: () {

      },
          icon: Icon(Icons.airplanemode_active), label: Text('Add more')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/gray-sage-dark-marble-background.jpg'),
          fit: BoxFit.cover,
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
                padding: EdgeInsets.all(32),
            ),
//            SliverAppBar(
//              backgroundColor: Colors.transparent,
//              actions: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: MaterialButton(onPressed: () {
//
//                  },
//                    color: Colors.blue,
//                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                    child: Row(
//                      children: <Widget>[
//                        Icon(Icons.add, color: Colors.white,),
//                        Text('Add More'),
//                      ],
//                    ),
//                    elevation: 16,
//                  ),
//                ),
//              ],
//            ),
            SliverList(
              delegate: SliverChildListDelegate(children)
              ,
            ),
            BankCardList(),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
