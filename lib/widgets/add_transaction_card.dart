import 'package:flutter/material.dart';

class AddTransactionCard extends StatefulWidget {
  final Function _addTransaction;

  AddTransactionCard(this._addTransaction);

  @override
  _AddTransactionCardState createState() => _AddTransactionCardState();
}

class _AddTransactionCardState extends State<AddTransactionCard> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void _submit() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if (title.isEmpty || amount <= 0) return;
    widget._addTransaction(title, amount);
    _titleController.clear();
    _amountController.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submit(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submit(),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: _submit,
            )
          ],
        ),
      ),
    );
  }
}
