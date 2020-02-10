import 'dart:io';
import 'package:app1_expenses/model/transaction.dart';
import 'package:app1_expenses/widgets/add_transaction_card.dart';
import 'package:app1_expenses/widgets/chat_card.dart';
import 'package:app1_expenses/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: ThemeData.light().textTheme.copyWith(
              display1: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
              display2: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              display3: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              button: TextStyle(color: Colors.white),
            ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  var _switchValue = true;

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    print('ok');
    setState(() {
      _transactions.add(Transaction(
        id: _transactions.length.toString(),
        title: title,
        amount: amount,
        date: date,
      ));
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _startAddTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: AddTransactionCard(this._addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _setSwitchState(bool value) {
    setState(() {
      _switchValue = value;
    });
  }

  List<Widget> _buildLandscapeContent(
      TransactionList transactionList, double appBarHeight) {
    final height = MediaQuery.of(context).size.height -
        appBarHeight -
        MediaQuery.of(context).padding.top;
    return [
      Container(
        height: height * 0.05,
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Show Chart'),
            Switch(
              value: _switchValue,
              onChanged: (value) => this._setSwitchState(value),
            ),
          ],
        ),
      ),
      _switchValue
          ? Container(
              height: height * 0.7,
              child: ChartCard(_recentTransactions),
            )
          : Container(
              height: height * 0.7,
              child: transactionList,
            )
    ];
  }

  List<Widget> _buildPortraitContent(
    TransactionList transactionList,
    double appBarHeight,
  ) {
    final height = MediaQuery.of(context).size.height -
        appBarHeight -
        MediaQuery.of(context).padding.top;
    return [
      Container(
        height: height * 0.3,
        child: ChartCard(_recentTransactions),
      ),
      Container(
        height: height * 0.7,
        child: transactionList,
      ),
    ];
  }

  Widget build(BuildContext context) {
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final _transactionList = TransactionList(
      _transactions,
      removeTransaction: this._removeTransaction,
    );
    final _appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => _startAddTransaction(context),
        ),
      ],
    );

    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (_isLandscape)
              ..._buildLandscapeContent(
                _transactionList,
                _appBar.preferredSize.height,
              ),
            if (!_isLandscape)
              ..._buildPortraitContent(
                _transactionList,
                _appBar.preferredSize.height,
              )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddTransaction(context),
      ),
    );
  }
}
