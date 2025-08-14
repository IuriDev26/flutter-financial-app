import 'package:financial/DTOs/transaction_chart.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final TransactionChart transaction;

  const ChartBar({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(transaction.value.toStringAsFixed(2)),
        SizedBox(height: 5),
        SizedBox(
          width: 10,
          height: 60,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                  color: Colors.black12,
                ),
              ),
              FractionallySizedBox(
                heightFactor: transaction.percentage,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(transaction.weekDayWord),
      ],
    );
  }
}
