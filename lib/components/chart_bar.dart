import 'package:financial/DTOs/transaction_chart.dart';
import 'package:financial/components/chart_bar_components/amount.dart';
import 'package:financial/components/chart_bar_components/bar.dart';
import 'package:financial/components/chart_bar_components/week_day_label.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final TransactionChart transaction;

  const ChartBar({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var maxHeight = constraints.maxHeight;
        return Column(
          children: [
            Amount(height: maxHeight * 0.14, amount: transaction.value),
            SizedBox(height: maxHeight * 0.06),
            Bar(maxHeight: maxHeight * 0.6, percentage: transaction.percentage),
            SizedBox(height: maxHeight * 0.06),
            WeekDayLabel(
              height: maxHeight * 0.14,
              weekDayWord: transaction.weekDayWord,
            ),
          ],
        );
      },
    );
  }
}
