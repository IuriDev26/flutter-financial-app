import 'package:flutter/material.dart';

class WeekDayLabel extends StatelessWidget {
  final double height;
  final String weekDayWord;

  const WeekDayLabel({super.key, required this.height, required this.weekDayWord});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: FittedBox(child: Text(weekDayWord)),
    );
  }
}
