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
              return Card(
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                          child: Text(BrasilUtil.formatCurrencyWithoutSymbol(
                              tx.value))),
                    ),
                  ),
                  title: Text(
                    tx.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(BrasilUtil.formatLongDate(tx.date)),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? TextButton(
                          onPressed: () => onDeleteTransaction(tx),
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
                          onPressed: () => onDeleteTransaction(tx),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
          );
  }
}
