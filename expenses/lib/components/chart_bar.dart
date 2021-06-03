import 'package:expenses/util/brasil_util.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({
    Key? key,
    required this.label,
    required this.value,
    required this.percentage,
  }) : super(key: key);

  // LayoutBuilder - pegar o tamanho do componente

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 15,
          child: FittedBox(
            child: Text(
              BrasilUtil.formatCurrencyWithoutSymbol(value),
            ),
          ),
        ),
        SizedBox(height: 5),
        Expanded(
          child: Container(
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(label.toUpperCase())
      ],
    );
  }
}
