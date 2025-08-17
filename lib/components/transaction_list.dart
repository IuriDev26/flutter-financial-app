import 'package:financial/components/empty_transactions.dart';
import 'package:financial/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onDeleteTransaction;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.onDeleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? EmptyTransactions()
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              var transaction = transactions[index];
              return Card(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(width: 50, child: Icon(Icons.attach_money)),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "R\$ ${transaction.value.toStringAsFixed(2)}",
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                DateFormat('d MMM y').format(transaction.date),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () =>
                                  onDeleteTransaction(transaction.id),
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
