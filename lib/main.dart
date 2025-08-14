import 'dart:math';

import 'package:financial/DTOs/transaction_chart.dart';
import 'package:financial/components/chart.dart';
import 'package:financial/components/chart_bar.dart';
import 'package:financial/components/transaction_form.dart';
import 'package:financial/components/transaction_list.dart';
import 'package:financial/models/transaction.dart';
import 'package:flutter/material.dart';

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
  final List<Transaction> _transactions = [
    Transaction(
      id: Random().nextDouble().toString(),
      title: 'Calção',
      value: 20,
      date: DateTime(2025, 08, 05),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: 'Roupa',
      value: 50,
      date: DateTime(2025, 08, 9),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: 'Cama',
      value: 27,
      date: DateTime(2025, 08, 12),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: 'Casaco',
      value: 38,
      date: DateTime(2025, 08, 13),
    ),
  ];

  _addTransaction(String title, double value) {
    var transaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(transaction);
    });

    Navigator.of(context).pop();
  }

  _openModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Financial',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: double.maxFinite,
          child: Column(
            children: [
              Chart(recentTransactions: _recentTransactions),
              SizedBox(
                width: double.infinity,
                child: Card(child: Text('Grafico')),
              ),
              TransactionList(transactions: _transactions),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openModal(context),
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
