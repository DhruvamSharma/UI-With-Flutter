import 'package:flutter/material.dart';
import 'package:fluttery_bank/src/ui/home_screen/bank_card_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
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
            SliverList(
              delegate: SliverChildListDelegate(children)
              ,
            ),
            BankCardList(),
          ],
        ),
      ),
    );
  }
}
