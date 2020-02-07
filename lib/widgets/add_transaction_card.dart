import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionCard extends StatefulWidget {
  final Function _addTransaction;

  AddTransactionCard(this._addTransaction);

  @override
  _AddTransactionCardState createState() => _AddTransactionCardState();
}

class _AddTransactionCardState extends State<AddTransactionCard> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submit() {
    final _title = _titleController.text;
    final _amount = _amountController.text.isEmpty
        ? 0
        : double.parse(_amountController.text);

    if (_title.isEmpty || _amount <= 0 || _selectedDate == null) return;
    widget._addTransaction(_title, _amount, _selectedDate);
    _titleController.clear();
    _amountController.clear();
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: mediaQuery.viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submit(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submit(),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _selectedDate == null
                          ? 'No Date Chosen'
                          : 'Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                    FlatButton(
                      textColor: theme.primaryColor,
                      child: const Text(
                        'Choose Date',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _showDatePicker,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: const Text('Add Transaction'),
                color: theme.primaryColor,
                textColor: theme.textTheme.button.color,
                onPressed: _submit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
