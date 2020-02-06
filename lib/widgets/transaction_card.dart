import 'package:app1_expenses/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction _transaction;

  TransactionCard(this._transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            child: Text(
              'R\$ ${_transaction.amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _transaction.title,
                style: Theme.of(context).textTheme.display2
              ),
              Text(
                DateFormat.yMMMd().format(_transaction.date),
                style: Theme.of(context).textTheme.display3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
