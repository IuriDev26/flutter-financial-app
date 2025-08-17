import 'package:flutter/material.dart';

class Amount extends StatelessWidget {
  final double height;
  final double amount;

  const Amount({super.key, required this.height, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      height: height,
      child: FittedBox(
        child: Text('R\$ ${amount.toStringAsFixed(2)}'),
      ),
    );
  }
}
