import 'package:app1_expenses/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction _transaction;
  final Function removeTransaction;

  TransactionCard(this._transaction, {@required this.removeTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                'R\$ ${_transaction.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ),
        ),
        title: Text(_transaction.title,
            style: Theme.of(context).textTheme.display2),
        subtitle: Text(
          DateFormat.yMMMd().format(_transaction.date),
          style: Theme.of(context).textTheme.display3,
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => removeTransaction(_transaction.id),
        ),
      ),
    );

  }
}
