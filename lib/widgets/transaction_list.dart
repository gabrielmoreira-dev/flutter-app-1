import 'package:app1_expenses/model/transaction.dart';
import 'package:app1_expenses/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function removeTransaction;

  TransactionList(this._transactions, {this.removeTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: _transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No transactions added yet",
                  style: Theme.of(context).textTheme.display2,
                ),
                SizedBox(
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
              itemBuilder: (context, index) =>
                  TransactionCard(_transactions[index], removeTransaction: removeTransaction,),
              itemCount: _transactions.length,
            ),
    );
  }
}
