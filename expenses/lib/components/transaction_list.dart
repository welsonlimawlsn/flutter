import 'dart:math';

import 'package:expenses/model/transaction.dart';
import 'package:expenses/util/brasil_util.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final void Function(Transaction transaction) onDeleteTransaction;

  const TransactionList({
    Key? key,
    required this.transactions,
    required this.onDeleteTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  FittedBox(
                    child: Text(
                      'Nenhuma transação cadastrada',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * .6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              var tx = transactions[index];
              return TransactionItem(
                key: GlobalObjectKey(tx),
                transaction: tx,
                onDeleteTransaction: onDeleteTransaction,
              );
            },
          );
  }
}

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final void Function(Transaction transaction) onDeleteTransaction;
  static const colors = [
    Colors.red,
    Colors.deepOrange,
    Colors.blue,
    Colors.purple,
    Colors.amber,
    Colors.cyan,
  ];

  TransactionItem({
    Key? key,
    required this.transaction,
    required this.onDeleteTransaction,
  }) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();

    _backgroundColor = _getBackgroundColor();
  }

  _getBackgroundColor() {
    print('escolhendo nova cor');
    var indexSelectedColor = Random().nextInt(TransactionItem.colors.length);
    return TransactionItem.colors[indexSelectedColor];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          //Theme.of(context).primaryColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                BrasilUtil.formatCurrencyWithoutSymbol(
                    widget.transaction.value),
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(BrasilUtil.formatLongDate(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton(
                onPressed: () => widget.onDeleteTransaction(widget.transaction),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).errorColor,
                ),
                child: Container(
                  height: 100,
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.delete),
                      Text('Excluir'),
                    ],
                  ),
                ),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => widget.onDeleteTransaction(widget.transaction),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
