import 'package:app1_expenses/model/transaction.dart';
import 'package:app1_expenses/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function removeTransaction;

  TransactionList(this._transactions, {this.removeTransaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                "No transactions added yet",
                style: theme.textTheme.display2,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/img/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) => TransactionCard(
              key: ValueKey(_transactions[index].id),
              transaction: _transactions[index],
              removeTransaction: removeTransaction,
            ),
            itemCount: _transactions.length,
          );
  }
}
