import 'package:app1_expenses/model/transaction.dart';
import 'package:app1_expenses/widgets/chart-bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartCard extends StatelessWidget {
  final List<Transaction> _transactions;

  ChartCard(this._transactions);

  List<Map<String, Object>> get transactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var transaction in _transactions) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          totalSum += transaction.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get totalSpeding {
    return transactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: transactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'],
                amount: data['amount'],
                pct: totalSpeding <= 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpeding,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
