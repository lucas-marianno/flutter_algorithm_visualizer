import 'package:flutter/material.dart';

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
    return Container(
      color: widget.selected ? Colors.amber : Colors.blue,
      height: widget.value.toDouble(),
      width: 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
    );
  }
}
