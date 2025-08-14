import 'package:financial/DTOs/transaction_chart.dart';
import 'package:financial/components/chart_bar.dart';
import 'package:financial/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  List<TransactionChart> get transactions {
    if (recentTransactions.isEmpty) return [];

    List<TransactionChart> groupedTransactions = [];
    var amount = recentTransactions
        .map((transaction) => transaction.value)
        .toList()
        .reduce((value, element) => value + element);

    for (var transaction in recentTransactions) {
      String weekDayWork = DateFormat.E().format(transaction.date);
      var isIncluded = groupedTransactions.any(
        (transactionChart) => transactionChart.weekDayWord == weekDayWork,
      );

      if (!isIncluded) {
        groupedTransactions.add(
          TransactionChart(
            weekDayWord: weekDayWork,
            value: transaction.value,
            percentage: transaction.value / amount,
          ),
        );
      } else {
        groupedTransactions.firstWhere((tr) => tr.weekDayWord == weekDayWork);
      }
    }

    return groupedTransactions;
  }

  const Chart({super.key, required this.recentTransactions});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: transactions
          .map(
            (transaction) => ChartBar(
              transaction: TransactionChart(
                weekDayWord: transaction.weekDayWord,
                value: transaction.value,
                percentage: transaction.percentage,
              ),
            ),
          )
          .toList(),
    );
  }
}
