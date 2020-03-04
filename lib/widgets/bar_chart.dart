import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final String label;
  final double totalAmt;
  final double totalAmtPercentage;
  BarChart(this.label, this.totalAmt, this.totalAmtPercentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.1,
            child: FittedBox(
              child: Text('\₹${totalAmt.toStringAsFixed(2)}'),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.7,
            width: 15,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: (1 - totalAmtPercentage),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.1,
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    });
  }
}
