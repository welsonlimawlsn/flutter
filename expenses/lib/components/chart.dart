import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/model/transaction.dart';
import 'package:expenses/util/brasil_util.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  double _sum(double v1, double v2) => v1 + v2;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var total = recentTransactions
          .where((element) => BrasilUtil.datesIsEqual(element.date, weekDay))
          .map((e) => e.value)
          .fold(0.0, _sum);

      return {
        'day': BrasilUtil.weekDay(weekDay)[0],
        'value': total,
      };
    });
  }

  double get _weekTotalValue {
    return groupedTransactions.map((e) => e['value'] as double)
        .reduce((value, element) => value > element ? value : element);
        //.fold(0.0, _sum);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.reversed
              .map(
                (e) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: e['day'].toString(),
                    value: e['value'] as double,
                    percentage: _weekTotalValue == 0
                        ? 0
                        : (e['value'] as double) / _weekTotalValue,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
