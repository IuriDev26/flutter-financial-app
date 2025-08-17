import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final double maxHeight;
  final double percentage;

  const Bar({super.key, required this.maxHeight, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10,
      height: maxHeight,
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
            heightFactor: percentage,
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
    );
  }
}
