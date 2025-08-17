import 'dart:math';

import 'package:financial/DTOs/scrollable_child.dart';
import 'package:financial/components/chart.dart';
import 'package:financial/components/transaction_form.dart';
import 'package:financial/components/transaction_list.dart';
import 'package:financial/models/transaction.dart';
import 'package:flutter/material.dart' hide Scrollable;
import 'package:financial/components/scrollable.dart';

main() => runApp(FinancialApp());

class FinancialApp extends StatelessWidget {
  const FinancialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white30,
          backgroundColor: Colors.blue[900],
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 13, 71, 161),
          primary: Colors.blue[900],
          secondary: Colors.white30,
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];
  bool shouldShowChart = false;

  _addTransaction(String title, double value, DateTime transactionDate) {
    var transaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: transactionDate,
    );

    setState(() => _transactions.add(transaction));

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  _openModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => TransactionForm(onFillForm: _addTransaction),
    );
  }

  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
          (transaction) => transaction.date.isAfter(
            DateTime.now().subtract(Duration(days: 7)),
          ),
        )
        .toList();
  }

  _showChart() {
    setState(() {
      shouldShowChart = !shouldShowChart;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    AppBar appBar = AppBar(
      title: Text(
        'Financial',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      actions: isLandscape
          ? [
              IconButton(
                onPressed: _showChart,
                icon: Icon(
                  !shouldShowChart ? Icons.show_chart_rounded : Icons.list_alt,
                  color: Colors.white,
                ),
              ),
            ]
          : null,
    );

    return Scaffold(
      appBar: appBar,
      body: Scrollable(
        initialHeight:
            appBar.preferredSize.height + MediaQuery.of(context).padding.top,
        fractionallyChildren: !isLandscape
            ? [
                ScrollableChild(
                  Chart(recentTransactions: _recentTransactions),
                  0.3,
                ),
                ScrollableChild(
                  TransactionList(
                    transactions: _transactions,
                    onDeleteTransaction: _deleteTransaction,
                  ),
                  0.7,
                ),
              ]
            : [
                shouldShowChart
                    ? ScrollableChild(
                        Chart(recentTransactions: _recentTransactions),
                        1,
                      )
                    : ScrollableChild(
                        TransactionList(
                          transactions: _transactions,
                          onDeleteTransaction: _deleteTransaction,
                        ),
                        1,
                      ),
              ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openModal(context),
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
