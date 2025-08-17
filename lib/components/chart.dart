import 'package:financial/DTOs/transaction_chart.dart';
import 'package:financial/components/chart_bar.dart';
import 'package:financial/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  List<TransactionChart> get transactions {
    List<TransactionChart> groupedTransactions = [];

    for (var i = 0; i < 7; i++) {
      var weekDayWord = DateFormat.E().format(
        DateTime.now().subtract(Duration(days: i)),
      );

      groupedTransactions.add(
        TransactionChart(weekDayWord: weekDayWord, value: 0, percentage: 0),
      );
    }

    if (recentTransactions.isEmpty) return groupedTransactions;

    var amount = recentTransactions
        .map((transaction) => transaction.value)
        .toList()
        .reduce((value, element) => value + element);

    for (var transaction in recentTransactions) {
      String weekDayWord = DateFormat.E().format(transaction.date);

      var weekDayIndex = groupedTransactions.indexWhere(
        (transactionChart) => transactionChart.weekDayWord == weekDayWord,
      );

      groupedTransactions[weekDayIndex].percentage = transaction.value / amount;
      groupedTransactions[weekDayIndex].value += transaction.value;
    }

    return groupedTransactions.reversed.toList();
  }

  const Chart({super.key, required this.recentTransactions});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: constraints.maxHeight * 0.1,
                  horizontal: constraints.maxWidth * 0.03,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Last Days Expenses',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        height: constraints.maxHeight * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
