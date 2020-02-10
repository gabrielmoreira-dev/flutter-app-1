import 'package:app1_expenses/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Key key;
  final Transaction transaction;
  final Function removeTransaction;

  TransactionCard({
    this.key,
    @required this.transaction,
    @required this.removeTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                'R\$ ${transaction.amount.toStringAsFixed(2)}',
                style: theme.textTheme.display1,
              ),
            ),
          ),
        ),
        title: Text(transaction.title, style: theme.textTheme.display2),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
          style: theme.textTheme.display3,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: theme.errorColor,
          onPressed: () => removeTransaction(transaction.id),
        ),
      ),
    );
  }
}
