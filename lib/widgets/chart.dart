import '../widgets/bar_chart.dart';

import '../models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartWidget extends StatelessWidget {
  final List<Transactions> recentTransactions;
  ChartWidget(this.recentTransactions);

  double get amtPercentage {
    return recentTransactionGetter.fold(0.0, (sum, item) {
      return sum + item['totalAmount'];
    });
  }

  List<Map<String, Object>> get recentTransactionGetter {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].dt.day == weekDay.day &&
            recentTransactions[i].dt.month == weekDay.month &&
            recentTransactions[i].dt.year == weekDay.year) {
          totalSum += recentTransactions[i].amt;
        }
      }
      return {
        'weekday': DateFormat.E().format(weekDay),
        'totalAmount': totalSum,
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    print(recentTransactionGetter);
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: recentTransactionGetter.map((rTx) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: BarChart(
                    rTx['weekday'],
                    rTx['totalAmount'],
                    amtPercentage == 0.0
                        ? 0.0
                        : (rTx['totalAmount'] as double) / amtPercentage,
                  ),
                );
              }).toList(),
            ),
        ),
    );
  }
}
