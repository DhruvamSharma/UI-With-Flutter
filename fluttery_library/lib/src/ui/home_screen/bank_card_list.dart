import 'package:flutter/material.dart';

class BankCardList extends StatelessWidget {
  final _bookNames = ['Black Coffee', 'Angels and Demons', 'The Big Fours'];

  @override
  Widget build(BuildContext context) {
    final _textStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    );

    final _textStyleSubtitle = TextStyle(
      color: Colors.black54,
      fontSize: 16,
    );
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(8),
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.white,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/gray-sage-dark-marble-background.jpg'),
                          radius: 24,
                        ),
                        title: Text(
                          _bookNames[i],
                          style: _textStyle,
                        ),
                        trailing: Icon(
                          Icons.today,
                          color: Colors.teal,
                        ),
                        onTap: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32, right: 32),
                        child: Text(
                          'By reading we enrich the mind; by conversation we polish it.',
                          style: _textStyleSubtitle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        childCount: 3,
      ),
    );
  }
}
