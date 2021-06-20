import 'dart:io';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: Uuid().v4(),
    //   title: 'Novo tênis de Corrida',
    //   value: 310.76,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: Uuid().v4(),
    //   title: 'Novo tênis de Corrida',
    //   value: 100.76,
    //   date: DateTime.now().subtract(
    //     Duration(
    //       days: 1,
    //     ),
    //   ),
    // ),
    // Transaction(
    //   id: Uuid().v4(),
    //   title: 'Novo tênis de Corrida',
    //   value: 260.76,
    //   date: DateTime.now().subtract(
    //     Duration(
    //       days: 2,
    //     ),
    //   ),
    // ),
    // Transaction(
    //   id: Uuid().v4(),
    //   title: 'Novo tênis de Corrida',
    //   value: 150.76,
    //   date: DateTime.now().subtract(
    //     Duration(
    //       days: 2,
    //     ),
    //   ),
    // ),
  ];

  bool _showChart = false;

  void _addTransaction(String title, double value, DateTime date) {
    var transaction = createTransaction(title, value, date);
    setState(() {
      _transactions.add(
        transaction,
      );
    });

    Navigator.of(context).pop();
  }

  void _deleteTransaction(Transaction transaction) {
    setState(() {
      _transactions.remove(transaction);
    });
  }

  Transaction createTransaction(String title, double value, DateTime date) {
    return Transaction(
      id: Uuid().v4(),
      title: title,
      value: value,
      date: date,
    );
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransaction);
        },
        isScrollControlled: true);
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }


  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var isLandscape = mediaQuery.orientation == Orientation.landscape;
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); - set as orientações em que o app pode funcionar

    var appBar = AppBar(
      title: Text('Despesas Pessoais'),
      actions: [
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(_showChart ? Icons.list : Icons.pie_chart),
          ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    var availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // if (isLandscape)
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text('Exibir gráfico: '),
              //       Switch.adaptive( //se adapta tanto no ios, quanto no android
              //         activeColor: Theme.of(context).accentColor
              //         value: _showChart,
              //         onChanged: (newValue) {
              //           setState(() {
              //             _showChart = newValue;
              //           });
              //         },
              //       ),
              //     ],
              //   ),
              if (_showChart || !isLandscape)
                Container(
                  height: availableHeight * (isLandscape ? 0.7 : 0.25),
                  child: Chart(recentTransactions: _transactions),
                ),
              if (!_showChart || !isLandscape)
                Container(
                  height: availableHeight * (isLandscape ? 1 : 0.75),
                  child: TransactionList(
                    transactions: _transactions,
                    onDeleteTransaction: _deleteTransaction,
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _openTransactionFormModal(context),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
