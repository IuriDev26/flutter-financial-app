import 'package:financial/DTOs/scrollable_child.dart';
import 'package:flutter/material.dart';

class Scrollable extends StatefulWidget {
  final List<ScrollableChild> fractionallyChildren;
  final double initialHeight;

  const Scrollable({
    super.key,
    required this.fractionallyChildren,
    this.initialHeight = 0,
  });

  @override
  State<Scrollable> createState() => _ScrollableState();
}

class _ScrollableState extends State<Scrollable> {
  double get availableHeight {
    return MediaQuery.of(context).size.height -
        widget.initialHeight;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: availableHeight,
        child: Column(
          children: widget.fractionallyChildren.map((child) {
            return SizedBox(
              height: availableHeight * child.heightFactor,
              child: child.child,
            );
          }).toList(),
        ),
      ),
    );
  }
}
