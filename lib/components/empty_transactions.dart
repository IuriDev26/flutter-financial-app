import 'package:flutter/material.dart';

class EmptyTransactions extends StatelessWidget {
  const EmptyTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.attach_money),
        Text('Você ainda não adicionou nenhuma despesa'),
      ],
    );
  }
}
