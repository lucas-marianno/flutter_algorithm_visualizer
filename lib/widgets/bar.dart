import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  const Bar(this.value, {this.color, super.key});
  final int value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: color ?? Colors.blue,
        height: value.toDouble(),
      ),
    );
  }
}
