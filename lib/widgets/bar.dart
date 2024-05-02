import 'package:flutter/material.dart';

class Bar extends StatefulWidget {
  const Bar(this.value, {this.color, super.key});
  final int value;
  final Color? color;

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: widget.color ?? Colors.blue,
        height: widget.value.toDouble(),
        margin: const EdgeInsets.symmetric(horizontal: 1),
      ),
    );
  }
}
