import 'package:flutter/material.dart';

enum BarState { unselected, selected, onChange }

// ignore: must_be_immutable
class Bar extends StatefulWidget {
  Bar(this.value, {this.selected = false, super.key});
  final int value;
  bool selected;

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: widget.selected ? Colors.amber : Colors.blue,
        height: widget.value.toDouble(),
        margin: const EdgeInsets.symmetric(horizontal: 1),
      ),
    );
  }
}
