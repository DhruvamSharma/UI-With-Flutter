import 'package:flutter/material.dart';

class BankCardList extends StatelessWidget {

  final _bankNames = ['Yes Bank', 'Citi Bank', 'SBI Bank'];
  final _cardNumbers = ['XXX001233213XX', 'XXX001233213XX', 'XXX001233213XX'];
  final _cardHolder = ['Dhruvam', 'Karan', 'Ritvik'];

  @override
  Widget build(BuildContext context) {
    final _textStyle = TextStyle(
      color: Colors.white
    );
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, i) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(8),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20)
                  )
              ),
              color: Colors.pinkAccent,
              elevation: 0,
              child: ListTile(
                title: Text(_bankNames[i], style: _textStyle,),
                subtitle: Text(_cardNumbers[i], style: _textStyle,),
                trailing: Text(_bankNames[i], style: _textStyle,),
              ),
            ),
            Text('Last Three Transactions',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        );
      },
      childCount: _bankNames.length,
      ),
    );
  }
}